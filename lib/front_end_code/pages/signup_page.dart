// ignore_for_file: prefer_const_constructors
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

  double positionTop_1 = 70.0;
  double positionTop_2 = 160.0;

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
          scaleFactor_1 = 0.80;
          positionTop_1 = 40.0;
          scaleFactor_2 = 0.9;
          positionTop_2 = 135.0;
        }
      } else {
        isContinueClicked_1 = true;
        isEmailCardVisible = true;
        scaleFactor_1 = 0.85;
        positionTop_1 = 50.0;
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
        positionTop_1 = 50.0;
        scaleFactor_2 = 1.0;
        positionTop_2 = 160.0;
      } else {
        if (isContinueClicked_1) {
          isContinueClicked_1 = false;
          isEmailCardVisible = false;
          scaleFactor_1 = 1.0;
          positionTop_1 = 70.0;
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
  Widget build(BuildContext context) {
    //final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                //color: Colors.black,
                child: Stack(
                  children: [
                    Positioned(
                      top: (isKeyboardVisible && !isContinueClicked_1)
                          ? -10
                          : (isKeyboardVisible && isContinueClicked_1)
                          ? -30
                          : 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          //LOGO, SAFECONNEX TEXT, AND LOGIN BUTTON CONTAINER
                          SizedBox(
                            height: 33,
                          ),
                          Container(
                            //color: Colors.lightBlue,
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            //height: 100,
                            child: Row(
                              children: [
                                //APP LOGO
                                Icon(
                                  Icons.cancel,
                                  size: 35,
                                  color: Colors.black,
                                ),
                                //SAFECONNEX LOGO
                                Container(
                                  //color: Colors.black,
                                  //height: 100,
                                  width: 150,
                                  child: Image.asset(
                                    "assets/images/SafeConnex-Logo2.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                //LOGIN BUTTON
                                SizedBox(
                                  width: 60,
                                ),
                                Expanded(
                                  child: Container(
                                    //color: Colors.black,
                                    height: 30,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                        Color.fromARGB(255, 92, 225, 230),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: FittedBox(
                                        child: Text(
                                          "Log In",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: "OpunMai",
                                            fontWeight: FontWeight.w700,
                                            color: Color.fromARGB(
                                                255, 62, 73, 101),
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
                          SizedBox(
                            height: 33,
                          ),
                        ],
                      ),
                    ),

                    //NAME CARD CONTAINER
                    Positioned(
                      top: (isKeyboardVisible && !isContinueClicked_1)
                          ? 50
                          : (isKeyboardVisible && isContinueClicked_1)
                          ? 10
                          : positionTop_1,
                      left: 0,
                      right: 0,
                      child: Transform.scale(
                        scale: scaleFactor_1,
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
                  ],
                ),
              ),
              //EMAIL CARD CONTAINER
              Visibility(
                visible: isEmailCardVisible,
                child: Positioned(
                  top: (isKeyboardVisible && !isContinueClicked_2)
                      ? 110
                      : (isKeyboardVisible && isContinueClicked_2)
                      ? 60
                      : positionTop_2,
                  left: 0,
                  right: 0,
                  child: Transform.scale(
                    scale: scaleFactor_2,
                    child: Column(
                      children: [
                        //EMAIL CARD
                        EmailCard(
                          emailController: widget._emailController,
                          backClicked: backClicked,
                          continueClicked: continueClicked,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: isPassCardVisible,
                child: Positioned(
                  top: isKeyboardVisible ? -80 : 250,
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
                      confirmPassController: widget._confirmPassController,
                      backClicked: backClicked,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
