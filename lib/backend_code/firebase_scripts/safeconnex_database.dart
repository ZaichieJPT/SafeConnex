
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_authentication.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_init.dart';

/// SafeConnex Database System using the Firebase API
class SafeConnexCircleDatabase{
  // Gets the Reference of the Circle Database
  DatabaseReference _dbCircleReference = FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("circle");

  // Gets the Reference of the Users Database
  DatabaseReference _dbUserReference =  FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("users");

  // Creates a list of characters to be used to create a circle code
  final _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  // Instantiate the Random Class and assign it _rnd
  Random _rnd = Random();

  // Current Circle Code and the Circle Exception Reference
  static String? currentCircleCode;
  static String? circleException;
  static String? currentRole;

  // Variable to reference the generated code
  static String? generatedCode;

  // Circle that you want to join
  static Map<String, dynamic> circleToJoin = {};

  static List<Map<String, dynamic>> circleUsersData = [];
  static List<Map<String, dynamic>> circleList = [];
  static List<Map<String, dynamic>> circleDataList = [];
  static List<Map<String, dynamic>> circleDataValue = [];
  static List<Map<String, dynamic>> locationCircleData = [];
  static List<Map<String, String>> currentAddress = [];

  /// Generates a the code to be used by the circle
  String codeGenerator(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  /// Creates a Circle and places the creator as the "Circle Creator"
  Future<void> createCircle(String? circleName) async
  {
    // Assigns the value to the _generatedCode
    generatedCode = codeGenerator(6);

    // Sets the Circle Name in the database
    await _dbCircleReference.child(generatedCode!).set({
      "circle_name": circleName,
    });

    // Creates the circle members table and add information about the circle
    await _dbCircleReference.child(generatedCode!).child('members').child(SafeConnexAuthentication.currentUser!.uid).set
      ({
      "id": SafeConnexAuthentication.currentUser!.uid,
      "name": SafeConnexAuthentication.currentUser!.displayName,
      "role": 'Circle Creator',
      "email": SafeConnexAuthentication.currentUser!.email,
      "phone": "1",
      //"image": FirebaseProfileStorage.imageUrl
    });

    // Adds a list of the Circles to the User database
    await _dbUserReference.child(SafeConnexAuthentication.currentUser!.uid).child("circle_list").child(generatedCode.toString()).set
      ({
      "circleName": circleName,
      "circleCode": generatedCode
    });
    print(generatedCode);
  }

  /// Join the circle using the Circle Code
  Future<void> joinTheCircle() async
  {
    // Join the circle using the circle code
    await _dbCircleReference.child(SafeConnexCircleDatabase.circleToJoin["circle_code"]).child('members').child(SafeConnexAuthentication.currentUser!.uid).set
      ({
      "id": SafeConnexAuthentication.currentUser!.uid,
      "name": SafeConnexAuthentication.currentUser!.displayName,
      "role": 'Member',
      "circle_name": SafeConnexCircleDatabase.circleToJoin["circle_name"],
      "circle_code": SafeConnexCircleDatabase.circleToJoin["circle_code"],
      "email": SafeConnexAuthentication.currentUser!.email,
      "phone": "",
      //"image": FirebaseProfileStorage.imageUrl
    });

    // Adds the circle to the Users Circle lists
    await _dbUserReference.child(SafeConnexAuthentication.currentUser!.uid).child("circle_list").child(SafeConnexCircleDatabase.circleToJoin["circle_code"]).set
      ({
      "circleName": SafeConnexCircleDatabase.circleToJoin["circle_name"],
      "circleCode": SafeConnexCircleDatabase.circleToJoin["circle_code"]
    });
  }

  Future<void> getCircleToJoin(String circleCode) async {
    DataSnapshot snapshot = await _dbCircleReference.child(circleCode).get();
    bool isAMember = false;
    if(snapshot.exists){
      for(var id in snapshot.child("members").children){
        // if the database id is not the same as the currentUserId
        if(id.child("id").value == SafeConnexAuthentication.currentUser!.uid){
          isAMember = true;
        }
      }
      print("Member: $isAMember");
      if(isAMember == false){
        circleToJoin = {
          "circle_name": snapshot.child("circle_name").value.toString(),
          "circle_code": snapshot.key.toString(),
          "isAMember": false
        };
      }else{
        circleToJoin = {
          "circle_name": "",
          "circle_code": "",
          "isAMember": true
        };
      }
    }else{
      circleToJoin = {
        "circle_name": null,
        "circle_code": null,
      };
    }
  }

  Future<void> deleteCircleMember(String? uid, String circleCode) async
  {
    await _dbCircleReference.child(circleCode).child('members').child(uid!).remove();
  }

  Future<void> changeUsername(String username, String circleCode, String userId) async {
    await SafeConnexAuthentication.currentUser!.updateDisplayName(username);
    await _dbCircleReference.child(circleCode).child("members").child(userId).update({
      "name": username
    });
  }

  Future<void> changeCircleName(String circleName, String circleCode, String userId) async {
    await _dbCircleReference.child(circleCode).update({
      "circle_name": circleName
    });
    await _dbUserReference.child(userId).child("circle_list").child(circleCode).update({
      "circleName": circleName
    });

    print("Circle Name Updated");
  }

  Future<void> listCircleDataForSettings(String userId) async {
    DataSnapshot userSnapshot = await _dbUserReference.child(userId).child("circle_list").get();
    DataSnapshot circleSnapshot = await _dbCircleReference.get();

    if(circleDataList.isEmpty){
      // Creates an empty memberNames variables to be used later
      List<String> memberNames = [];
      List<String> userIds = [];
      // Gets the circle list from the User Database
      for(var circleList in userSnapshot.children){
        // Gets the circles in the Circle Database
        for(var circleData in circleSnapshot.children){
          // Compares the circle code of the User Database and Circle Database
          if(circleList.key == circleData.key){
            memberNames.clear();
            for (int index = 0; index < circleData.child("members").children.length; index++){
              memberNames.add(circleData.child("members").children.elementAt(index).child("name").value.toString());
              userIds.add(circleData.child("members").children.elementAt(index).child("name").value.toString());
            }
            circleDataList.add({
              "circleName": circleData.child("circle_name").value,
              "circleCode": circleData.key.toString(),
              "userIds": userIds.toList(),
              "names": memberNames.toList()
            });
          }
        }
      }
    }
    else{
      circleDataList.clear();
      List<String> memberNames = [];
      List<String> userIds = [];
      // Gets the circle list from the User Database
      for(var circleList in userSnapshot.children){
        // Gets the circles in the Circle Database
        for(var circleData in circleSnapshot.children){
          // Compares the circle code of the User Database and Circle Database
          if(circleList.key == circleData.key){
            memberNames.clear();
            for (int index = 0; index < circleData.child("members").children.length; index++){
              memberNames.add(circleData.child("members").children.elementAt(index).child("name").value.toString());
              userIds.add(circleData.child("members").children.elementAt(index).child("id").value.toString());
            }
            circleDataList.add({
              "circleName": circleData.child("circle_name").value,
              "circleCode": circleData.key.toString(),
              "userIds": userIds.toList(),
              "names": memberNames.toList()
            });
          }
        }
      }
    }
  }

  Future<void> getCircleList(String userId) async {
    DataSnapshot snapshot = await _dbUserReference.child(userId).child("circle_list").get();

    if(snapshot.children.isNotEmpty){
      if(circleList.isEmpty){
        for(var circles in snapshot.children){
          circleList.add({
            "circle_code": circles.key.toString(),
            "circle_name": circles.child("circleName").value.toString()
          });
        }
      }
      else{
        circleList.clear();
        for(var circles in snapshot.children){
          circleList.add({
            "circle_code": circles.key,
            "circle_name": circles.child("circleName").value
          });
        }
      }
      currentCircleCode = circleList[0]["circle_code"].toString();
      print(currentCircleCode);
    }else{
      currentCircleCode = "No Circle";
    }
  }

  Future<void> getCircleDataForLocation(String circleCode) async {
    DataSnapshot snapshot = await _dbCircleReference.child(circleCode).child("members").get();

    if(locationCircleData.isEmpty){
      for(var circleMembers in snapshot.children){
        locationCircleData.add({
          "id": circleMembers.child("id").value
        });
      }
    }
    else{
      locationCircleData.clear();
      for(var circleMembers in snapshot.children){
        locationCircleData.add({
          "id": circleMembers.child("id").value
        });
      }
    }
  }

  Future<void> getCircleRole(String circleCode, String userId) async{
    DataSnapshot snapshot = await _dbCircleReference.child(circleCode).get();
    if(snapshot.children.isNotEmpty){
      currentRole = snapshot.child("members").child(userId).child("role").value.toString();
    }
  }

  Future<void> getCircleData(String circleCode) async
  {
    DataSnapshot snapshot = await _dbCircleReference.child(circleCode).get();
    if(snapshot.children.isNotEmpty){
      if(circleDataValue.isEmpty){
        for(var user in snapshot.child("members").children){
          circleDataValue.add({
            "id": user.child("id").value,
            "email": user.child("email").value,
            "name": user.child("name").value,
            "phoneNumber": user.child("phone").value,
            "role": user.child("role").value,
            "image": user.child("image").value,
          });
        }
      }else{
        circleDataValue.clear();
        for(var user in snapshot.child("members").children){
          circleDataValue.add({
            "id": user.child("id").value,
            "email": user.child("email").value,
            "name": user.child("name").value,
            "phoneNumber": user.child("phone").value,
            "role": user.child("role").value,
            "image": user.child("image").value,
          });
        }
      }
    }

    //print("Geocode: ${circleDataValue[0]["geocode"]}");
  }

  Future<void> leaveCircle(String userId, String circleCode) async {
    // Transfer the Circle Creator to another user
    DataSnapshot snapshot = await _dbCircleReference.child(circleCode).child("members").get();
    print(snapshot.children.length);
    // Check if the childrens are greater than 1 or else just delete the circle
    if(snapshot.children.length > 1){
      print("There are more users");
      // Finds a valid ID and make sure that it does not match the current user ID
      // Checks the last and first of the children
      print(snapshot.children.first.child("id").value.toString());
      if(snapshot.children.first.child("id").value.toString() != userId){
        // Transfer to the accepted ID
        print("true");
        await _dbCircleReference.child(circleCode).child("members").child(snapshot.children.first.child("id").value.toString()).update({
          "role": "Circle Creator"
        });
      }else if(snapshot.children.last.child("id").value.toString() != userId){
        // Transfers to the accepted ID
        print("false");
        await _dbCircleReference.child(circleCode).child("members").child(snapshot.children.last.child("id").value.toString()).update({
          "role": "Circle Creator"
        });
      }
      else{
        await _dbCircleReference.child(circleCode).remove();
        await _dbUserReference.child(userId).child("circle_list").child(circleCode).remove();
      }
    }
    await _dbCircleReference.child(circleCode).child("members").child(userId).remove();
    await _dbUserReference.child(userId).child("circle_list").child(circleCode).remove();
  }

  Future<void> removeFromCircle(String userId, String circleCode) async {
    DataSnapshot snapshot = await _dbCircleReference.child(circleCode).child("members").child(userId).get();
    if(currentRole == "Circle Creator"){
      print("Snapshot Value: " + snapshot.child("role").value.toString());
      if(snapshot.child("role").value != "Circle Creator"){
        print("Circle Code: $circleCode");
        print("User ID: $userId");
        await _dbCircleReference.child(circleCode).child("members").child(userId).remove();
        await _dbUserReference.child(userId).child("circle_list").child(circleCode).remove();
      }
      else{
        print("Cant Remove Circle Creator");
      }
    }
  }
}

class SafeConnexFeedbackDatabase{
  DatabaseReference _dbFeedbackReference = FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("feedback");

