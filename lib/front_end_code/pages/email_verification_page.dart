// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_authentication.dart';
import 'package:safeconnex/front_end_code/components/home_components/error_snackbar.dart';
import 'package:safeconnex/front_end_code/pages/login_page.dart';
import 'package:safeconnex/front_end_code/provider/setting_provider.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  double height = 0;
  double width = 0;
  bool obscureText = false;
  bool confirmObscureText = false;
  double strengthValue = 0;
  int strengthCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DependencyInjector().locator<SafeConnexAuthentication>().signOutAccount();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.sizeOf(context).height;
    width = MediaQuery.sizeOf(context).width;

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: height * 0.05,
                    ),
                    //VERIFY YOUR EMAIL
                    Container(
                      height: height * 0.1,
                      alignment: Alignment.center,
                      //color: Colors.blue,
                      child: FittedBox(
                        child: Text(
                          'Verify Your Email',
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
                    //VERIFY EMAIL IMAGE ICON
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
                                'assets/images/email_verify_icon.png',
                                width: width * 0.65,
                              ),
                            ),
                            Flexible(
                              child: Container(
                                height: height * 0.1,
                                alignment: Alignment.center,
                                //color: Colors.blue,
                                child: FittedBox(
                                  child: Text(
                                    'Your account is almost ready!',
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'OpunMai',
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromARGB(
                                          255, 70, 85, 104),
                                      fontSize: height * 0.02,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Flexible(
                              child: Container(
                                height: height * 0.1,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.01),
                                //color: Colors.blue,
                                child: Text(
                                  'To complete your signup,  we\'ve sent a verification link to your email. Click the link to verify your account and get started!',
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'OpunMai',
                                    fontWeight: FontWeight.w400,
                                    color:
                                        const Color.fromARGB(255, 70, 85, 104),
                                    fontSize: height * 0.018,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: height * 0.045,
                            ),

                            //LOGIN BUTTON
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: height * 0.01),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => LoginPage(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: width * 0.5,
                                    height: height * 0.04,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 232, 247, 240),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                207, 62, 73, 101),
                                            blurRadius: 0,
                                            offset: Offset(0, 5),
                                          ),
                                        ]),
                                    child: Text(
                                      'Login',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'OpunMai',
                                        fontWeight: FontWeight.w700,
                                        fontSize: height * 0.022,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
