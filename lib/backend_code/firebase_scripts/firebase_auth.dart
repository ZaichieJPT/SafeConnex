import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'firebase_user.dart';
import 'firebase_users_database.dart';
import 'package:safeconnex/front_end_code/provider/setting_provider.dart';

/// Handles all the Functionalities of User Authentications
class FirebaseAuthHandler
{
  FirebaseAuth authHandler = FirebaseAuth.instance; // Universal Authentication Handler
  UserDatabaseHandler databaseHandler = UserDatabaseHandler();

  String? firebaseLoginException;
  static String? firebaseSignUpException;

  /// Registers an account to the Firebase Auth API
  /// using the [email] and [password] parameters
  Future<void> registerEmailAccount(String email, String password, String firstName, String lastName, int phoneNumber, String date) async
  {
    try
    {
      // Adds the output to the FirebaseUserCrendentials
      FirebaseUserCredentials.userCredential = await authHandler.createUserWithEmailAndPassword(email: email, password: password);
      sendEmailVerification();
      FirebaseUserCredentials.userCredential.user?.updateDisplayName("$firstName $lastName");
      //FirebaseUserCredentials.userCredential.user?.updatePhotoURL();
      //FirebaseUserCredentials.userCredential.user?.updatePhoneNumber(phoneNumber as PhoneAuthCredential);
      databaseHandler.addRegularUser(FirebaseUserCredentials.userCredential.user?.uid, date, "user");
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

  Future<void> phoneVerificationAndroid(String phoneNumbers) async 
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
  Future<void> sendEmailVerification() async 
  {
    await FirebaseUserCredentials.userCredential.user?.sendEmailVerification();
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

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken
    );

    databaseHandler.addRegularUser(credential.idToken, "01-01-1999", "user");

    return await authHandler.signInWithCredential(credential);
  }
}