  createFeedBack(String feedBack) async {
    final feedbackData = {
      'username': SafeConnexAuthentication.currentUser!.displayName,
      'userId': SafeConnexAuthentication.currentUser!.uid,
      'body': feedBack
    };

    final newFeedKey = _dbFeedbackReference.push().key;

    final Map<String, Map> updates = {};
    updates['/$newFeedKey'] = feedbackData;

    await _dbFeedbackReference.update(updates);

    print("Database Update Done");
  }
}

class SafeConnexGeofenceDatabase{
  DatabaseReference dbGeofenceReference = FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("geofence");

  static List<Map<String, dynamic>> geofenceData = [];
  static Map<String, dynamic> geofenceToUpdate = {};

  addGeofence(double latitude, double longitude, String radiusId, double radiusSize, String circleCode, String addressLabel){
    final geofence = <String, dynamic> {
      "id": SafeConnexAuthentication.currentUser!.uid,
      "latitude": latitude,
      "longitude": longitude,
      "radiusId": radiusId,
      "radiusSize": radiusSize,
      "addressLabel": addressLabel
    };

    if(geofenceToUpdate.isNotEmpty){
      print(geofenceToUpdate);
      deleteGeofence(circleCode);
    }
    dbGeofenceReference.child(circleCode).child(radiusId).set(geofence);
    print("Data Added on Geofence Collection");
  }

