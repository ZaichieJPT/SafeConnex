import 'dart:ffi';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_auth.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_coordinates_store.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_profile_storage.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_users_database.dart';
import "firebase_init.dart";

class CircleDatabaseHandler{
  DatabaseReference dbCircleReference = FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("circle");
  DatabaseReference dbUserReference =  FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("users");

  final _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  String tempCircleCode = "";
  static String? generatedCode;
  static String? circleException;
  static List<Map<String, dynamic>> circleUsersData = [];
  static List<Map<String, dynamic>> circleList = [];
  static List<Map<String, dynamic>> circleDataList = [];
  static List<Map<String, dynamic>> circleDataValue = [];
  static List<Map<String, dynamic>> locationCircleData = [];
  static Map<String, dynamic> circleToJoin = {};
  static String? currentCircleCode;
  static List<Map<String, String>> currentAddress = [];

  void createCircleWithName(String circleName, BuildContext context, Widget Screen){
    //createCircle(
        //AppManager.authHandler.authHandler.currentUser!.uid,
        //AppManager.authHandler.authHandler.currentUser!.displayName,
        //circleName,
        //AppManager.authHandler.authHandler.currentUser!.email,
        //AppManager.authHandler.authHandler.currentUser!.phoneNumber
    //);
    Future.delayed(Duration(milliseconds: 1500), (){
      //PageNavigator(context, Screen);
    });
  }

  Future<void> createCircle(String? uid, String? name, String? circleName, String? email, String? phone) async
  {
    generatedCode = codeGenerator(6);
    await dbCircleReference.child(generatedCode!).set({
      "circle_name": circleName,
    });
    await dbCircleReference.child(generatedCode!).child('members').child(uid!).set
      ({
      "id": uid,
      "name": name,
      "role": 'Circle Creator',
      "email": email,
      "phone": phone,
      "image": FirebaseProfileStorage.imageUrl
    });
    await dbUserReference.child(uid).child("circle_list").child(generatedCode.toString()).set
      ({
      "circleName": circleName,
      "circleCode": generatedCode
    });

    print("Inside the Create Circle");
    print(generatedCode);
  }

  void getJoinCircleData(String circleCode, GlobalKey<FormState> joinCircleKey, BuildContext context, Widget Screen){
    getCircleToJoin(circleCode, "uid");
    getCircleData(circleCode);
    Future.delayed(Duration(milliseconds: 1500), () {
      if (joinCircleKey.currentState!.validate()) {
        //PageNavigator(context, Screen);
      }
    });
  }

  void joinCircle(BuildContext context, Widget Screen){
    /*addCircleMember(
        circleToJoin["circle_code"].toString(),
        //AppManager.authHandler.authHandler.currentUser!.uid,
        //AppManager.authHandler.authHandler.currentUser!.displayName.toString(),
        circleToJoin["circle_name"].toString(),
        //AppManager.authHandler.authHandler.currentUser!.email.toString(),
        "+639 51 280 7552"
    );*/
    //PageNavigator(context, Screen);
  }

  Future<void> addCircleMember(String circleCode, String? uid, String name, String circleName, String email, String phone) async
  {
    DataSnapshot snapshot = await dbCircleReference.child(circleCode).get();
    if(snapshot.exists){
      await dbCircleReference.child(circleCode).child('members').child(uid!).set
        ({
        "id": uid,
        "name": name,
        "role": 'Member',
        "email": email,
        "phone": phone,
        "image": FirebaseProfileStorage.imageUrl
      });

      await dbUserReference.child(uid).child("circle_list").child(circleCode).set
        ({
        "circleName": circleName,
        "circleCode": circleCode
      });
    }
    else{
      circleException = "Circle does not exist";
    }
  }

  Future<void> deleteCircleMember(String? uid, String circleCode) async
  {
    await dbCircleReference.child(circleCode).child('members').child(uid!).remove();
  }

  Future<void> changeUsername(String username, String circleCode, String userId) async {
    //await AppManager.authHandler.authHandler.currentUser!.updateDisplayName(username);
    await dbCircleReference.child(circleCode).child("members").child(userId).update({
      "name": username
    });
  }

  Future<void> changeCircleName(String circleName, String circleCode, String userId) async {
    await dbCircleReference.child(circleCode).update({
      "circle_name": circleName
    });
    await dbUserReference.child(userId).child("circle_list").child(circleCode).update({
        "circleName": circleName
      });

    print("Circle Name Updated");
  }

  Future<void> getCircleToJoin(String circleCode, String userId) async {
    DataSnapshot snapshot = await dbCircleReference.child(circleCode).get();
    bool isAMember = false;
    if(snapshot.exists){
      for(var id in snapshot.child("members").children){
        // if the database id is not the same as the currentUserId
        if(id.child("id").value == userId){
          isAMember = true;
        }
      }

      if(isAMember == false){
        circleToJoin = {
          "circle_name": snapshot.child("circle_name").value.toString(),
          "circle_code": snapshot.key.toString(),
          "isAMember": false
        };
      }else{
        circleToJoin = {
          "isAMember": true
        };
      }


    }else{
      print("Circle Does not exist");
    }
  }

  Future<void> listCircleDataForSettings(String userId, String circleCode) async {
    DataSnapshot snapshot = await dbCircleReference.child(circleCode).get();

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
    DataSnapshot snapshot = await dbUserReference.child(userId).child("circle_list").get();

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
    }
  }

  Future<void> getCircleDataForLocation(String circleCode) async {
    DataSnapshot snapshot = await dbCircleReference.child(circleCode).child("members").get();

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
    DataSnapshot snapshot = await dbCircleReference.child(circleCode).get();
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
    await dbCircleReference.child(circleCode).child("members").child(userId).remove();
    await dbUserReference.child(userId).child("circle_list").child(circleCode).remove();
  }

  String codeGenerator(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}