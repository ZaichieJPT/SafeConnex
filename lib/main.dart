// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_init.dart';
import 'package:safeconnex/front_end_code/components/carousel_slider.dart';
import 'package:safeconnex/front_end_code/pages/agency_pages/agency_home_mainscreen.dart';
import 'package:safeconnex/front_end_code/pages/circle_pages/circle_page.dart';
import 'package:safeconnex/front_end_code/pages/geofencing_page.dart';
import 'package:safeconnex/front_end_code/pages/home_mainscreen.dart';
import 'package:safeconnex/front_end_code/pages/join_circle.dart';
import 'package:safeconnex/front_end_code/pages/login_page.dart';
import 'package:safeconnex/front_end_code/pages/onboarding_page.dart';
import 'package:safeconnex/front_end_code/pages/password_change_page.dart';
import 'package:safeconnex/front_end_code/provider/user_map_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'front_end_code/pages/loading_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseInit.rootFirebase;
  DependencyInjector().setupDependencyInjector();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isFirstTimeOpen;

  Future<void> setPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // Removed setState count cause problems
    setState(() {
      isFirstTimeOpen = preferences.getBool("isFirstTime");
      switch (isFirstTimeOpen) {
        case true:
          preferences.setBool("isFirstTime", false);
          break;
        case false:
        case null:
          preferences.setBool("isFirstTime", true);
          break;
      }
    });
  }

  @override
  void initState() {
    setPreferences();
    print('super init: ${isFirstTimeOpen}');
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    //setPreferences();
    precacheImage(
        AssetImage("assets/images/create_circle_background.png"), context);
    precacheImage(AssetImage("assets/images/circle_background.png"), context);
    if (isFirstTimeOpen == null) {
      setPreferences();
      return Material(
        child: Container(
          color: Colors.white,
          child: CircularProgressIndicator(),
        ),
      );
    }
    return MaterialApp(
      title: 'Safe Connex',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 0, 21, 255)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: isFirstTimeOpen! == true ? "/" : "/login",
      routes: {
        "/": (context) => OnBoardingScreen(),
        "/login": (context) => LoginPage(),
        "/home": (context) => MainScreen(),
        "/agencyPage": (context) => AgencyMainScreen(),
        "/create_circle": (context) => CirclePage(),
        "/join_circle": (context) => JoinCirclePage(),
        "/changePassword": (context) => PasswordChange(),
        "/loading_screen": (context) => CircularLoadingScreen(),
        "/temp2": (context) => GeofencingPage(),
        "/temp3": (context) => CarouseSliderComponent(),
      },
      //home: MainScreen(),
    );
  }
}