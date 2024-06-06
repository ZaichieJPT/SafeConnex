// ignore_for_file: prefer_const_constructors
import "package:safeconnex/backend_code/firebase_scripts/firebase_auth.dart";
import "package:safeconnex/front_end_code/components/signup_emailcard.dart";
import "package:safeconnex/front_end_code/components/signup_namecard.dart";
import "package:safeconnex/front_end_code/components/signup_passcard.dart";
import "package:safeconnex/front_end_code/pages/login_page.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

import "onboarding_page.dart";

class SignupPage extends StatefulWidget {
  SignupPage({super.key});

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  double scaleFactor_1 = 1.0;
  double scaleFactor_2 = 1.0;

  double positionTop_1 = 0.0;
  double positionTop_2 = 0.0;

  bool isEmailCardVisible = false;
  bool isPassCardVisible = false;

  bool isContinueClicked_1 = false;
  bool isContinueClicked_2 = false;
  bool isContinueClicked_3 = false;

  continueClicked() {
    setState(() {
      if (isContinueClicked_1) {
        if (isContinueClicked_2) {
          if (isContinueClicked_3) {
          } else {
            isContinueClicked_3 = true;
            //GO TO NEXT PAGE
          }
        } else {
          isContinueClicked_2 = true;
          isPassCardVisible = true;
          scaleFactor_1 = 0.75;
          scaleFactor_2 = 0.9;
        }
      } else {
        isContinueClicked_1 = true;
        isEmailCardVisible = true;
        scaleFactor_1 = 0.85;
        positionTop_1 = 0.0;
      }
    });
    FocusManager.instance.primaryFocus?.unfocus();
  }

  backClicked() {
    setState(() {
      if (isContinueClicked_2) {
        isContinueClicked_2 = false;
        isPassCardVisible = false;
        scaleFactor_1 = 0.85;
        scaleFactor_2 = 1.0;
      } else {
        if (isContinueClicked_1) {
          isContinueClicked_1 = false;
          isEmailCardVisible = false;
          scaleFactor_1 = 1.0;
        } else {
          //GO BACK TO ONBOARDING
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OnBoardingScreen(),
            ),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    widget._firstNameController.dispose();
    widget._lastNameController.dispose();
    widget._emailController.dispose();
    widget._dateController.dispose();
    widget._passController.dispose();
    widget._confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    FirebaseAuthHandler firebaseAuth = FirebaseAuthHandler();

    positionTop_2 = height * 0.1;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              //LOGO, SAFECONNEX TEXT, AND LOGIN BUTTON CONTAINER
              Container(
                //color: Colors.lightBlue,
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                height: height * 0.12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //APP LOGO
                    Row(
                      children: [
                        SizedBox(
                          height: height * 0.07,
                          child: Image.asset(
                            'assets/images/splash-logo.png',
                          ),
                        ),
                        //SAFECONNEX LOGO
                        SizedBox(
                          height: height * 0.03,
                          child: Image.asset(
                            'assets/images/SafeConnex-Logo2.png',
                          ),
                        ),
                      ],
                    ),
                    //LOGIN BUTTON
                    Flexible(
                      child: SizedBox(
                        height: height * 0.035,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 92, 225, 230),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(width * 0.03),
                            ),
                          ),
                          child: FittedBox(
                            child: Text(
                              "Log In",
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: "OpunMai",
                                fontWeight: FontWeight.w700,
                                color: Color.fromARGB(255, 62, 73, 101),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //NAME CARD CONTAINER
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Transform.scale(
                        scale: (isKeyboardVisible && !isContinueClicked_1)
                            ? scaleFactor_1
                            : (isKeyboardVisible &&
                            isContinueClicked_1 &&
                            (!isContinueClicked_2 ||
                                !isContinueClicked_3))
                            ? 0
                            : scaleFactor_1,
                        child: Column(
                          children: [
                            //NAME CARD
                            NameCard(
                              firstNameController: widget._firstNameController,
                              lastNameController: widget._lastNameController,
                              dateController: widget._dateController,
                              backClicked: backClicked,
                              continueClicked: continueClicked,
                            ),
                          ],
                        ),
                      ),
                    ),
                    //EMAIL CARD
                    if (isEmailCardVisible) ...[
                      Positioned(
                        top: (isKeyboardVisible && !isContinueClicked_2)
                            ? height * 0.01
                            : (isKeyboardVisible && isContinueClicked_2)
                            ? height * 0
                            : positionTop_2,
                        left: 0,
                        right: 0,
                        child: Transform.scale(
                          scale: (isKeyboardVisible &&
                              isContinueClicked_2 &&
                              !isContinueClicked_3)
                              ? height * 0.8
                              : scaleFactor_2,
                          child: Column(
                            children: [
                              //EMAIL CARD
                              EmailCard(
                                emailController: widget._emailController,
                                backClicked: backClicked,
                                continueClicked: continueClicked,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                  MediaQuery.of(context).viewInsets.bottom,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    //PASSCARD
                    if (isPassCardVisible) ...[
                      Positioned(
                        bottom: (isKeyboardVisible && !isContinueClicked_2)
                            ? 0
                            : (isKeyboardVisible && isContinueClicked_2)
                            ? MediaQuery.of(context).viewInsets.bottom
                            : height * 0.05,
                        left: 0,
                        right: 0,
                        child: SingleChildScrollView(
                          reverse: true,
                          child: PassCard(
                            firstNameController: widget._firstNameController,
                            lastNameController: widget._lastNameController,
                            emailController: widget._emailController,
                            dateController: widget._dateController,
                            passController: widget._passController,
                            confirmPassController:
                            widget._confirmPassController,
                            backClicked: backClicked,
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}