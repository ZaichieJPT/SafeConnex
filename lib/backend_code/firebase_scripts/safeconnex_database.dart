
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
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

  Future<void> listCircleDataForSettings(String userId, String circleCode) async {
    DataSnapshot snapshot = await _dbCircleReference.child(circleCode).get();

    if(circleDataList.isEmpty){
      for(var circleDatas in snapshot.children){
        List<String> memberNames = [];
        for(var memberName in snapshot.child("members").children){
          memberNames.add(memberName.child("name").value.toString());
        }
        circleDataList.add({
          "circleName": circleDatas.child("circle_name").value,
          "circleCode": circleDatas.key.toString(),
          "names": memberNames
        });
      }
    }
    else{
      circleDataList.clear();
      for(var circleDatas in snapshot.children){
        List<String> memberNames = [];
        for(var memberName in snapshot.child("members").children){
          memberNames.add(memberName.child("name").value.toString());
        }
        circleDataList.add({
          "circleName": circleDatas.child("circle_name").value,
          "circleCode": circleDatas.key.toString(),
          "names": memberNames
        });
      }
    }

    print("Data: ${circleDataList}");
  }

  Future<void> getCircleList(String userId) async {
    DataSnapshot snapshot = await _dbUserReference.child(userId).child("circle_list").get();

    if(snapshot.children.isNotEmpty){
      if(circleList.isEmpty){
        for(var circles in snapshot.children){
          circleList.add({
            "circle_code": circles.key,
            "circle_name": circles.child("circleName").value
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
    await _dbCircleReference.child(circleCode).child("members").child(userId).remove();
    await _dbUserReference.child(userId).child("circle_list").child(circleCode).remove();
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