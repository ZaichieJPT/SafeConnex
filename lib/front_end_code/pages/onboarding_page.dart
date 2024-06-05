// ignore_for_file: prefer_const_constructors
import 'package:safeconnex/front_end_code/components/onboard_pages.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import "package:safeconnex/front_end_code/pages/login_page.dart";
import "package:safeconnex/front_end_code/pages/signup_page.dart";
import "package:safeconnex/front_end_code/components/signup_continue_btn.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = PageController();
  String overviewTitle = 'Stay Connected';
  String overviewSubtitle =
      'Stay connected with your family and\nmonitor their safety.';

  @override
  void didChangeDependencies() {
    //LOGIN BG IMAGE
    precacheImage(const AssetImage("assets/images/login-bg.png"), context);
    //ONBOARD BG IMAGES
    precacheImage(
        const AssetImage("assets/images/onboarding/onboard-bg-1.jpg"), context);
    precacheImage(
        const AssetImage("assets/images/onboarding/onboard-bg-2.jpg"), context);
    precacheImage(
        const AssetImage("assets/images/onboarding/onboard-bg-3.jpg"), context);
    //ONBOARD IMAGES
    precacheImage(
        const AssetImage("assets/images/onboarding/onboard-image-1.png"),
        context);
    precacheImage(
        const AssetImage("assets/images/onboarding/onboard-image-2.png"),
        context);
    precacheImage(
        const AssetImage("assets/images/onboarding/onboard-image-3.png"),
        context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2))
        .then((value) => FlutterNativeSplash.remove());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Stack(
        children: [
          //GRADIENT BG PAGES
          PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                switch (index) {
                  case 0:
                    overviewTitle = 'Stay Connected';
                    overviewSubtitle =
                        'Stay connected with your family and\nmonitor their safety.';
                    break;

                  case 1:
                    overviewTitle = 'Be Informed';
                    overviewSubtitle =
                        'Be informed of the latest safety updates\ndirectly from local authorities.';
                    break;

                  case 2:
                    overviewTitle = 'Alert Your Circle';
                    overviewSubtitle =
                        'Alert your family or local authorities in\ntimes of emergency.';
                    break;
                }
              });
            },
            children: [
              OnBoardPage(
                backgroundImage:
                    AssetImage("assets/images/onboarding/onboard-bg-1.jpg"),
                pageImage:
                    Image.asset("assets/images/onboarding/onboard-image-1.png"),
              ),
              OnBoardPage(
                backgroundImage:
                    AssetImage("assets/images/onboarding/onboard-bg-2.jpg"),
                pageImage:
                    Image.asset("assets/images/onboarding/onboard-image-2.png"),
              ),
              OnBoardPage(
                backgroundImage:
                    AssetImage("assets/images/onboarding/onboard-bg-3.jpg"),
                pageImage:
                    Image.asset("assets/images/onboarding/onboard-image-3.png"),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                //APP LOGO
                Container(
                  height: height * 0.1,
                  padding: EdgeInsets.only(top: height * 0.01),
                  //color: const Color.fromARGB(105, 0, 0, 0),
                  child: Image.asset(
                    'assets/images/splash-logo.png',
                  ),
                ),
                //SAFECONNEX LOGO
                Padding(
                  padding: EdgeInsets.only(bottom: height * 0.005),
                  child: Container(
                    height: height * 0.035,
                    //color: const Color.fromARGB(105, 0, 0, 0),
                    child: Image.asset(
                      "assets/images/SafeConnex-Logo2.png",
                    ),
                  ),
                ),
                //TAGLINE
                SizedBox(
                  height: height * 0.015,
                  child: FittedBox(
                    child: Text(
                      "YOUR SAFETY COMPANION",
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: "OpunMai",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          //BOTTOM GLASS CARD
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              //color: Colors.blue,
              height: height * 0.45,
              width: width,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    "assets/images/onboarding/onboard-glass-card.png",
                    fit: BoxFit.fill,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: height * 0.075),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //NEXT BUTTON
                        Flexible(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.only(top: height * 0.013),
                            child: Container(
                              width: width * 0.2,
                              height: height * 0.08,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color.fromARGB(255, 255, 222, 89),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  controller.nextPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                icon: FittedBox(
                                  child: Text(
                                    String.fromCharCode(Icons.east.codePoint),
                                    style: TextStyle(
                                      inherit: false,
                                      color: Colors.white,
                                      fontSize: width * 0.1,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: Icons.east.fontFamily,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //APP OVERVIEW TEXTS
                        Flexible(
                          child: FittedBox(
                            child: Text(
                              overviewTitle,
                              style: TextStyle(
                                fontSize: height * 0.03,
                                fontFamily: "OpunMai",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        //APP OVERVIEW TEXTS
                        Flexible(
                          child: FittedBox(
                            child: Text(
                              overviewSubtitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: height * 0.015,
                                fontFamily: "OpunMai",
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                        //PAGE INDICATOR
                        Flexible(
                          child: SmoothPageIndicator(
                            controller: controller,
                            count: 3,
                            onDotClicked: (index) => controller.animateToPage(
                              index,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            ),
                            effect: CustomizableEffect(
                              spacing: 5,
                              dotDecoration: DotDecoration(
                                borderRadius: BorderRadius.circular(10),
                                height: height * 0.008,
                                width: width * 0.08,
                                color: Colors.grey,
                              ),
                              activeDotDecoration: DotDecoration(
                                borderRadius: BorderRadius.circular(10),
                                height: height * 0.008,
                                width: width * 0.08,
                                color: Color.fromARGB(255, 4, 226, 255),
                              ),
                            ),
                          ),
                        ),
                        //LOGIN / SIGNUP
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              //SIGN UP BUTTON
                              Flexible(
                                child: SizedBox(
                                  height: height * 0.045,
                                  width: width * 0.3,
                                  child: BtnContinue(
                                    backgroundColor: Colors.white,
                                    borderColor:
                                        Color.fromARGB(255, 188, 188, 188),
                                    fontColor: Colors.black,
                                    borderRadius: width * 0.025,
                                    borderWidth: 0.5,
                                    topMargin: 0,
                                    height: 0,
                                    leftMargin: 0,
                                    rightMargin: 0,
                                    fontSize: 13,
                                    btnName: "Sign Up",
                                    continueClicked: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignupPage(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),

                              //LOG IN BUTTON
                              Flexible(
                                child: SizedBox(
                                  height: height * 0.045,
                                  width: width * 0.3,
                                  child: BtnContinue(
                                    backgroundColor: Colors.cyanAccent,
                                    borderColor: Colors.cyanAccent,
                                    fontColor: Colors.black,
                                    borderRadius: width * 0.025,
                                    borderWidth: 0.5,
                                    topMargin: 0,
                                    height: 0,
                                    leftMargin: 0,
                                    rightMargin: 0,
                                    fontSize: 13,
                                    btnName: "Log In",
                                    continueClicked: () {
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          /*
          //NEXT, SIGNUP, & LOGIN BTNS/APP OVERVIEW TEXTS
          Positioned(
            top: 485,
            left: 0,
            right: 0,
            child: Column(
              children: [
                //NEXT BUTTON
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromARGB(255, 255, 222, 89),
                  ),
                  child: IconButton(
                    onPressed: () {
                      controller.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    icon: Text(
                      String.fromCharCode(Icons.east.codePoint),
                      style: TextStyle(
                        inherit: false,
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.w900,
                        fontFamily: Icons.east.fontFamily,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                //APP OVERVIEW TEXTS
                Text(
                  overviewTitle,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "OpunMai",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 15),
                //APP OVERVIEW TEXTS
                Text(
                  overviewSubtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: "OpunMai",
                    fontWeight: FontWeight.w600,
                    height: 1.7,
                  ),
                ),
                SizedBox(height: 25),
                //PAGE INDICATOR
                SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  onDotClicked: (index) => controller.animateToPage(
                    index,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  ),
                  effect: CustomizableEffect(
                    spacing: 5,
                    dotDecoration: DotDecoration(
                      borderRadius: BorderRadius.circular(10),
                      height: 7,
                      width: 30,
                      color: Colors.grey,
                    ),
                    activeDotDecoration: DotDecoration(
                      borderRadius: BorderRadius.circular(10),
                      height: 7,
                      width: 30,
                      color: Color.fromARGB(255, 4, 226, 255),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //SIGN UP BUTTON
                    SizedBox(
                      height: 40,
                      width: 130,
                      child: BtnContinue(
                        backgroundColor: Colors.white,
                        borderColor: Color.fromARGB(255, 188, 188, 188),
                        fontColor: Colors.black,
                        borderRadius: 15,
                        borderWidth: 0.5,
                        topMargin: 0,
                        height: 0,
                        leftMargin: 0,
                        rightMargin: 0,
                        fontSize: 14,
                        btnName: "Sign Up",
                        continueClicked: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupPage(),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 40),
                    //LOG IN BUTTON
                    SizedBox(
                      height: 40,
                      width: 130,
                      child: BtnContinue(
                        backgroundColor: Colors.cyanAccent,
                        borderColor: Colors.cyanAccent,
                        fontColor: Colors.black,
                        borderRadius: 15,
                        borderWidth: 0.5,
                        topMargin: 0,
                        height: 0,
                        leftMargin: 0,
                        rightMargin: 0,
                        fontSize: 14,
                        btnName: "Log In",
                        continueClicked: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),*/
        ],
      ),
    );
  }
}
