import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:latlong2/latlong.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_coordinates_store.dart';
import 'package:safeconnex/backend_code/geocode_coordinates.dart';
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
  static List<Map<String, dynamic>> circleUsersData = [];
  FlutterFireCoordinates flutterFireMap = FlutterFireCoordinates();

  CircleDatabaseHandler(){
    flutterFireMap.getCoordinates();
  }

  Future<void> createCircle(String? uid, String? name, String? circleName, String? email, String? phone) async
  {
    generatedCode = codeGenerator(6);
    await dbUserReference.child(generatedCode!).set({
      "circle_name": circleName,
    });
    await dbUserReference.child(generatedCode!).child('members').child(uid!).set
      ({
      "id": uid,
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
        "id": uid,
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

  Future<void> getCircle(String circleCode) async
  {
    DataSnapshot snapshot = await dbUserReference.child(circleCode).get();
    circleData['circle_name'] = snapshot.child("circle_name").value.toString();
    circleData['circle_code'] = snapshot.key.toString();
    int index = 0;

    for(var user in snapshot.child("members").children){
      index++;
      circleUsersData.add({
        "id": user.child("id").value,
        "email": user.child("email").value,
        "name": user.child("name").value,
        "phoneNumber": user.child("phone").value,
        "role": user.child("role").value,
      });
    }
  }

  String codeGenerator(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
