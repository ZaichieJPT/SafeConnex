import 'package:firebase_database/firebase_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_user.dart';
import "firebase_init.dart";

class UserDatabaseHandler {
  // DB references list
  DatabaseReference dbUserReference = FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("users");

  /// Adds a user data to the database using the [uid] as the Identication
  /// [birthday] and [role] are the contents of the Collection
  Future<void> addRegularUser(String? uid, String birthday, String role) async
  {
    // Gets the Collection using the uid parameter
    await dbUserReference.child(uid!).set
      ({
      "birthday": birthday,
      "role": role
    });
    // Delete this in Production
    print("Data Added");
  }

  /// Gets the User from the database and 
  Future<void> getRegularUser() async
  {
    // Gets the data from the database using the uid identifier
    final snapshot = await dbUserReference.child(
        FirebaseUserCredentials.userCredential.user!.uid).get();
    if (snapshot.exists) {
      // Format snapshot.child("<database collection>").value
      // Map the data to the UI
      print(snapshot.value);
    }
    else {
      // Run Error to the UI the account data does not exist
      print("No Data");
    }
  }
}
