import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_auth.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_circle_database.dart';
import 'package:safeconnex/front_end_code/components/home_components/error_snackbar.dart';

class SettingsProvider extends ChangeNotifier {
  passValidator(BuildContext context, double height, double width, value,
      int strengthCount) {
    if (value.isEmpty) {
      showErrorMessage(context, "Password is a required field.", height, width);

      return '';
    } else if (strengthCount < 5) {
      showErrorMessage(
          context,
          "Your password should contain:\n  • Uppercase letter (A-Z)\n  • Lowercase letter (A-Z)\n  • Numbers (0-9)\n  • Special characters.",
          height,
          width);
      return "";
    } else {
      return null;
    }
  }

  confirmPassMismatch(BuildContext context, double height, double width,
      String value, String passwordString) {
    if (value.isEmpty) {
      showErrorMessage(context, "Please confirm your password.", height, width);
      return '';
    } else if (passwordString != value) {
      showErrorMessage(context, "Password did not match", height, width);
      return "";
    } else {
      return null;
    }
  }

  loginPassValidatior(BuildContext context, double height, double width,
      String loginPass, FirebaseAuthHandler authHandler) {
    if (loginPass.isEmpty) {
      showErrorMessage(context, "Please enter your password", height, width);

      return '';
    } else if (authHandler.firebaseLoginException != null) {
      showErrorMessage(
          context, authHandler.firebaseLoginException!, height, width);
      return '';
    } else {
      return null;
    }
  }

  phoneNumberValidator(
      BuildContext context, double height, double width, String value) {
    if (value.isEmpty) {
      Navigator.pop(context);
      showErrorMessage(
          context, "Please provide your phone number", height, width);
      //return "";
    } else {
      final regex = RegExp(r'^[+]*[6]?[3][9][0-9]{9}$');
      if (!regex.hasMatch('+639$value')) {
        Navigator.pop(context);
        showErrorMessage(context,
            "Please enter a valid Philippine\nmobile number.", height, width);
      } else {
        return null;
      }
    }
  }

  birthdateValidator(
      BuildContext context, double height, double width, String value) {
    if (value.isEmpty) {
      Navigator.pop(context);
      showErrorMessage(context, "Please provide your birthdate", height, width);
      //return "";
    }
    return null;
  }

  emailValidator(BuildContext context, double height, double width,
      String email, FirebaseAuthHandler authHandler) {
    if (email.isEmpty) {
      showErrorMessage(
          context, "Please enter your email address", height, width);
      return "";
    } else if (!EmailValidator.validate(email)) {
      showErrorMessage(context, "Please enter a valid email", height, width);
    } else if (authHandler.firebaseLoginException != null) {
      print("Firebase Error: ${authHandler.firebaseLoginException},");
      showErrorMessage(
          context, authHandler.firebaseLoginException!, height, width);
      //causes problems for the UI;
      authHandler.firebaseLoginException = null;
      return '';
    }
    return null;
  }

  emailSignupValidator(BuildContext context, double height, double width,
      String email, FirebaseAuthHandler authHandler) {
    if (email.isEmpty) {
      showErrorMessage(
          context, "Your email address is required", height, width);
      return "";
    } else if (!EmailValidator.validate(email)) {
      showErrorMessage(context, "Please enter a valid email", height, width);
      return '';
    } else if(FirebaseAuthHandler.firebaseSignUpException != null){
      showErrorMessage(context,
          FirebaseAuthHandler.firebaseSignUpException!, height, width);
      return '';
    }
    return null;
  }

  joinCodeValidator(BuildContext context, double height, double width,
      String code, CircleDatabaseHandler circleDatabase) {
    if (code.isEmpty) {
      showErrorMessage(context, "Please enter a Circle Code", height, width);
      return "";
    } else if (code.length < 6 || code.length > 6) {
      showErrorMessage(context,
          "Invalid Code. Check the Circle Code and try again.", height, width);
      return '';
    } else {
      if (CircleDatabaseHandler.circleToJoin['circle_code'] == null ||
          CircleDatabaseHandler.circleToJoin['circle_name'] == null) {
        showErrorMessage(
          context,
          "Circle does not exist. Check the Circle Code and try again.",
          height,
          width,
        );
        return "";
      }
      else if(CircleDatabaseHandler.circleToJoin['isAMember'] == true){
        showErrorMessage(context, "You're already in the Circle", height, width);
        return "";
      }
      return '';
    }
    return null;
  }

  createCircleNameValidator(
      BuildContext context, double height, double width, String circleName) {
    if (circleName.isEmpty) {
      //Navigator.pop(context);
      showErrorMessage(
          context, "Please enter name for your circle", height, width);
      return "";
    }
    return null;
  }
}