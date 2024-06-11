import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_circle_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_profile_storage.dart';
import 'package:safeconnex/controller/page_navigator.dart';
import 'firebase_init.dart';
import 'firebase_user.dart';
import 'firebase_users_database.dart';

/// Handles all the Functionalities of User Authentications
class FirebaseAuthHandler
{
  FirebaseAuth authHandler = FirebaseAuth.instance; // Universal Authentication Handler
  CircleDatabaseHandler circleDatabaseHandler = CircleDatabaseHandler();
  DatabaseReference dbUserReference = FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("users");

  String? firebaseLoginException;
  static String? firebaseSignUpException;
  bool isTransferred = false;

  /// Registers an account to the Firebase Auth API
  /// using the [email] and [password] parameters
  Future<void> _registerEmailAccount(String email, String password, String firstName, String lastName, String phoneNumber, String date) async
  {
    try
    {
      // Adds the output to the FirebaseUserCrendentials
      FirebaseUserCredentials.userCredential = await authHandler.createUserWithEmailAndPassword(email: email, password: password);
      _sendEmailVerification();
      FirebaseUserCredentials.userCredential.user?.updateDisplayName("$firstName $lastName");
      //FirebaseUserCredentials.userCredential.user?.updatePhoneNumber(phoneNumber as PhoneAuthCredential);
      await dbUserReference.child(authHandler.currentUser!.uid).set
        ({
        "birthday": date,
        "role": "user"
      });
      //<code>
      // Sets the users info and adds it to the FirebaseDatabaseHandler
      await authHandler.signOut();
      print("Account Created");
    } 
    on FirebaseAuthException catch(exception)
    {
      if(exception.code == "weak-password")
      {
        //Replace with something else
        firebaseSignUpException = "Password too weak";
        print("The Password Provided was too weak");
      }
      else if(exception.code == "email-already-in-use")
      {
        //Replace with something else
        firebaseSignUpException = "Email already in use";
        print("Email Already in use");
      }
      else if(exception.code == "invalid-email")
      {
        //Replace with something else
        firebaseSignUpException = "Invalid email";
        print("Email is Invalid");
      }
      else if(exception.code == "operation-not-allowed")
      {
        //Replace with something else
        firebaseSignUpException = "Email is banned";
        print("The account has been disabled");  
      }
    }
  }

  /// Creates a user account if the email is not valid it throws exceptions if it is valid it deletes
  /// the temporary credentials
  Future<void> verifyEmailAddress(String email) async {
    try{
      await authHandler.createUserWithEmailAndPassword(email: email, password: "Test_Pass123");
      print("Accepted");
      await authHandler.currentUser!.delete();
    }
    on FirebaseAuthException catch(exception){
      if(exception.code == "email-already-in-use")
      {
        //Replace with something else
        firebaseSignUpException = "Email already in use";
        print("Email Already in use");
      }
      else if(exception.code == "invalid-email")
      {
        //Replace with something else
        firebaseSignUpException = "Invalid email";
        print("Email is Invalid");
      }
      else if(exception.code == "operation-not-allowed")
      {
        //Replace with something else
        firebaseSignUpException = "Email is banned";
        print("The account has been disabled");
      }
    }
  }

  /// Login to your account using [email] and [password] parameters
  Future<void> loginEmailAccount(String email, String password) async 
  {
    try{
      FirebaseUserCredentials.userCredential = await authHandler.signInWithEmailAndPassword(email: email, password: password);

      if(FirebaseUserCredentials.userCredential.user?.emailVerified == true){
        // Adds the output to the FirebaseUserCrendentials 
        print("Login Successful");
        //databaseHandler.getRegularUser();
        //<code>
        // Gets the users info and adds it to the FirebaseUserCredentials
      }else
      {
        print("Email is not verified");
        throw FirebaseAuthException(code: "email-not-verified");
        signOutAccount();
      }
    }
    on FirebaseAuthException catch(exception){
      print(exception.code);
      if(exception.code == "invalid-credential")
      {
        //Replace this with something else
        firebaseLoginException = "Invalid email or password";
        signOutAccount();
      }
      else if(exception.code == "user-disabled")
      {
        //Replace this with something else
        firebaseLoginException = "User has been banned";
        signOutAccount();
      }
      else if(exception.code == "too-many-requests")
      {
        //Replace this with something else
        firebaseLoginException = "Too many attempts";
        signOutAccount();
      }
      else if(exception.code == "email-not-verified"){
        firebaseLoginException = "Email not yet verified";
        signOutAccount();
      }
    }
  }

