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
  static String? circleException;
  static Map<String, String> circleData = <String, String>{};

  Future<void> createCircle(String? uid, String? name, String? circleName, String? email, String? phone) async
  {
    generatedCode = codeGenerator(6);
    await dbUserReference.child(generatedCode!).set({
      "circle_name": circleName,
    });
    await dbUserReference.child(generatedCode!).child('members').child(uid!).set
      ({
      "name": name,
      "role": 'Circle Creator',
      "email": email,
      "phone": phone
    });

    print("Inside the Create Circle");
    print(generatedCode);
  }

  Future<void> addCircleMember(String circleCode, String? uid, String name, String circleName, String email, String phone) async
  {
    DataSnapshot snapshot = await dbUserReference.child(circleCode).get();
    if(snapshot.exists){
      await dbUserReference.child(circleCode).child('members').child(uid!).set
        ({
        "name": name,
        "role": 'Member',
        "email": email,
        "phone": phone
      });
    }
    else{
      circleException = "Circle does not exist";
    }
  }

  Future<void> deleteCircleMember(String? uid, String circleCode) async
  {
    await dbUserReference.child(circleCode).child('members').child(uid!).remove();
  }

  Future<void> getCircle(String? uid, String circleCode) async
  {
    DataSnapshot snapshot = await dbUserReference.child(circleCode).get();
    circleData['circle_name'] = snapshot.child("circle_name").value.toString();
    circleData['circle_code'] = snapshot.key.toString();
  }

  String codeGenerator(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
