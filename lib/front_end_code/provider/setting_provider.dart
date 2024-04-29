import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  passValidator(String value, int strengthCount) {
    if (value.isEmpty) {
      return "Password is a required field.";
    } else if (strengthCount < 5) {
      return "Please enter a strong password.";
    } else {
      return null;
    }
  }

  confirmPassMismatch(String value, String passwordString) {
    if (passwordString != value) {
      return "Password did not match";
    } else {
      return null;
    }
  }
}
