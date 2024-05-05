// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import "package:firebase_core/firebase_core.dart";
import "package:safeconnex/backend_code/firebase_scripts/firebase_auth.dart";
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            //CARD CONTAINER
            Container(
              //color: Colors.amber,
              //margin: EdgeInsets.only(top: 25),
              height: 445,
              width: double.infinity,
              child: Container(
                margin: EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 237, 188),
                  borderRadius: BorderRadius.circular(30),
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
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          //BACK ICON BUTTON
                          ClipRRect(
                            borderRadius: BorderRadius.circular(300),
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
                            "Setup Your Password",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'OpunMai',
                            ),
                          ),
                        ],
                      ),
                      //CREATE YOUR PASSWORD
                      Container(
                        //color: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Create your\nPassword",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: "OpunMai",
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 62, 73, 101),
                            height: 1.5,
                          ),
                        ),
                      ),
                      //PASSWORD FIELD
                      SizedBox(
                        height: 15,
                      ),
                      Form(
                        key: passFormKey,
                        child: Column(
                          children: [
                            LoginPassField(
                              hintText: "Password",
                              passController: widget.passController,
                              onChanged: onPasswordChanged,
                              validator: (value) {
                                if (value.toString().isEmpty ||
                                    strengthCount < 5) {
                                  setState(() {
                                    isPassValidated = true;
                                  });
                                }
                                return provider.passValidator(
                                    value, strengthCount);
                              },
                              isValidated: isPassValidated,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //CONFIRM PASSWORD FIELD
                            LoginPassField(
                              hintText: "Confirm Password",
                              passController: widget.confirmPassController,
                              validator: (confirmPass) {
                                if (confirmPass.length > 0) {
                                  setState(() {
                                    isConfirmPassValidated = true;
                                  });
                                  return provider.confirmPassMismatch(
                                      confirmPass, widget.passController.text);
                                }
                                return null;
                              },
                              isValidated: isConfirmPassValidated,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 15,
                      ),
                      //PASSWORD VALIDATION
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 25),
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
                                    color: Color.fromARGB(255, 62, 73, 101),
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
                              checkText: "At least 1 uppercase letter",
                              isValid: hasUpperCase,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            PassCheck(
                              checkText: "At least 1 lowercase letter",
                              isValid: hasLowerCase,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            PassCheck(
                              checkText: "At least 1 special character",
                              isValid: hasSpecialChars,
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
              height: 175,
              width: 175,
              top: -5,
              right: -10,
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
          width: double.infinity,
          height: 40,
          margin: EdgeInsets.only(
            left: 50,
            right: 50,
            top: 15,
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
                FirebaseAuthHandler firebaseAuth = FirebaseAuthHandler();
                firebaseAuth.registerEmailAccount(
                    widget.emailController.text, widget.passController.text,
                    widget.firstNameController.text,
                    widget.lastNameController.text, 0101,
                    widget.dateController.text);
                print(FirebaseAuthHandler.firebaseSignUpException);
                Future.delayed(Duration(seconds: 1), (){
                  print("1 second");
                  print(FirebaseAuthHandler.firebaseSignUpException);
                  if (FirebaseAuthHandler.firebaseSignUpException == null) {
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