  deleteGeofence(String circleCode){
    dbGeofenceReference.child(circleCode).child(geofenceToUpdate['radiusId']).remove();
    print("Database Removed");
  }

  Future<void> getGeofence(String circleCode) async {
    dbGeofenceReference.child(circleCode).onValue.listen((DatabaseEvent event){
      final snapshot = event.snapshot;
      if(snapshot.exists){
        if(geofenceData.isEmpty){
          for(var data in snapshot.children)
          {
            geofenceData.add(<String, dynamic>{
              "id": data.child("id").value,
              "latitude":  data.child("latitude").value,
              "longitude":  data.child("longitude").value,
              "radiusId":  data.child("radiusId").value,
              "radiusSize":  data.child("radiusSize").value,
              "addressLabel":  data.child("addressLabel").value
            });
          }
        }else if(geofenceData.isNotEmpty){
          geofenceData.clear();
          for(var data in snapshot.children)
          {
            geofenceData.add(<String, dynamic>{
              "id": data.child("id").value,
              "latitude":  data.child("latitude").value,
              "longitude":  data.child("longitude").value,
              "radiusId":  data.child("radiusId").value,
              "radiusSize":  data.child("radiusSize").value,
              "addressLabel":  data.child("addressLabel").value
            });
          }
        }
      }
      else{
        print("No Data");
      }
    });
  }
}

class SafeConnexAgencyDatabase{
  DatabaseReference _dbAgencyReference = FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("agency");

