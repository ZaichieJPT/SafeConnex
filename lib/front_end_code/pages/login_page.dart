// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:safeconnex/backend_code/firebase_scripts/firebase_auth.dart";
import "package:safeconnex/backend_code/firebase_scripts/firebase_circle_database.dart";
import "package:safeconnex/backend_code/firebase_scripts/firebase_profile_storage.dart";
import "package:safeconnex/front_end_code/components/login_passformfield.dart";
import "package:safeconnex/front_end_code/components/login_textformfield.dart";
import 'package:email_validator/email_validator.dart';
import "package:safeconnex/front_end_code/components/signup_continue_btn.dart";
import "package:safeconnex/front_end_code/pages/home_mainscreen.dart";
import 'package:safeconnex/front_end_code/pages/signup_page.dart';
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import 'package:safeconnex/front_end_code/provider/setting_provider.dart';

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
  CircleDatabaseHandler circleDatabaseHandler = CircleDatabaseHandler();

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    FirebaseAuthHandler authHandler = FirebaseAuthHandler();
    Future.delayed(const Duration(milliseconds: 5), () {
      if(authHandler.authHandler.currentUser != null){
        FirebaseProfileStorage(authHandler.authHandler.currentUser!.uid);
        circleDatabaseHandler.getCircleList(authHandler.authHandler.currentUser!.uid);
        if(CircleDatabaseHandler.circleList.isNotEmpty){
          CircleDatabaseHandler.currentCircleCode = CircleDatabaseHandler.circleList[0]["circle_code"].toString();
        }
        Navigator.pushNamed(context, "/home");
      }
    });
    SettingsProvider provider = SettingsProvider();
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login-bg.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Container(
              height: height,
              width: width,
              alignment: Alignment.center,
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //WELCOME BACK
                    Container(
                      width: width,
                      padding: EdgeInsets.only(left: width * 0.1),
                      child: Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: height * 0.035,
                          fontFamily: "OpunMai",
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 62, 73, 101),
                          shadows: [
                            Shadow(
                              color: Color.fromARGB(255, 238, 232, 221),
                              //color: Colors.green,
                              blurRadius: 1,
                              offset: Offset(3.5, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //LOGIN CARD
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              //color: Colors.green,
                              width: width * 0.75,
                              height: height * 0.6,
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                width: width * 0.75,
                                height: height * 0.55,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 0,
                                  vertical: 20,
                                ),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 253, 250, 197),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Color.fromARGB(255, 235, 228, 203),
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 238, 232, 221),
                                      blurRadius: 1,
                                      offset: Offset(12, 12),
                                    ),
                                  ],
                                ),
                                //LOGIN CONTENTS
                                child: Form(
                                  key: _loginFormKey,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: SizedBox(
                                          height: height * 0.05,
                                        ),
                                      ),
                                      //LOGIN TEXT
                                      Flexible(
                                        flex: 5,
                                        child: Container(
                                          alignment: Alignment.center,
                                          //color: Colors.black,
                                          child: Text(
                                            'Login',
                                            style: TextStyle(
                                              fontSize: height * 0.05,
                                              fontFamily: "OpunMai",
                                              fontWeight: FontWeight.w700,
                                              color: Color.fromARGB(
                                                  255, 62, 73, 101),
                                            ),
                                          ),
                                        ),
                                      ),

                                      //EMAIL TEXT FIELD
                                      Flexible(
                                        flex: 4,
                                        child: Container(
                                          //color: Colors.black,
                                          alignment:
                                          AlignmentDirectional.center,
                                          //width: 300,
                                          child: LoginFormField(
                                            hintText: 'Email',
                                            controller: _emailController,
                                            textMargin: 10,
                                            validator: (email) {
                                              return provider.emailValidator(
                                                  context,
                                                  height,
                                                  width,
                                                  email,
                                                  authHandler);
                                            },
                                            height: 60,
                                            verticalPadding: 0,
                                            borderRadius: 7,
                                          ),
                                        ),
                                      ),

                                      //PASSWORD
                                      Flexible(
                                        flex: 4,
                                        child: Container(
                                          //color: Colors.black,
                                          alignment:
                                          AlignmentDirectional.center,
                                          //margin: EdgeInsets.only(right: 30, left: 20),
                                          width: 300,
                                          child: PassFormField(
                                            hintText: 'Password',
                                            passController: _passController,
                                            textMargin: 10,
                                            //height: 55,
                                            verticalPadding: 0,
                                            validator: (loginPass) {
                                              return provider
                                                  .loginPassValidatior(
                                                  context,
                                                  height,
                                                  width,
                                                  loginPass,
                                                  authHandler);
                                            },
                                            isValidated: isPasswordValidated,
                                          ),
                                        ),
                                      ),

                                      //FORGOT PASSWORD
                                      Flexible(
                                        flex: 3,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.05),
                                          child: Container(
                                            //color: Colors.amber,
                                            alignment: Alignment.centerRight,
                                            child: TextButton(
                                              onPressed: () {},
                                              child: FittedBox(
                                                child: Text(
                                                  'Forgot Password?',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: "OpunMai",
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: 0.6,
                                                    color: Color.fromARGB(
                                                        255, 62, 73, 101),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      //LOGIN BUTTON
                                      Flexible(
                                        flex: 4,
                                        child: BtnContinue(
                                          backgroundColor: Color.fromARGB(
                                              255, 236, 230, 217),
                                          borderColor: Color.fromARGB(
                                              255, 235, 228, 203),
                                          btnName: 'Login',
                                          height: height * 0.055,
                                          topMargin: 0,
                                          leftMargin: 10,
                                          rightMargin: 10,
                                          fontSize: 15,
                                          formKey: _loginFormKey,
                                          continueClicked: () {
                                            authHandler.loginEmailAccount(
                                                _emailController.text,
                                                _passController.text);

                                            Future.delayed(Duration(seconds: 1),
                                                    () {
                                                  if (_loginFormKey.currentState!
                                                      .validate()) {
                                                    if (authHandler
                                                        .firebaseLoginException ==
                                                        null) {
                                                      FirebaseProfileStorage(
                                                          authHandler
                                                              .authHandler
                                                              .currentUser!
                                                              .uid);
                                                      circleDatabaseHandler.getCircleList(authHandler.authHandler.currentUser!.uid);
                                                      if(CircleDatabaseHandler.circleList.isNotEmpty){
                                                        CircleDatabaseHandler.currentCircleCode = CircleDatabaseHandler.circleList[0]["circle_code"].toString();
                                                      }
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              MainScreen(),
                                                        ),
                                                      );
                                                    }
                                                  }
                                                });
                                          },
                                        ),
                                      ),
                                      //GOOGLE SIGN IN
                                      Flexible(
                                        flex: 4,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Divider(
                                                color: Color.fromARGB(
                                                    255, 236, 230, 217),
                                                thickness: 1.5,
                                                indent: 7,
                                                endIndent: 7,
                                              ),
                                            ),
                                            Text(
                                              "or login with ",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: const Color.fromARGB(
                                                    255, 120, 120, 120),
                                              ),
                                            ),
                                            InkWell(
                                              child: Image.asset(
                                                "assets/images/google_signin_icon.png",
                                                scale: 7,
                                              ),
                                              onTap: () {
                                                authHandler.signInWithGoogle();
                                              },
                                            ),
                                            Flexible(
                                              child: Divider(
                                                color: Color.fromARGB(
                                                    255, 236, 230, 217),
                                                thickness: 1.5,
                                                indent: 7,
                                                endIndent: 5,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //DONT HAVE AN ACCOUNT
                                      Flexible(
                                        flex: 3,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                  color: Color.fromARGB(
                                                      255, 62, 73, 101),
                                                  fontWeight: FontWeight.bold,
                                                  decorationThickness: 2,
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SignupPage(),
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
                            ),
                            //APP LOGO
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: height * 0.135,
                                //color: const Color.fromARGB(91, 244, 67, 54),
                                child: Image.asset(
                                  'assets/images/splash-logo.png',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
    );
  }
}