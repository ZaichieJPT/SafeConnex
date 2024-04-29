// ignore_for_file: prefer_const_constructors
import "package:firebase_auth/firebase_auth.dart";
import "package:safeconnex/backend_code/firebase_scripts/firebase_auth.dart";
import "package:safeconnex/front_end_code/components/login_passformfield.dart";
import "package:safeconnex/front_end_code/components/login_textformfield.dart";
import 'package:email_validator/email_validator.dart';
import "package:safeconnex/front_end_code/components/signup_continue_btn.dart";
import "package:safeconnex/front_end_code/pages/home_page.dart";
import 'package:safeconnex/front_end_code/pages/signup_page.dart';
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _loginFormKey = GlobalKey<FormState>();

  bool isPasswordValidated = false;

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 5), () {
      FirebaseAuthHandler authHandler = FirebaseAuthHandler();
      if(authHandler.authHandler.currentUser != null){
        Navigator.pushNamed(context, "/home");
      }
    });
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login-bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              reverse: true,
              child: Stack(
                children: [
                  //WELCOME BACK SHADOW
                  Positioned(
                    top: 103,
                    left: 37,
                    child: Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: "OpunMai",
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 238, 232, 221),
                      ),
                    ),
                  ),
                  //WELCOME BACK TEXT
                  Positioned(
                    top: 100,
                    left: 35,
                    child: Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: "OpunMai",
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 62, 73, 101),
                      ),
                    ),
                  ),
                  //BACK CARD
                  Positioned(
                    top: 185,
                    left: 55,
                    child: Container(
                      width: 285,
                      height: 445,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 235, 228, 203),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  //CIRCLE DESIGN
                  Positioned(
                    top: 210,
                    left: 325,
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 252, 223, 105),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  //LOGIN CARD
                  Positioned(
                    top: 170,
                    left: 40,
                    child: Container(
                      width: 285,
                      height: 440,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 253, 250, 197),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Color.fromARGB(255, 235, 228, 203),
                          )),
                    ),
                  ),
                  Positioned(
                    top: 150,
                    left: 150,
                    child: Icon(
                      Icons.cancel,
                      size: 75,
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 220),
                      //APP LOGO
                      Container(
                        alignment: Alignment.center,
                        width: 375,
                        //color: Color.fromARGB(93, 18, 198, 222),
                        child: Form(
                          key: _loginFormKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              //LOGIN TEXT
                              Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 35,
                                  fontFamily: "OpunMai",
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromARGB(255, 62, 73, 101),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              //EMAIL TEXT FIELD
                              Container(
                                //color: Colors.black,
                                alignment: AlignmentDirectional.center,
                                width: 300,
                                child: LoginFormField(
                                  hintText: 'Email',
                                  controller: _emailController,
                                  textMargin: 10,
                                  validator: (email) {
                                    if (email.toString().isEmpty) {
                                      return "Email is required";
                                    } else if (!EmailValidator.validate(
                                        email)) {
                                      return "Enter a valid email";
                                    }
                                    return null;
                                  },
                                  height: 60,
                                  verticalPadding: 0,
                                  borderRadius: 7,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              //PASSWORD
                              Container(
                                //color: Colors.black,
                                alignment: AlignmentDirectional.center,
                                //margin: EdgeInsets.only(right: 30, left: 20),
                                width: 300,
                                child: PassFormField(
                                  hintText: 'Password',
                                  passController: _passController,
                                  textMargin: 10,
                                  //height: 55,
                                  verticalPadding: 0,
                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      setState(() {
                                        isPasswordValidated = true;
                                      });
                                      return "Please enter your password";
                                    }
                                    return null;
                                  },
                                  isValidated: isPasswordValidated,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              //FORGOT PASSWORD
                              Container(
                                //color: Colors.amber,
                                width: 260,
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "OpunMai",
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.6,
                                      color: Color.fromARGB(255, 62, 73, 101),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //LOGIN BUTTON
                              BtnContinue(
                                backgroundColor:
                                    Color.fromARGB(255, 236, 230, 217),
                                borderColor: Color.fromARGB(255, 235, 228, 203),
                                btnName: 'Login',
                                height: 30,
                                topMargin: 0,
                                leftMargin: 120,
                                rightMargin: 120,
                                fontSize: 15,
                                formKey: _loginFormKey,
                                continueClicked: () {
                                  if (_loginFormKey.currentState!.validate()) {
                                    FirebaseAuthHandler authHandler = FirebaseAuthHandler();
                                    authHandler.loginEmailAccount(_emailController.text, _passController.text);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => HomePage())
                                    );
                                  } else {}
                                },
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              //DONT HAVE AN ACCOUNT
                              Container(
                                height: 90,
                                padding: EdgeInsets.only(bottom: 10),
                                alignment: Alignment.topCenter,
                                //color: Colors.blueGrey,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don't have an account? ",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: const Color.fromARGB(
                                            255, 120, 120, 120),
                                      ),
                                    ),
                                    GestureDetector(
                                      child: Text(
                                        "Sign Up",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color:
                                              Color.fromARGB(255, 62, 73, 101),
                                          fontWeight: FontWeight.bold,
                                          decorationThickness: 2,
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SignupPage(),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
