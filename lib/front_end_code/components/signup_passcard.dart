// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import "package:firebase_core/firebase_core.dart";
import "package:flutter/cupertino.dart";
import "package:safeconnex/backend_code/firebase_scripts/safeconnex_authentication.dart";
import "package:safeconnex/backend_code/firebase_scripts/firebase_auth.dart";
import "package:safeconnex/controller/app_manager.dart";
import "package:safeconnex/front_end_code/components/signup_passfield.dart";
import "package:safeconnex/front_end_code/components/signup_passvalidation.dart";
import "package:safeconnex/front_end_code/pages/login_page.dart";
import "package:safeconnex/front_end_code/provider/setting_provider.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

//final passFieldFormKey = GlobalKey<FormState>();

class PassCard extends StatefulWidget {
  const PassCard({
    super.key,
    required this.passController,
    required this.confirmPassController,
    required this.backClicked,
    //Newly Added
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.dateController,
  });

  final TextEditingController passController;
  final TextEditingController confirmPassController;
  final Function() backClicked;
  // Newly Added
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController dateController;

  @override
  State<PassCard> createState() => _PassCardState();
}

class _PassCardState extends State<PassCard> {
  bool isEightChars = false;
  bool hasNumber = false;
  bool hasUpperCase = false;
  bool hasLowerCase = false;
  bool hasSpecialChars = false;

  double strengthValue = 0;
  String strengthText = '';
  Color strengthColor = Colors.transparent;
  bool isPassValidated = false;
  bool isConfirmPassValidated = false;

  int strengthCount = 0;
  final provider = SettingsProvider();
  final passFormKey = GlobalKey<FormState>();
  //AppManager appController = AppManager();
  SafeConnexAuthentication authentication = SafeConnexAuthentication();

