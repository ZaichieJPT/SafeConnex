// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_authentication.dart';
import 'package:safeconnex/controller/app_manager.dart';
import 'package:safeconnex/front_end_code/components/home_components/error_snackbar.dart';
import 'package:safeconnex/front_end_code/provider/setting_provider.dart';

import 'home_mainscreen.dart';

class PasswordChange extends StatefulWidget {
  const PasswordChange({super.key});

  @override
  State<PasswordChange> createState() => _PasswordChangeState();
}

class _PasswordChangeState extends State<PasswordChange> {
  final _newPassFormKey = GlobalKey<FormState>();
  final TextEditingController _oldPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final provider = SettingsProvider();
  double height = 0;
  double width = 0;
  bool obscureText = false;
  bool oldObscureText = false;
  bool confirmObscureText = false;
  double strengthValue = 0;
  int strengthCount = 0;

  _oldGetVisibleButton() {
    return InkWell(
      onTap: () {
        setState(() {
          oldObscureText = !oldObscureText;
        });
      },
      child: Icon(
        oldObscureText ? Icons.visibility_off : Icons.visibility,
        size: height * 0.025,
      ),
    );
  }

  _getVisibleButton() {
    return InkWell(
      onTap: () {
        setState(() {
          obscureText = !obscureText;
        });
      },
      child: Icon(
        obscureText ? Icons.visibility_off : Icons.visibility,
        size: height * 0.025,
      ),
    );
  }

  _confirmGetVisibleButton() {
    return InkWell(
      onTap: () {
        setState(() {
          confirmObscureText = !confirmObscureText;
        });
      },
      child: Icon(
        confirmObscureText ? Icons.visibility_off : Icons.visibility,
        size: height * 0.025,
      ),
    );
  }

  _onPasswordChanged(password) {
    bool isEightChars = false;
    bool hasNumber = false;
    bool hasUpperCase = false;
    bool hasLowerCase = false;
    bool hasSpecialChars = false;

    final numericRegEx = RegExp(r'[0-9]');
    final upperCaseRegEx = RegExp(r'[A-Z]');
    final lowerCaseRegEx = RegExp(r'[a-z]');
    final specialRegEx = RegExp(r'[^a-zA-Z0-9]');

    setState(() {
      isEightChars = false;
      if (password.length >= 8) {
        isEightChars = true;
        strengthValue += 0.2;
      }

      hasNumber = false;
      if (numericRegEx.hasMatch(password)) {
        hasNumber = true;
      }

      hasUpperCase = false;
      if (upperCaseRegEx.hasMatch(password)) {
        hasUpperCase = true;
      }

      hasLowerCase = false;
      if (lowerCaseRegEx.hasMatch(password)) {
        hasLowerCase = true;
      }

      hasSpecialChars = false;
      if (specialRegEx.hasMatch(password)) {
        hasSpecialChars = true;
      }

      List<bool?> passConditions = [
        isEightChars,
        hasNumber,
        hasUpperCase,
        hasLowerCase,
        hasSpecialChars
      ];

      strengthCount = passConditions.where((x) => x == true).length;
    });
  }

