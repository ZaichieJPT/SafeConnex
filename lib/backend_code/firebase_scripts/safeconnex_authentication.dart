import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_notification.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_storage.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_init.dart';

/// SafeConnex Authentication System using the Firebase API
class SafeConnexAuthentication{
  // Initialize the Firebase Auth Handler
  final FirebaseAuth _authHandler = FirebaseAuth.instance;

  // Database Reference for the Users Database
  final DatabaseReference _dbUserReference = FirebaseDatabase.instanceFor(
      //Keep the FirebaseInit or not?
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("users");

  // Database Reference for the Agency Database
  final DatabaseReference _dbAgencyReference = FirebaseDatabase.instanceFor(
    //Keep the FirebaseInit or not?
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("agency");

  // Database Reference for the Circle Database
  final DatabaseReference _dbCircleReference = FirebaseDatabase.instanceFor(
    //Keep the FirebaseInit or not?
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("circle");

  static User? currentUser;
  static String? signUpException;
  static String? loginException;
  static Map<String, String> userData = {};
  static Map<String, String> agencyData = {};

  SafeConnexCircleDatabase circleDatabase = SafeConnexCircleDatabase();
  SafeConnexProfileStorage profileStorage = SafeConnexProfileStorage();
  SafeConnexGeofenceDatabase geofenceDatabase = SafeConnexGeofenceDatabase();
  SafeConnexAgencyDatabase agencyDatabase = SafeConnexAgencyDatabase();

  /// Register an account to SafeConnex using [email] and [password]
  Future<void> signUpWithEmailAccount(String email, String password, String firstName, String lastName, String phoneNumber, String birthdate) async {
    try{
      // Create a user and assign it to the currentUser variable
      UserCredential currentCredential = await _authHandler.createUserWithEmailAndPassword(email: email, password: password);

      // Send an email verification to the currentUser
      await currentCredential.user?.sendEmailVerification();

      // Updates the name of the currentUser
      currentCredential.user?.updateDisplayName("$firstName $lastName");

      // Sets the values of the birthday and role in the database
      await _dbUserReference.child(currentCredential.user!.uid).set
        ({
        "birthday": birthdate,
        "role": "user",
        "phoneNumber": "000000000"
      }).whenComplete((){
        // Logs out the account after the data has been assigned to prevent auto login
        _authHandler.signOut();
      });



      // For Verification only remove if the app is in production
      print("Account Created");
    }
    on FirebaseAuthException catch(exception){
      switch(exception.code){
        case "weak-password":
          signUpException = "Password was too weak";
          print(signUpException);
        case "email-already-in-use":
          signUpException = "Email already in use";
          print(signUpException);
        case "invalid-email":
          signUpException = "Email is Invalid";
          print(signUpException);
        case "operation-not-allowed":
          signUpException = "Email has been banned";
          print(signUpException);
        case "":
          signUpException = "";
          print(signUpException);
      }
    }
  }

  Future<void> updatePhoneNumberAndBirthdate(String phoneNumber, String birthdate) async {
    // Sets the values of the birthday and role in the database
    await _dbUserReference.child(currentUser!.uid).update
      ({
      "birthday": birthdate,
      "phoneNumber": phoneNumber
    });
  }

  Future<void> getUpdatedPhoneAndBirthday(String userId) async {
    DataSnapshot snapshot = await _dbUserReference.child(userId).get();

    userData = {
      "phoneNumber": snapshot.child("phoneNumber").value.toString(),
      "birthdate": snapshot.child("birthday").value.toString()
    };
  }

  Future<void> verifyEmailAddress(String email) async {
    try{
      // Create a user and assign it to the currentUser variable
      await _authHandler.createUserWithEmailAndPassword(email: email, password: "Test_Pass123");

      // Deletes the account after verifying the email is not tied to a safeconnex account
      await _authHandler.currentUser!.delete();

      // For Verification only remove if the app is in production
      print("Accepted");
      signUpException = null;
    }
    on FirebaseAuthException catch(exception) {
      switch (exception.code) {
        case "weak-password":
          signUpException = "Password was too weak";
          print(signUpException);
        case "email-already-in-use":
          signUpException = "Email already in use";
          print(signUpException);
        case "invalid-email":
          signUpException = "Email is Invalid";
          print(signUpException);
        case "operation-not-allowed":
          signUpException = "Email has been banned";
          print(signUpException);
        case "":
          signUpException = "";
          print(signUpException);
      }
    }
  }

  Future<void> getAgencyData() async {
    DataSnapshot snapshot = await _dbUserReference.child(currentUser!.uid).get();
    final splitData = snapshot.child("agencyType").value.toString().split(' ');

    agencyData = {
      "role": snapshot.child("role").value.toString(),
      "agencyType": snapshot.child("agencyType").value.toString(),
      "agencyName": snapshot.child("agencyName").value.toString()
    };
  }

  Future<void> loginWithEmailAccount(String email, String password) async {
    try{
      UserCredential currentCredential = await _authHandler.signInWithEmailAndPassword(email: email, password: password);

      if(currentCredential.user!.emailVerified == true){
        currentUser = currentCredential.user!;
        await getUpdatedPhoneAndBirthday(currentCredential.user!.uid);
        await profileStorage.getProfilePicture(currentUser!.uid);
        await SafeConnexNotification().initializeNotification(currentUser!.uid);
        await circleDatabase.getCircleList(currentUser!.uid).whenComplete(() {
          if(SafeConnexCircleDatabase.circleList.isNotEmpty) {
            SafeConnexCircleDatabase.currentCircleCode = SafeConnexCircleDatabase.circleList[0]["circle_code"].toString();
            circleDatabase.getCircleRole(SafeConnexCircleDatabase.currentCircleCode!, currentUser!.uid);
            geofenceDatabase.getGeofence(SafeConnexCircleDatabase.currentCircleCode!);
          }
        });
        await circleDatabase.listCircleDataForSettings(currentUser!.uid);
        if(agencyData["agencyName"] != null){
          await getAgencyData().whenComplete((){
            agencyDatabase.getMyAgencyData(agencyData["agencyName"]!);
          });
        }

        print("Login Successfull");
      }
      else{
        // Throw Error if the email is not verified
        throw FirebaseAuthException(code: "email-not-verified");
      }
    }
    // Catch the error thrown by the function
    on FirebaseAuthException catch(exception){
      switch (exception.code) {
        case "invalid-credential":
          loginException = "Invalid email or password";
          print(loginException);
        case "user-disabled":
          loginException = "User has been banned";
          print(loginException);
        case "too-many-requests":
          loginException = "Too many attempts";
          print(loginException);
        case "email-not-verified":
          loginException = "Email not yet verified";
          print(loginException);
        case "":
          loginException = "";
          print(loginException);
      }
    }
  }

  Future<void> loginInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken // this is the universal token used to auto login
    );

    UserCredential currentCredential = await _authHandler.signInWithCredential(credential);
    currentUser = currentCredential.user!;

    await _dbUserReference.child(currentUser!.uid).set
      ({
      "birthday": "01-01-1999",
      "role": "user"
    });

    await profileStorage.getProfilePicture(currentUser!.uid);
    await SafeConnexNotification().initializeNotification(currentUser!.uid);
    await getUpdatedPhoneAndBirthday(currentCredential.user!.uid);
    await circleDatabase.getCircleList(currentUser!.uid).whenComplete(() {
      if(SafeConnexCircleDatabase.circleList.isNotEmpty) {
        SafeConnexCircleDatabase.currentCircleCode = SafeConnexCircleDatabase.circleList[0]["circle_code"].toString();
        circleDatabase.getCircleRole(SafeConnexCircleDatabase.currentCircleCode!, currentUser!.uid);
        geofenceDatabase.getGeofence(SafeConnexCircleDatabase.currentCircleCode!);
      }
    });
    await circleDatabase.listCircleDataForSettings(currentUser!.uid);
    if(agencyData["agencyName"] != null){
      await getAgencyData().whenComplete((){
        agencyDatabase.getMyAgencyData(agencyData["agencyName"]!);
      });
    }
  }

  Future<void> forgotUserPassword(String email) async {
    await _authHandler.sendPasswordResetEmail(email: email);
  }

  Future<void> loginWithToken() async {
    if(_authHandler.currentUser != null){
      currentUser = _authHandler.currentUser!;
      await getUpdatedPhoneAndBirthday(currentUser!.uid);
      await profileStorage.getProfilePicture(currentUser!.uid);

      await circleDatabase.getCircleList(currentUser!.uid).whenComplete(() {
        if(SafeConnexCircleDatabase.circleList.isNotEmpty) {
          SafeConnexCircleDatabase.currentCircleCode = SafeConnexCircleDatabase.circleList[0]["circle_code"].toString();
          circleDatabase.getCircleRole(SafeConnexCircleDatabase.currentCircleCode!, currentUser!.uid);
          geofenceDatabase.getGeofence(SafeConnexCircleDatabase.currentCircleCode!);
        }
      });
      await circleDatabase.listCircleDataForSettings(currentUser!.uid);
      if(agencyData["agencyName"] != null){
        await getAgencyData().whenComplete((){
          agencyDatabase.getMyAgencyData(agencyData["agencyName"]!);
        });
      }
      await SafeConnexNotification().initializeNotification(currentUser!.uid);
    }
  }

  Future<void> deleteUserAccount(String password) async {
    await _authHandler.currentUser!.reauthenticateWithCredential(EmailAuthProvider.credential(
        email: _authHandler.currentUser!.email!,
        password: password
    )).whenComplete(() async {
      await _authHandler.currentUser?.delete();
    });

    print("Account Deleted");
  }

  // Handler for Sign Out/Log out
  Future<void> signOutAccount() async
  {
    await _authHandler.signOut();
    currentUser = null;
  }

  Future<void> changePassword (String oldPassword, String newPassword) async {
    await _authHandler.currentUser!.reauthenticateWithCredential(EmailAuthProvider.credential(
        email: _authHandler.currentUser!.email!,
        password: oldPassword
    )).whenComplete(() async {
      await _authHandler.currentUser!.updatePassword(newPassword);
    });
  }
}