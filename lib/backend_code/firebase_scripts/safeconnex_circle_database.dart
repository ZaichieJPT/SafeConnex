
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
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
  String? currentCircleCode;
  String? circleException;
  String? currentRole;

  // Variable to reference the generated code
  String? generatedCode;

  // Circle that you want to join
  Map<String, dynamic> circleToJoin = {};

  List<Map<String, dynamic>> circleUsersNames = [];
  List<Map<String, dynamic>> circleList = [];
  List<Map<String, dynamic>> circleDataList = [];
  List<Map<String, dynamic>> circleDataValue = [];
  List<Map<String, dynamic>> locationCircleData = [];
  List<Map<String, String>> currentAddress = [];

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
    await _dbCircleReference.child(generatedCode!).child('members').child(DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.uid).set
      ({
      "id": DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.uid,
      "name": DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.displayName,
      "role": 'Circle Creator',
      "email": DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.email,
      "phone": "1",
      //"image": FirebaseProfileStorage.imageUrl
    });

    // Adds a list of the Circles to the User database
    await _dbUserReference.child(DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.uid).child("circle_list").child(generatedCode.toString()).set
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
    await _dbCircleReference.child(DependencyInjector().locator<SafeConnexCircleDatabase>().circleToJoin["circle_code"]).child('members').child(DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.uid).set
      ({
      "id": DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.uid,
      "name": DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.displayName,
      "role": 'Member',
      "circle_name": circleToJoin["circle_name"],
      "circle_code": circleToJoin["circle_code"],
      "email": DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.email,
      "phone": "",
      //"image": FirebaseProfileStorage.imageUrl
    });

    // Adds the circle to the Users Circle lists
    await _dbUserReference.child(DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.uid).child("circle_list").child(DependencyInjector().locator<SafeConnexCircleDatabase>().circleToJoin["circle_code"]).set
      ({
      "circleName": circleToJoin["circle_name"],
      "circleCode": circleToJoin["circle_code"]
    });
  }

  Future<void> getCircleToJoin(String circleCode) async {
    DataSnapshot snapshot = await _dbCircleReference.child(circleCode).get();
    bool isAMember = false;
    if(snapshot.exists){
      for(var id in snapshot.child("members").children){
        // if the database id is not the same as the currentUserId
        if(id.child("id").value == DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.uid){
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
    await DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.updateDisplayName(username);
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

          circleUsersNames.add({
            "name": user.child("name").value,
            "id": user.child("id").value,
          });
        }
      }else{
        circleDataValue.clear();
        circleUsersNames.clear();
        for(var user in snapshot.child("members").children){
          circleDataValue.add({
            "id": user.child("id").value,
            "email": user.child("email").value,
            "name": user.child("name").value,
            "phoneNumber": user.child("phone").value,
            "role": user.child("role").value,
            "image": user.child("image").value,
          });
          circleUsersNames.add({
            "name": user.child("name").value,
            "id": user.child("id").value,
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