  DatabaseReference _dbUserReference = FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("users");

  static String? selectedAgencyType;
  static Map<String, String> agencyData = {};
  static String? frontIdLink;
  static String? backIdLink;
  static String? selfieLink;

  Future<void> setAgencyData(String role, String agencyName, String locationOfAgency,
      String phoneNumber, String telephoneNumber, String emailAddress, String facebookLink,
      String agencyWebsite) async {
    agencyData = {
      "agencyRole": role,
      "agencyName": agencyName,
      "agencyLocation": locationOfAgency,
      "agencyPhoneNumber": phoneNumber,
      "agencyTelephoneNumber": telephoneNumber,
      "agencyEmailAddress": emailAddress,
      "facebookLink": facebookLink,
      "agencyWebsite": agencyWebsite
    };
  }

  Future<void> joinTheAgency() async {
    final selectedAgencySplit = selectedAgencyType!.split(' ');
    DataSnapshot snapshot = await _dbAgencyReference.child((selectedAgencySplit[0] + selectedAgencySplit[1]).toString()).child(agencyData["agencyName"]!.replaceAll(' ', '').toString()).get();
    if(selectedAgencyType != null) {
      if(snapshot.exists == false){
        await _dbAgencyReference.child((selectedAgencySplit[0] + selectedAgencySplit[1]).toString())
            .child(agencyData["agencyName"]!.replaceAll(' ', '').toString())
            .set({
          "agencyLocation": agencyData["agencyLocation"].toString(),
          "agencyPhoneNumber": agencyData["agencyPhoneNumber"].toString(),
          "agencyTelephoneNumber": agencyData["agencyTelephoneNumber"].toString(),
          "agencyEmailAddress": agencyData["agencyEmailAddress"].toString(),
          "facebookLink": agencyData["facebookLink"].toString(),
          "agencyWebsite": agencyData["agencyWebsite"].toString()
        });
      }

      await _dbAgencyReference.child((selectedAgencySplit[0] + selectedAgencySplit[1])).child(agencyData["agencyName"]!.replaceAll(" ", ""))
          .child("employees").child(SafeConnexAuthentication.currentUser!.uid).set({
        "role": agencyData["agencyRole"].toString()
      });

      await _dbUserReference.child(SafeConnexAuthentication.currentUser!.uid).update({
        "agencyType": selectedAgencyType!,
        "role": "Agency"
      });

    }else if(selectedAgencyType == null){
      print("selectedAgency is null");
    }
  }