  Future<void> _phoneVerificationAndroid(String phoneNumbers) async
  {
    await authHandler.verifyPhoneNumber(
      phoneNumber: phoneNumbers,
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async 
      {
        print("Verification Success");
        await authHandler.signInWithCredential(phoneAuthCredential);
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

        await authHandler.signInWithCredential(credential);

        print("it Works");

      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) async 
      {
        print("Time out");
      });
  }

  /// Handler for Email Verification
  Future<void> _sendEmailVerification() async
  {
    await FirebaseUserCredentials.userCredential.user?.sendEmailVerification();
  }

  /// Delete user account
  Future<void> deleteUserAccount() async {
    await authHandler.currentUser?.delete();
    print("Account Deleted");
  }

  /// Handler for Password Reset
  Future<void> sendPasswordReset(String email) async 
  {
    await authHandler.sendPasswordResetEmail(email: email);
  }

  /// Handler for Sign Out/Log out
  Future<void> signOutAccount() async
  {
    await authHandler.signOut();
  }
  /// Sign in with you google account
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken // this is the universal token used to auto login
    );

    await dbUserReference.child(credential.idToken!).set
      ({
      "birthday": "01-01-1999",
      "role": "user"
    });

    return await authHandler.signInWithCredential(credential);
  }

  void loginWithToken(BuildContext context, Widget screen){
    if (authHandler.currentUser != null && isTransferred != true) {
      FirebaseProfileStorage(authHandler.currentUser!.uid);
      circleDatabaseHandler.getCircleList(authHandler.currentUser!.uid);
      if(CircleDatabaseHandler.circleList.isNotEmpty) {
        CircleDatabaseHandler.currentCircleCode = CircleDatabaseHandler.circleList[0]["circle_code"].toString();
      }
      isTransferred = true;
      PageNavigator(context, screen);
    }
  }

  void loginWithButton(String email, String password, BuildContext context, Widget MainScreen, GlobalKey<FormState> _loginFormKey){
    loginEmailAccount(email, password);
    Future.delayed(Duration(milliseconds: 1000), (){
      if(_loginFormKey.currentState!.validate()){
        print(firebaseLoginException);
        if (firebaseLoginException == null || firebaseLoginException == "") {
          FirebaseProfileStorage(authHandler.currentUser!.uid);
          circleDatabaseHandler.getCircleList(authHandler.currentUser!.uid);
          if(CircleDatabaseHandler.circleList.isNotEmpty) {
            CircleDatabaseHandler.currentCircleCode = CircleDatabaseHandler.circleList[0]["circle_code"].toString();
          }
          PageNavigator(context, MainScreen);
        }
      }
    });
  }

  void loginWithGoogle(BuildContext context, Widget MainScreen){
    FirebaseProfileStorage(authHandler.currentUser!.uid);
    circleDatabaseHandler.getCircleList(authHandler.currentUser!.uid);
    if (CircleDatabaseHandler.circleList.isNotEmpty) {
      CircleDatabaseHandler.currentCircleCode =
          CircleDatabaseHandler.circleList[0]["circle_code"].toString();
    }
    PageNavigator(context, MainScreen);
  }

  void signUpWithEmail(String email, String password, String firstName, String lastName, String phoneNumber, String date, BuildContext context, Widget Screen, Function() backClicked){
    _registerEmailAccount(
        email,
        password,
        firstName,
        lastName,
        phoneNumber,
        date
    );
    Future.delayed(Duration(seconds: 1), () {
      if (firebaseSignUpException == null) {
        signOutAccount();
        PageNavigator(context, Screen);
      } else {
        backClicked();
      }
    });
  }
}