import 'package:firebase_database/firebase_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_auth.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_user.dart';
import "firebase_init.dart";

class UserDatabaseHandler {
  // DB references list
  DatabaseReference dbUserReference = FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("users");
  late bool circleExists = false;
  Map<String, String> circleData = <String, String>{};
  Map<String, dynamic> userData = <String, String>{};

  Future<void> getCurrentCircle(String? uid, String? circleCode) async {
    DataSnapshot snapshot = await dbUserReference.child(uid!).child("circle_list").child(circleCode.toString()).get();
    circleData["circle_name"] = snapshot.child('circleName').value.toString();
    circleData["circle_code"] = snapshot.ref.parent!.key.toString();
  }

  Future<void> getAllCircle(String? uid, String? circleCode) async {
    DataSnapshot snapshot = await dbUserReference.child(uid!).child("circle_list").get();
    print(snapshot.value);
  }

  Future<void> getRegularUser(String? uid) async {
    final snapshot = await dbUserReference.child(uid!).get();
    if(snapshot.exists){
      userData = {
        "birthday": snapshot.child("birthday").value,
        "role": snapshot.child("role").value
      };
    }
  }

  /// Gets the User from the database and 
  //Future<void> getRegularUser(String? uid) async
  //{
    // Gets the data from the database using the uid identifier
    //final snapshot = await dbUserReference.child(uid!).get();
    //if (snapshot.exists) {
      // Format snapshot.child("<database collection>").value
      // Map the data to the UI
      //if(snapshot.child("circleCode").value != null){
        //circleExists = true;
      //}
    //}
    //else {
      // Run Error to the UI the account data does not exist
      //print("No Data");
    //}
  //}
}
