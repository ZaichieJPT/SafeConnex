import 'package:firebase_database/firebase_database.dart';
import "firebase_init.dart";

class SafetyScoringDatabaseHandler{
  DatabaseReference dbUserReference = FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("safety_scoring");
}