import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_storage.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_circle_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_init.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_profile_storage.dart';

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

  // Database Reference for the Circle Database
  final DatabaseReference _dbCircleReference = FirebaseDatabase.instanceFor(
    //Keep the FirebaseInit or not?
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("circle");

  static User? currentUser;
  static String? signUpException;
  static String? loginException;

  SafeConnexCircleDatabase circleDatabase = SafeConnexCircleDatabase();
  SafeConnexCloudStorage profileStorage = SafeConnexCloudStorage();

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
        "role": "user"
      });

      // Logs out the account after the data has been assigned to prevent auto login
      await _authHandler.signOut();

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

  Future<void> phoneVerificationAndroid(String phoneNumbers) async
  {
    await _authHandler.verifyPhoneNumber(
        phoneNumber: phoneNumbers,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async
        {
          print("Verification Success");
          await _authHandler.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (FirebaseAuthException exception) async
        {
          if(exception.code == "invalid-phone-number")
          {
            print("Invalid Phone Number");
          }else if(exception.code == "quota-exceeded")
          {
            print("Limit is reached");
          }
        },
        codeSent: (String verificationId, int? forceResendingToken) async
        {
          PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: "123456");

          await _authHandler.signInWithCredential(credential);

          print("it Works");

        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) async
        {
          print("Time out");
        });
  }

  Future<void> loginWithEmailAccount(String email, String password) async {
    try{
      UserCredential currentCredential = await _authHandler.signInWithEmailAndPassword(email: email, password: password);

      if(currentCredential.user!.emailVerified == true){
        currentUser = currentCredential.user!;
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

    await _dbUserReference.child(credential.idToken!).set
      ({
      "birthday": "01-01-1999",
      "role": "user"
    });

    UserCredential currentCredential = await _authHandler.signInWithCredential(credential);
    currentUser = currentCredential.user!;
  }

  Future<void> loginWithToken() async {
    if(_authHandler.currentUser != null){
      currentUser = _authHandler.currentUser!;
      print(currentUser!.displayName);
      profileStorage.getProfilePicture(currentUser!.uid).whenComplete(() async {
        await circleDatabase.getCircleList(currentUser!.uid).whenComplete((){
          if(SafeConnexCircleDatabase.circleList.isNotEmpty) {
            SafeConnexCircleDatabase.currentCircleCode = SafeConnexCircleDatabase.circleList[0]["circle_code"].toString();
          }
        });
      });
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