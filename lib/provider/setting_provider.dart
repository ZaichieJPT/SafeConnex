import 'package:flutter/material.dart';
import 'package:settings_side_menu/components/home_components/error_snackbar.dart';

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
    if (passwordString != value) {
      showErrorMessage(context, "Password did not match", height, width);
      return "";
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
      }
      return null;
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
}
