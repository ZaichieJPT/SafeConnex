import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_user.dart';
import 'firebase_users_database.dart';

/// Handles all the Functionalities of User Authentications
class FirebaseAuthHandler
{
  FirebaseAuth authHandler = FirebaseAuth.instance; // Universal Authentication Handler
  UserDatabaseHandler databaseHandler = UserDatabaseHandler();

  FirebaseAuthException? firebaseAuthException;

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
      //FirebaseUserCredentials.userCredential.user?.updatePhoneNumber(phoneNumber as PhoneAuthCredential);
      databaseHandler.addRegularUser(FirebaseUserCredentials.userCredential.user?.uid, date, "user");
      //<code>
      // Sets the users info and adds it to the FirebaseDatabaseHandler

      print("Account Created");
    } 
    on FirebaseAuthException catch(exception) 
    {
      if(exception.code == "weak-password")
      {
        //Replace with something else
        print("The Password Provided was too weak");
      }
      else if(exception.code == "email-already-in-use")
      {
        //Replace with something else
        print("Email Already in use");
      }
      else if(exception.code == "invalid-email")
      {
        //Replace with something else
        print("Email is Invalid");
      }
      else if(exception.code == "operation-not-allowed")
      {
        //Replace with something else
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
        signOutAccount();
      }
    }
    on FirebaseAuthException catch(exception){
      firebaseAuthException = exception;
      if(exception.code == "wrong-password" || exception.code == "invalid-email")
      {
        //Replace this with something else
        print("Invalid username or password");
      }
      else if(exception.code == "user-disabled")
      {
        //Replace this with something else
        print("User has been disabled");
      }
      else if(exception.code == "user-not-found")
      {
        //Replace this with something else
        print("User not found");
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
}