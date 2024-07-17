import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_agencies.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_agency_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_circle_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_geofence_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_notification.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_scoring_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_storage.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_init.dart';

/// SafeConnex Authentication System using the Firebase API
class SafeConnexAuthentication{
  // Initialize the Firebase Auth Handler
  final FirebaseAuth authHandler = FirebaseAuth.instance;

  // Database Reference for the Users Database
  final DatabaseReference _dbUserReference = FirebaseDatabase.instanceFor(
    //Keep the FirebaseInit or not?
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("users");

  User? currentUser;
  String? signUpException;
  String? loginException;
  String? emergencyPin;
  String? userProfileLink;
  Map<String, String> userData = {};
  Map<String, dynamic> authAgencyData = {};

  //SafeConnexCircleDatabase circleDatabase = SafeConnexCircleDatabase();
  //SafeConnexProfileStorage profileStorage = SafeConnexProfileStorage();
  //SafeConnexGeofenceDatabase geofenceDatabase = SafeConnexGeofenceDatabase();
  //SafeConnexAgencyDatabase agencyDatabase = SafeConnexAgencyDatabase();

  /// Register an account to SafeConnex using [email] and [password]
  Future<void> signUpWithEmailAccount(String email, String password, String firstName, String lastName, String phoneNumber, String birthdate) async {
    try{
      // Create a user and assign it to the currentUser variable
      UserCredential currentCredential = await authHandler.createUserWithEmailAndPassword(email: email, password: password);

      // Send an email verification to the currentUser
      await currentCredential.user?.sendEmailVerification();

      // Updates the name of the currentUser
      currentCredential.user?.updateDisplayName("$firstName $lastName");

      String age = (DateTime.now().year - DateTime.parse(birthdate).year).toString();

      final _profileRefs = FirebaseStorage.instance.ref().child("profile_pics");
      final alternative_pic_male = _profileRefs.child("male_profile.png");
      final networkImageAlternate = await alternative_pic_male.getDownloadURL();

      // Sets the values of the birthday and role in the database
      await _dbUserReference.child(currentCredential.user!.uid).set
        ({
        "birthday": birthdate,
        "role": "user",
        "age": age,
        "phoneNumber": "000000000",
        "profilePic": networkImageAlternate
      });
      currentUser = null;
      // Logs out the account after the data has been assigned to prevent auto login
      await authHandler.signOut();
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
    String age = (DateTime.now().year - DateTime.parse(birthdate).year).toString();

    await _dbUserReference.child(currentUser!.uid).update
      ({
      "birthday": birthdate,
      "age": age,
      "phoneNumber": phoneNumber
    });
  }

  Future<void> addEmergencyPin(String pin) async {
    await _dbUserReference.child(currentUser!.uid).update
      ({
      "emergency_pin": pin,
    });
  }

  Future<void> getEmergencyPin() async {
    DataSnapshot snapshot = await _dbUserReference.child(currentUser!.uid).child("emergency_pin").get();
    if(snapshot.exists){
      emergencyPin = snapshot.value.toString();
    }
    else{
      emergencyPin = null;
    }

  }

  Future<void> getUpdatedPhoneAndBirthday(String userId) async {
    DataSnapshot snapshot = await _dbUserReference.child(userId).get();

    userData = {
      "phoneNumber": snapshot.child("phoneNumber").value.toString(),
      "birthdate": snapshot.child("birthday").value.toString(),
      "age": snapshot.child("age").value.toString()
    };
  }

  Future<void> verifyEmailAddress(String email) async {
    try{
      // Create a user and assign it to the currentUser variable
      await authHandler.createUserWithEmailAndPassword(email: email, password: "Test_Pass123");

      // Deletes the account after verifying the email is not tied to a safeconnex account
      await authHandler.currentUser!.delete();

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

  Future<void> getUserProfile() async {
    DataSnapshot snapshot = await _dbUserReference.child(currentUser!.uid).get();

    userProfileLink = snapshot.child("profilePic").value.toString();
  }

  Future<void> updateUserProfile(String profileLink) async {
    await _dbUserReference.child(currentUser!.uid).update({
      "profilePic": profileLink
    });
  }

  Future<void> getAgencyData() async {
    DataSnapshot snapshot = await _dbUserReference.child(currentUser!.uid).get();

    authAgencyData = {
      "role": snapshot.child("role").value,
      "agencyType": snapshot.child("agencyType").value,
      "agencyName": snapshot.child("agencyName").value
    };
  }

  Future<void> loginWithEmailAccount(String email, String password) async {
    try{
      UserCredential currentCredential = await authHandler.signInWithEmailAndPassword(email: email, password: password);

      if(currentCredential.user!.emailVerified == true){
        currentUser = currentCredential.user!; //
        await getUpdatedPhoneAndBirthday(currentCredential.user!.uid);
        await getUserProfile();
        await DependencyInjector().locator<SafeConnexAgencies>().getAgenciesData();
        await DependencyInjector().locator<SafeConnexNotification>().initializeNotification(currentUser!.uid);
        await DependencyInjector().locator<SafeConnexCircleDatabase>().listCircleDataForSettings(currentUser!.uid);
        await DependencyInjector().locator<SafeConnexCircleDatabase>().getCircleList(currentUser!.uid).whenComplete(() {
          if(DependencyInjector().locator<SafeConnexCircleDatabase>().circleList.isNotEmpty) {
            DependencyInjector().locator<SafeConnexCircleDatabase>().currentCircleCode = DependencyInjector().locator<SafeConnexCircleDatabase>().circleList[0]["circle_code"].toString();
            DependencyInjector().locator<SafeConnexCircleDatabase>().getCircleRole(DependencyInjector().locator<SafeConnexCircleDatabase>().currentCircleCode!, currentUser!.uid);
            DependencyInjector().locator<SafeConnexGeofenceDatabase>().getGeofence(DependencyInjector().locator<SafeConnexCircleDatabase>().currentCircleCode!);
            DependencyInjector().locator<SafeConnexSafetyScoringDatabase>().getSafetyScore();
          }
        });
        await getAgencyData();
        if(authAgencyData["role"] == "Agency"){
          DependencyInjector().locator<SafeConnexAgencyDatabase>().getMyAgencyData();
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
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken // this is the universal token used to auto login
      );

      UserCredential currentCredential = await authHandler.signInWithCredential(credential);
      currentUser = currentCredential.user!;

      DataSnapshot credentialSnapshot = await _dbUserReference.child(currentUser!.uid).get();

      final _profileRefs = FirebaseStorage.instance.ref().child("profile_pics");
      final alternative_pic_male = _profileRefs.child("male_profile.png");
      final networkImageAlternate = await alternative_pic_male.getDownloadURL();

      if(credentialSnapshot.exists == false){
        await _dbUserReference.child(currentUser!.uid).set
          ({
          "birthday": "01-01-1999",
          "role": "user",
          "profilePic": networkImageAlternate
        });
      }else{
        await getUserProfile();
      }

      await getUpdatedPhoneAndBirthday(currentCredential.user!.uid);
      await DependencyInjector().locator<SafeConnexAgencies>().getAgenciesData();
      await DependencyInjector().locator<SafeConnexNotification>().initializeNotification(currentUser!.uid);///
      await DependencyInjector().locator<SafeConnexCircleDatabase>().listCircleDataForSettings(currentUser!.uid);
      await DependencyInjector().locator<SafeConnexCircleDatabase>().getCircleList(currentUser!.uid).whenComplete(() {
        if(DependencyInjector().locator<SafeConnexCircleDatabase>().circleList.isNotEmpty) {
          DependencyInjector().locator<SafeConnexCircleDatabase>().currentCircleCode = DependencyInjector().locator<SafeConnexCircleDatabase>().circleList[0]["circle_code"].toString();
          DependencyInjector().locator<SafeConnexCircleDatabase>().getCircleRole(DependencyInjector().locator<SafeConnexCircleDatabase>().currentCircleCode!, currentUser!.uid);
          DependencyInjector().locator<SafeConnexGeofenceDatabase>().getGeofence(DependencyInjector().locator<SafeConnexCircleDatabase>().currentCircleCode!);
          DependencyInjector().locator<SafeConnexSafetyScoringDatabase>().getSafetyScore();
        }
      });
      await getAgencyData();
      if(authAgencyData["role"] == "Agency"){
        DependencyInjector().locator<SafeConnexAgencyDatabase>().getMyAgencyData();
      }
    }
    // Catch the error thrown by the function
    on FirebaseAuthException catch(exception){
      switch (exception.code) {
        case "account-exists-with-different-credential":
          loginException = "Account already in use";
          print(loginException);
        case "user-disabled":
          loginException = "User has been banned";
          print(loginException);
        case "operation-not-allowed":
          loginException = "Email has been banned";
          print(loginException);
        case "wrong-password":
          loginException = "Email and Password do not match";
          print(loginException);
        case "invalid-credential":
          loginException = "Credential not Valid";
          print(loginException);
        case "":
          loginException = "";
          print(loginException);
      }
    }

  }

  Future<void> forgotUserPassword(String email) async {
    await authHandler.sendPasswordResetEmail(email: email);
  }

  Future<void> loginWithToken() async {
    if(authHandler.currentUser != null){
      print("called");
      currentUser = authHandler.currentUser!;
      await getUpdatedPhoneAndBirthday(currentUser!.uid);
      await getUserProfile();
      await DependencyInjector().locator<SafeConnexAgencies>().getAgenciesData();
      await DependencyInjector().locator<SafeConnexCircleDatabase>().listCircleDataForSettings(currentUser!.uid);
      await DependencyInjector().locator<SafeConnexNotification>().initializeNotification(currentUser!.uid);///
      await DependencyInjector().locator<SafeConnexCircleDatabase>().getCircleList(currentUser!.uid).whenComplete(() {
        if(DependencyInjector().locator<SafeConnexCircleDatabase>().circleList.isNotEmpty) {
          DependencyInjector().locator<SafeConnexCircleDatabase>().currentCircleCode = DependencyInjector().locator<SafeConnexCircleDatabase>().circleList[0]["circle_code"].toString();
          DependencyInjector().locator<SafeConnexCircleDatabase>().getCircleRole(DependencyInjector().locator<SafeConnexCircleDatabase>().currentCircleCode!, currentUser!.uid);
          DependencyInjector().locator<SafeConnexGeofenceDatabase>().getGeofence(DependencyInjector().locator<SafeConnexCircleDatabase>().currentCircleCode!);
          DependencyInjector().locator<SafeConnexSafetyScoringDatabase>().getSafetyScore();
        }
      });
      await getAgencyData();
      if(authAgencyData["role"] == "Agency"){
        DependencyInjector().locator<SafeConnexAgencyDatabase>().getMyAgencyData();
      }
    }
  }

  Future<void> deleteUserAccount(String password) async {
    await authHandler.currentUser!.reauthenticateWithCredential(EmailAuthProvider.credential(
        email: authHandler.currentUser!.email!,
        password: password
    )).whenComplete(() async {
      await authHandler.currentUser?.delete();
    });

    print("Account Deleted");
  }

  // Handler for Sign Out/Log out
  Future<void> signOutAccount() async
  {
    await authHandler.signOut();
    currentUser = null;
    DependencyInjector().locator<SafeConnexCircleDatabase>().circleDataList.clear();
    DependencyInjector().locator<SafeConnexCircleDatabase>().circleDataValue.clear();
    DependencyInjector().locator<SafeConnexCircleDatabase>().circleUsersNames.clear();
  }

  Future<void> changePassword (String oldPassword, String newPassword) async {
    await authHandler.currentUser!.reauthenticateWithCredential(EmailAuthProvider.credential(
        email: authHandler.currentUser!.email!,
        password: oldPassword
    )).whenComplete(() async {
      await authHandler.currentUser!.updatePassword(newPassword);
    });
  }
}