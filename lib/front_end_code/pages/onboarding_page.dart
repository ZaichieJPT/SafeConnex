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

  /*final bgImg_1 = Image.asset("assets/images/onboarding/onboard-bg-1.png");
  final bgImg_2 = Image.asset("assets/images/onboarding/onboard-bg-2.png");
  final bgImg_3 = Image.asset("assets/images/onboarding/onboard-bg-3.png");
*/
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
            top: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Icon(
                  Icons.cancel,
                  color: Colors.black,
                  size: 40,
                ),
                SizedBox(height: 10),
                Image.asset(
                  "assets/images/SafeConnex-Logo2.png",
                  scale: 17,
                ),
                SizedBox(height: 5),
                Text(
                  "YOUR SAFETY COMPANION",
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: "OpunMai",
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
          //BOTTOM GLASS CARD
          Positioned(
            top: MediaQuery.of(context).size.height * 0.57,
            left: 0,
            right: 0,
            child: SizedBox(
              //color: Colors.blue,
              height: MediaQuery.of(context).size.height * 0.45,
              child: Image.asset(
                  "assets/images/onboarding/onboard-glass-card.png"),
            ),
          ),
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
          ),
        ],
      ),
    );
  }
}
