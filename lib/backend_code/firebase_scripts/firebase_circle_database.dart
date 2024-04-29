import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import "firebase_init.dart";

class CircleDatabaseHandler{
  DatabaseReference dbUserReference = FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("circle");

  final _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  static String? generatedCode;

  Future<void> createCircle(String? uid, String? name, String? circleName, String? email, String? phone) async
  {
    generatedCode = codeGenerator(6);
    await dbUserReference.child(generatedCode!).child('members').child(uid!).set
      ({
      "circle_name": circleName,
      "name": name,
      "role": 'Circle Creator',
      "email": email,
      "phone": phone
    });

    print(generatedCode);
  }

  Future<void> addCircleMember(String circleCode, String? uid, String name, String circleName, String safetyStatus, String currentLocation, String email, String phone) async
  {
    await dbUserReference.child(circleCode).child('members').child(uid!).set
      ({
      "circle_name": circleName,
      "name": name,
      "role": 'Member',
      "safety_status": safetyStatus,
      "current_location": currentLocation,
      "email": email,
      "phone": phone
    });
  }

  Future<void> deleteCircleMember(String? uid, String circleCode) async
  {
    await dbUserReference.child(circleCode).child('members').child(uid!).remove();
  }

  Future<DataSnapshot> getCircleMember(String? uid, String circleCode) async
  {
    if(uid != null){
      return await dbUserReference.child(circleCode).child('members').child(uid).get();
    }
    else{
      return await dbUserReference.child(circleCode).child('members').get();
    }

  }

  String codeGenerator(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}