  onPasswordChanged(password) {
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

      if (strengthCount < 3) {
        strengthText = "WEAK";
        strengthColor = Colors.red;
      } else if (strengthCount == 3 || strengthCount == 4) {
        strengthText = "GOOD";
        strengthColor = Color.fromARGB(255, 12, 192, 223);
      } else if (strengthCount == 5) {
        strengthText = "STRONG";
        strengthColor = Colors.green;
      }
    });
  }

  @override
  void dispose() {
    widget.firstNameController.dispose();
    widget.lastNameController.dispose();
    widget.dateController.dispose();
    widget.emailController.dispose();
    widget.passController.dispose();
    widget.confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            //CARD CONTAINER
            Container(
              //color: Colors.amber,
              //margin: EdgeInsets.only(top: 25),
              height: height * 0.53,
              width: double.infinity,
              child: Container(
                margin: EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 237, 188),
                  borderRadius: BorderRadius.circular(width * 0.07),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(126, 255, 139, 133),
                      blurRadius: 25.0,
                      offset: Offset(0, -30),
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(width * 0.02),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            //BACK ICON BUTTON
                            ClipRRect(
                              borderRadius: BorderRadius.circular(width),
                              child: IconButton(
                                icon: Icon(Icons.arrow_back_ios_new),
                                color: Colors.black,
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  iconSize: 12,
                                  minimumSize: Size(10, 10),
                                ),
                                onPressed: widget.backClicked,
                              ),
                            ),
                            //TOP TEXT
                            Text(
                              "Let's secure your account",
                              style: TextStyle(
                                fontSize: width * 0.035,
                                fontFamily: 'OpunMai',
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 62, 73, 101),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //CREATE YOUR PASSWORD
                      Padding(
                        padding: EdgeInsets.only(
                          left: width * 0.05,
                          right: width * 0.4,
                          top: 0,
                          bottom: height * 0.01,
                        ),
                        child: Container(
                          //color: Colors.white,
                          width: width,
                          alignment: Alignment.center,
                          child: Text(
                            "Create your\nPassword",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: height * 0.027,
                              fontFamily: "OpunMai",
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 62, 73, 101),
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                      //PASSWORD FIELDS
                      Flexible(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              flex: 2,
                              child: Form(
                                key: passFormKey,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    //PASSWORD
                                    Expanded(
                                      flex: 1,
                                      child: LoginPassField(
                                        hintText: "Password",
                                        passController: widget.passController,
                                        onChanged: onPasswordChanged,
                                        validator: (value) {
                                          return provider.passValidator(
                                              context,
                                              height,
                                              width,
                                              value,
                                              strengthCount);
                                          //value, strengthCount.round().toDouble());
                                        },
                                        isValidated: isPassValidated,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),

                                    //CONFIRM PASSWORD FIELD
                                    Expanded(
                                      flex: 1,
                                      child: LoginPassField(
                                        hintText: "Confirm Password",
                                        passController:
                                        widget.confirmPassController,
                                        validator: (confirmPass) {
                                          return provider.confirmPassMismatch(
                                            context,
                                            height,
                                            width,
                                            confirmPass,
                                            widget.passController.text,
                                            strengthCount,
                                          );
                                        },
                                        isValidated: isConfirmPassValidated,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            //PASSWORD VALIDATION
                            Flexible(
                              flex: 3,
                              child: FittedBox(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: width * 0.05,
                                    right: width * 0.05,
                                    top: height * 0.01,
                                    bottom: width * 0.02,
                                  ),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    //color: Colors.white,
                                    width: width,
                                    child: Column(
                                      children: [
                                        //PASSWORD STRENGTH
                                        Row(
                                          children: [
                                            Text(
                                              "Password Strength: ",
                                              style: TextStyle(
                                                fontSize: 11.5,
                                                fontFamily: "OpunMai",
                                                //fontWeight: FontWeight.w700,
                                                color: Color.fromARGB(
                                                    255, 62, 73, 101),
                                              ),
                                            ),
                                            Text(
                                              strengthText,
                                              style: TextStyle(
                                                fontSize: 11.5,
                                                fontFamily: "OpunMai",
                                                fontWeight: FontWeight.w700,
                                                color: strengthColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        //AT LEASt 8 CHARS
                                        SizedBox(
                                          height: 10,
                                        ),
                                        //FIRST CHECK
                                        PassCheck(
                                          checkText: "At least 8 characters",
                                          isValid: isEightChars,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        PassCheck(
                                          checkText: "At least 1 number",
                                          isValid: hasNumber,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        PassCheck(
                                          checkText:
                                          "At least 1 uppercase letter",
                                          isValid: hasUpperCase,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        PassCheck(
                                          checkText:
                                          "At least 1 lowercase letter",
                                          isValid: hasLowerCase,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        PassCheck(
                                          checkText:
                                          "At least 1 special character",
                                          isValid: hasSpecialChars,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              height: width * 0.45,
              width: width * 0.4,
              top: -5,
              right: -15,
              child: Image.asset(
                'assets/images/signup_page/signup_page_3.1.png',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
        //SUBMIT BUTTON
        Container(
          //color: Colors.white,
          width: width,
          height: height * 0.05,
          margin: EdgeInsets.only(
            left: width * 0.12,
            right: width * 0.12,
            top: height * 0.02,
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 255, 242, 205),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(
                  color: Color.fromARGB(255, 255, 237, 188),
                  width: 2,
                ),
              ),
            ),
            onPressed: () {
              if (passFormKey.currentState!.validate()) {
                authentication
                    .signUpWithEmailAccount(
                  widget.emailController.text,
                  widget.passController.text,
                  widget.firstNameController.text,
                  widget.lastNameController.text,
                  "1",
                  widget.dateController.text,
                )
                    .whenComplete(() {
                  if (SafeConnexAuthentication.signUpException == null) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  } else {
                    widget.backClicked();
                  }
                });
              }
            },
            child: FittedBox(
              child: Text(
                "Submit",
                style: TextStyle(
                  fontFamily: "OpunMai",
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 62, 73, 101),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}