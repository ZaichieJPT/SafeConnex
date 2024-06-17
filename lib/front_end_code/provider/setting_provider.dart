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
      String value, String passwordString, int strengthCount) {
    if (value.isEmpty && strengthCount < 5) {
      return null;
    } else if (value.isEmpty && strengthCount > 4) {
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

  emailValidator(
      BuildContext context,
      double height,
      double width,
      String email,
      ) {
    if (email.isEmpty) {
      showErrorMessage(
          context, "Please enter your email address", height, width);
      return "";
    } else if (!EmailValidator.validate(email)) {
      showErrorMessage(context, "Please enter a valid email", height, width);
      return '';
      // } else if (authHandler.firebaseLoginException != null) {
      //   print("Firebase Error: ${authHandler.firebaseLoginException},");
      //   showErrorMessage(
      //       context, authHandler.firebaseLoginException!, height, width);
      //   //causes problems for the UI;
      //   authHandler.firebaseLoginException = null;
      //   return null;
    }
    return null;
  }

  emailSignupValidator(
      BuildContext context,
      double height,
      double width,
      String email,
      ) {
    FirebaseAuthHandler authHandler;
    if (email.isEmpty) {
      showErrorMessage(
          context, "Your email address is required", height, width);
      return "";
    } else if (!EmailValidator.validate(email)) {
      showErrorMessage(context, "Please enter a valid email", height, width);
      return '';
    } else if (FirebaseAuthHandler.firebaseSignUpException != null) {
      showErrorMessage(
          context, FirebaseAuthHandler.firebaseSignUpException!, height, width);
      return '';
    }
    return null;
  }

  joinCodeValidator(
      BuildContext context,
      double height,
      double width,
      String code,
      ) {
    if (code.isEmpty) {
      showErrorMessage(context, "Please enter a Circle Code", height, width);
      return "";
    } else if (code.length < 6 || code.length > 6) {
      showErrorMessage(context,
          "Invalid Code. Check the Circle Code and try again.", height, width);
      return '';
      // } else {
      //   if (CircleDatabaseHandler.circleToJoin['circle_code'] == null ||
      //       CircleDatabaseHandler.circleToJoin['circle_name'] == null) {
      //     showErrorMessage(
      //       context,
      //       "Circle does not exist. Check the Circle Code and try again.",
      //       height,
      //       width,
      //     );
      //     return "";
      //   } else if (CircleDatabaseHandler.circleToJoin['isAMember'] == true) {
      //     showErrorMessage(
      //         context, "You're already in the Circle", height, width);
      //     return "";
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

  agencyPhoneNumberValidator(
      BuildContext context, double height, double width, String value) {
    if (value.isEmpty) {
      showErrorMessage(
          context, "Please provide your phone number", height, width);
      return "";
    } else {
      final regex_1 = RegExp(r'^[+]*[6]?[3][9][0-9]{9}$');
      final regex_2 = RegExp(r'^[0][9][0-9]{9}$');
      if (!regex_1.hasMatch(value)) {
        if (!regex_2.hasMatch(value)) {
          showErrorMessage(context,
              "Please enter a valid Philippine\nmobile number.", height, width);
          return '';
        }
      }
      return null;
    }
  }

  agencyTelephoneValidator(
      BuildContext context, double height, double width, String value) {
    final regex_1 =
    RegExp(r'^(02|0[3-8]{1}[0-9]{1})-?([0-9]{3,4})-?([0-9]{4})$');
    if (value.isEmpty) {
      return null;
    } else if (!regex_1.hasMatch(value)) {
      showErrorMessage(context,
          "Please enter a valid Philippine telephone number.", height, width);
      return '';
    }
    return null;
  }

  agencyEmailValidator(
      BuildContext context,
      double height,
      double width,
      String email,
      ) {
    if (email.isEmpty) {
      return null;
    } else if (!EmailValidator.validate(email)) {
      showErrorMessage(context, "Please enter a valid email", height, width);
      return '';
    }
    return null;
  }

  agencyFBValidator(
      BuildContext context,
      double height,
      double width,
      String fb,
      ) {
    if (fb.isEmpty) {
      return null;
    } else {
      final regex_1 =
      RegExp(r'^(https?://)?(www.)?facebook.com/[a-zA-Z0-9.]+$');
      if (!regex_1.hasMatch(fb)) {
        showErrorMessage(
            context, "Please enter a valid Facebook link.", height, width);
        return '';
      }
      return null;
    }
  }

  agencyWebsiteValidator(
      BuildContext context,
      double height,
      double width,
      String web,
      ) {
    final regex_1 = RegExp(
        r'(?:http[s]?:\/\/.)?(?:www\.)?[-a-zA-Z0-9@%._\+~#=]{2,256}\.[a-z]{2,63}(?:\:[0-9]{1,5})?(?:[-a-zA-Z0-9@:%_\+.~#?&\/\/=]*)');

    if (web.isEmpty) {
      return null;
    } else if (!regex_1.hasMatch(web)) {
      showErrorMessage(
          context, "Please enter a valid website URL.", height, width);
      return '';
    }
    return null;
  }
}