  @override
  void dispose() {
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.sizeOf(context).height;
    width = MediaQuery.sizeOf(context).width;

    SafeConnexAuthentication authentication = SafeConnexAuthentication();

    return Stack(
      children: [
        Image.asset(
          "assets/images/side_menu/pass_bg_image.png",
          height: height,
          width: width,
          fit: BoxFit.cover,
        ),
        GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.055, vertical: height * 0.03),
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: Color.fromARGB(255, 246, 242, 227),
                    width: 3,
                  ),
                ),
                child: Form(
                  key: _newPassFormKey,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //BACK BUTTON
                      Padding(
                        padding: EdgeInsets.only(
                          top: height * 0.03,
                          left: width * 0.05,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: width * 0.08,
                              height: height * 0.04,
                              alignment: Alignment.center,
                              //color: Colors.red,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.only(left: width * 0.02),
                                  backgroundColor: Colors.white,
                                  foregroundColor:
                                      Color.fromARGB(255, 70, 85, 104),
                                  shadowColor:
                                      Color.fromARGB(255, 246, 242, 227),
                                  elevation: 2,
                                  surfaceTintColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  alignment: Alignment.center,
                                ),
                                child: Text(
                                  String.fromCharCode(
                                      Icons.arrow_back_ios.codePoint),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: Icons.arrow_back_ios.fontFamily,
                                    fontWeight: FontWeight.w900,
                                    fontSize: height * 0.025,
                                    package: Icons.arrow_back_ios.fontPackage,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //CREATE NEW PASSWORD
                      Container(
                        height: height * 0.1,
                        alignment: Alignment.center,
                        //color: Colors.blue,
                        child: FittedBox(
                          child: Text(
                            'Create New Password',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'OpunMai',
                              fontWeight: FontWeight.w700,
                              color: const Color.fromARGB(255, 70, 85, 104),
                              fontSize: height * 0.03,
                            ),
                          ),
                        ),
                      ),
                      //NEW PASSWORD IMAGE ICON
                      Flexible(
                        flex: 4,
                        child: SingleChildScrollView(
                          reverse: true,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                flex: 5,
                                child: Image.asset(
                                  'assets/images/side_menu/passchange_icon.png',
                                  width: width * 0.65,
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  height: height * 0.085,
                                  alignment: Alignment.center,
                                  //color: Colors.blue,
                                  child: FittedBox(
                                    child: Text(
                                      'Your New Password Must Be Different\nFrom Previously Used Password.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'OpunMai',
                                        fontWeight: FontWeight.w400,
                                        color: const Color.fromARGB(
                                            255, 70, 85, 104),
                                        fontSize: height * 0.018,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              //OLD PASSWORD
                              Flexible(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: height * 0.1,
                                  width: width * 0.65,
                                  //color: const Color.fromARGB(139, 158, 158, 158),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //CURRENT PASS TEXT
                                      Flexible(
                                        child: Container(
                                          width: width,
                                          //color: Colors.amber,
                                          child: Text(
                                            'Current Password',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: 'OpunMai',
                                              fontSize: height * 0.015,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                      //OLD PASS TEXTFIELD
                                      Flexible(
                                        flex: 2,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.03,
                                          ),
                                          child: TextFormField(
                                            controller: _oldPassController,
                                            obscureText: oldObscureText,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            cursorColor: Color.fromARGB(
                                                255, 70, 85, 104),
                                            onChanged: _onPasswordChanged,
                                            style: TextStyle(
                                              fontFamily: 'OpunMai',
                                              fontSize: height * 0.015,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromARGB(
                                                  255, 70, 85, 104),
                                            ),
                                            decoration: InputDecoration(
                                              suffixIconConstraints:
                                                  BoxConstraints(
                                                      maxHeight:
                                                          height * 0.025),
                                              suffixIcon:
                                                  _oldGetVisibleButton(),
                                              //contentPadding: EdgeInsets.zero,
                                              isDense: true,
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: const Color.fromARGB(
                                                      180, 158, 158, 158),
                                                  width: 2.5,
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: const Color.fromARGB(
                                                      255, 70, 85, 104),
                                                  width: 2.5,
                                                ),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value.toString().isEmpty) {
                                                showErrorMessage(
                                                    context,
                                                    'Please enter your current password',
                                                    height,
                                                    width);
                                                return '';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //NEW PASSWORD TEXTFIELD
                              Flexible(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: height * 0.1,
                                  width: width * 0.65,
                                  //color: const Color.fromARGB(139, 158, 158, 158),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //NEW PASS TEXT
                                      Flexible(
                                        child: Container(
                                          width: width,
                                          //color: Colors.amber,
                                          child: Text(
                                            'New Password',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: 'OpunMai',
                                              fontSize: height * 0.015,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                      //NEW PASS TEXTFIELD
                                      Flexible(
                                        flex: 2,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.03,
                                          ),
                                          child: TextFormField(
                                            controller: _newPassController,
                                            obscureText: obscureText,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            cursorColor: Color.fromARGB(
                                                255, 70, 85, 104),
                                            onChanged: _onPasswordChanged,
                                            style: TextStyle(
                                              fontFamily: 'OpunMai',
                                              fontSize: height * 0.015,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromARGB(
                                                  255, 70, 85, 104),
                                            ),
                                            decoration: InputDecoration(
                                              suffixIconConstraints:
                                                  BoxConstraints(
                                                      maxHeight:
                                                          height * 0.025),
                                              suffixIcon: _getVisibleButton(),
                                              //contentPadding: EdgeInsets.zero,
                                              isDense: true,
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: const Color.fromARGB(
                                                      180, 158, 158, 158),
                                                  width: 2.5,
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: const Color.fromARGB(
                                                      255, 70, 85, 104),
                                                  width: 2.5,
                                                ),
                                              ),
                                            ),
                                            validator: (value) {
                                              return provider
                                                  .changeNewPassValidator(
                                                      context,
                                                      height,
                                                      width,
                                                      value!,
                                                      strengthCount);
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //CONFIRM PASSWORD TEXFIELD
                              Flexible(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: height * 0.1,
                                  width: width * 0.65,
                                  //color: Colors.grey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //CONFIRM TEXT
                                      Flexible(
                                        child: Container(
                                          width: width,
                                          //color: Colors.amber,
                                          child: Text(
                                            'Confirm New Password',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: 'OpunMai',
                                              fontSize: height * 0.015,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                      //CONFIRM TEXTFIELD
                                      Flexible(
                                        flex: 2,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.03,
                                          ),
                                          child: TextFormField(
                                            controller: _confirmPassController,
                                            obscureText: obscureText,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            cursorColor: Color.fromARGB(
                                                255, 70, 85, 104),
                                            style: TextStyle(
                                              fontFamily: 'OpunMai',
                                              fontSize: height * 0.015,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromARGB(
                                                  255, 70, 85, 104),
                                            ),
                                            decoration: InputDecoration(
                                              suffixIconConstraints:
                                                  BoxConstraints(
                                                      maxHeight:
                                                          height * 0.025),
                                              suffixIcon:
                                                  _confirmGetVisibleButton(),
                                              //contentPadding: EdgeInsets.zero,
                                              isDense: true,
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: const Color.fromARGB(
                                                      180, 158, 158, 158),
                                                  width: 2.5,
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: const Color.fromARGB(
                                                      255, 70, 85, 104),
                                                  width: 2.5,
                                                ),
                                              ),
                                            ),
                                            validator: (confirmPass) {
                                              if (confirmPass!.length > 0) {
                                                return provider
                                                    .confirmPassMismatch(
                                                  context,
                                                  height,
                                                  width,
                                                  confirmPass,
                                                  _newPassController.text,
                                                  strengthCount,
                                                );
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //SAVE BUTTON
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: height * 0.01),
                                  child: InkWell(
                                    onTap: () {
                                      if (_newPassFormKey.currentState!
                                          .validate()) {
                                        authentication
                                            .changePassword("Old Password",
                                                _newPassController.text)
                                            .whenComplete(() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MainScreen()));
                                        });
                                      }
                                    },
                                    child: Container(
                                      width: width * 0.5,
                                      height: height * 0.04,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 232, 247, 240),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  207, 62, 73, 101),
                                              blurRadius: 0,
                                              offset: Offset(0, 5),
                                            ),
                                          ]),
                                      child: Text(
                                        'Save',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'OpunMai',
                                          fontWeight: FontWeight.w700,
                                          fontSize: height * 0.02,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
