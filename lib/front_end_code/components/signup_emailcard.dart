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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              //color: Colors.amber,
              //margin: EdgeInsets.only(top: 25),
              height: 250,
              width: double.infinity,
              child: Container(
                margin: EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 221, 228),
                  borderRadius: BorderRadius.circular(30),
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
                            "We'll use this to sign you in",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'OpunMai',
                            ),
                          ),
                        ],
                      ),
                      //WHAT'S YOUR NAME
                      Container(
                        //color: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Enter your e-mail\naddress",
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
                      //EMAIL ADDRESS
                      SizedBox(
                        height: 15,
                      ),
                      Form(
                        key: _emailCardFormKey,
                        child: SignupFormField(
                          hintText: "Email Address",
                          controller: widget.emailController,
                          textMargin: 0,
                          validator: (email) {
                            Future.delayed(Duration(seconds: 1), (){
                              print("validator");
                              print(FirebaseAuthHandler.firebaseSignUpException);

                              if (widget.emailController.text.isEmpty) {
                                return "Email is required";
                              }
                              else if(FirebaseAuthHandler.firebaseSignUpException != null){
                                return FirebaseAuthHandler.firebaseSignUpException;
                              }
                              // Still Errors Here
                              //else if (!EmailValidator.validate(email)) {
                               // return "Enter a valid email";
                              //}
                              return null;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              height: 140,
              width: 140,
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
          topMargin: 15.0,
          height: 40,
          leftMargin: 50,
          rightMargin: 50,
          fontSize: 12,
          btnName: "Continue",
          formKey: _emailCardFormKey,
          continueClicked: () {
            print("clicked");
            if (_emailCardFormKey.currentState!.validate()) {
              widget.continueClicked();
            } else {

            }
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