  Future<void> getMyAgencyData(String agencyName) async {
    DataSnapshot userSnapshot = await _dbUserReference.child("agencyType").get();
    selectedAgencyType = userSnapshot.value.toString();

    DataSnapshot agencySnapshot = await _dbAgencyReference.child(selectedAgencyType!).child(agencyName).get();

    if(agencySnapshot.exists){
      if(agencyData.isEmpty){
        agencyData = {
          "agencyLocation": agencySnapshot.child(SafeConnexAuthentication.currentUser!.uid).child("agencyLocation").value.toString(),
          "agencyPhoneNumber": agencySnapshot.child(SafeConnexAuthentication.currentUser!.uid).child("agencyPhoneNumber").value.toString(),
          "agencyTelephoneNumber": agencySnapshot.child(SafeConnexAuthentication.currentUser!.uid).child("agencyTelephoneNumber").value.toString(),
          "agencyEmailAddress": agencySnapshot.child(SafeConnexAuthentication.currentUser!.uid).child("agencyEmailAddress").value.toString(),
          "facebookLink": agencySnapshot.child(SafeConnexAuthentication.currentUser!.uid).child("facebookLink").value.toString(),
          "agencyWebsite": agencySnapshot.child(SafeConnexAuthentication.currentUser!.uid).child("agencyWebsite").value.toString()
        };
      }else if(agencyData.isNotEmpty){
        agencyData.clear();
        agencyData = {
          "agencyLocation": agencySnapshot.child(SafeConnexAuthentication.currentUser!.uid).child("agencyLocation").value.toString(),
          "agencyPhoneNumber": agencySnapshot.child(SafeConnexAuthentication.currentUser!.uid).child("agencyPhoneNumber").value.toString(),
          "agencyTelephoneNumber": agencySnapshot.child(SafeConnexAuthentication.currentUser!.uid).child("agencyTelephoneNumber").value.toString(),
          "agencyEmailAddress": agencySnapshot.child(SafeConnexAuthentication.currentUser!.uid).child("agencyEmailAddress").value.toString(),
          "facebookLink": agencySnapshot.child(SafeConnexAuthentication.currentUser!.uid).child("facebookLink").value.toString(),
          "agencyWebsite": agencySnapshot.child(SafeConnexAuthentication.currentUser!.uid).child("agencyWebsite").value.toString()
        };
      }
    }else{
      print("Agency does not exist");
    }


  }
}

class SafeConnexSafetyScoringDatabase{
  DatabaseReference _dbSafetyScoreReference = FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("safety_score");

  static List<Map<String, dynamic>> safetyScoreData = [];
  static Map<String, dynamic> safetyScoreToUpdate = {};
  static String? geocodedStreet;

  Future<void> getGeocode(LatLng location) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(location.latitude, location.longitude);
    geocodedStreet = placemarks[0].street;
  }

  Future<void> addSafetyScore(double latitude, double longitude, double radiusSize, String riskLevel, String riskInfo) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

    final newSafetyScoreId = _dbSafetyScoreReference.push().key;

    final safetyScore = <String, dynamic> {
      "latitude": latitude,
      "longitude": longitude,
      "radiusId": newSafetyScoreId,
      "radiusSize": radiusSize,
      "locationName": placemarks[0].street,
      "riskInfo" : riskInfo,
      "riskLevel": riskLevel
    };

    if(safetyScoreToUpdate.isNotEmpty){
      print(safetyScoreToUpdate);
      deleteSafetyScore();
    }
    _dbSafetyScoreReference.child(newSafetyScoreId!).update(safetyScore);
    print("Data Added on SafetyScore Collection");
  }

  deleteSafetyScore(){
    _dbSafetyScoreReference.child(safetyScoreToUpdate['radiusId']).remove();
    print("Database Removed");
  }

  Future<void> getSafetyScore() async {
    _dbSafetyScoreReference.onValue.listen((DatabaseEvent event){
      final snapshot = event.snapshot;
      print(snapshot.value);
      if(snapshot.exists){
        if(safetyScoreData.isEmpty){
          for(var data in snapshot.children)
          {
            safetyScoreData.add(<String, dynamic>{
              "latitude":  data.child("latitude").value,
              "longitude":  data.child("longitude").value,
              "radiusId":  data.child("radiusId").value,
              "radiusSize":  data.child("radiusSize").value,
              "locationName": data.child("locationName").value,
              "riskInfo": data.child("riskInfo").value,
              "riskLevel": data.child("riskLevel").value
            });
          }
        }else if(safetyScoreData.isNotEmpty){
          safetyScoreData.clear();
          for(var data in snapshot.children)
          {
            safetyScoreData.add(<String, dynamic>{
              "latitude":  data.child("latitude").value,
              "longitude":  data.child("longitude").value,
              "radiusId":  data.child("radiusId").value,
              "radiusSize":  data.child("radiusSize").value,
              "locationName": data.child("locationName").value,
              "riskInfo": data.child("riskInfo").value,
              "riskLevel": data.child("riskLevel").value
            });
          }
        }
      }
      else{
        print("No Data");
      }
    });
  }
}