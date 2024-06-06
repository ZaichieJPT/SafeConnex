// ignore_for_file: prefer_const_constructors
import 'package:email_validator/email_validator.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:safeconnex/backend_code/firebase_scripts/firebase_auth.dart";
import "package:safeconnex/front_end_code/components/signup_continue_btn.dart";
import "package:safeconnex/front_end_code/components/signup_textformfield.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:safeconnex/front_end_code/provider/setting_provider.dart";

class EmailCard extends StatefulWidget {
  const EmailCard({
    super.key,
    required this.emailController,
    required this.backClicked,
    required this.continueClicked,
  });

  final TextEditingController emailController;
  final Function() backClicked;
  final Function() continueClicked;

  @override
  State<EmailCard> createState() => _EmailCardState();
}

class _EmailCardState extends State<EmailCard> {
  final _emailCardFormKey = GlobalKey<FormState>();
  SettingsProvider provider = SettingsProvider();
  FirebaseAuthHandler authHandler = FirebaseAuthHandler();

  @override
  void dispose() {
    widget.emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              //color: Colors.amber,
              //margin: EdgeInsets.only(top: 25),
              height: height * 0.32,
              width: width,
              child: Container(
                margin: EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 221, 228),
                  borderRadius: BorderRadius.circular(width * 0.07),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(62, 72, 76, 148),
                      blurRadius: 20.0,
                      offset: Offset(0, -20),
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(width * 0.02),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 2,
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
                              "We're almost there!",
                              style: TextStyle(
                                fontSize: width * 0.035,
                                fontFamily: 'OpunMai',
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 62, 73, 101),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //ENTER YOU EMAIL ADDRESS
                      Flexible(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: width * 0.06,
                                right: width * 0.33,
                              ),
                              child: Container(
                                //color: Colors.white,
                                width: width,
                                alignment: Alignment.centerLeft,
                                child: FittedBox(
                                  child: Text(
                                    "Enter your e-mail\naddress",
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
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //EMAIL ADDRESS
                            Form(
                              key: _emailCardFormKey,
                              child: SignupFormField(
                                hintText: "Email Address",
                                controller: widget.emailController,
                                textMargin: 0,
                                validator: (email) {
                                  return provider.emailSignupValidator(context,
                                      height, width, email, authHandler);
                                },
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
              height: width * 0.4,
              width: width * 0.35,
              top: 5,
              right: 0,
              child: Image.asset(
                'assets/images/signup_page/signup_page_2.1.png',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
        BtnContinue(
          backgroundColor: Color.fromARGB(255, 255, 240, 243),
          borderColor: Color.fromARGB(255, 255, 221, 228),
          topMargin: height * 0.017,
          height: height * 0.05,
          leftMargin: width * 0.12,
          rightMargin: width * 0.12,
          fontSize: 12,
          btnName: "Continue",
          formKey: _emailCardFormKey,
          continueClicked: () {
            print("clicked");
            if (_emailCardFormKey.currentState!.validate()) {
              widget.continueClicked();
            } else {}
          },
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
        ),
      ],
    );
  }
}