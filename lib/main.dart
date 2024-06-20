// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:safeconnex/front_end_code/components/carousel_slider.dart';
import 'package:safeconnex/front_end_code/pages/agency_pages/agency_home_mainscreen.dart';
import 'package:safeconnex/front_end_code/pages/circle_pages/circle_page.dart';
import 'package:safeconnex/front_end_code/pages/circle_pages/circle_results_page.dart';
import 'package:safeconnex/front_end_code/pages/geofencing_page.dart';
import 'package:safeconnex/front_end_code/pages/home_mainscreen.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_init.dart';
import 'package:safeconnex/front_end_code//pages/signup_page.dart';
import 'package:safeconnex/front_end_code/pages/join_circle.dart';
import 'package:safeconnex/front_end_code/pages/circle_pages/join_circle_confirm.dart';
import 'package:safeconnex/front_end_code/pages/location_history_page.dart';
import 'package:safeconnex/front_end_code/pages/login_page.dart';
import 'package:safeconnex/front_end_code/pages/onboarding_page.dart';
import 'package:safeconnex/front_end_code/pages/password_change_page.dart';
import 'package:safeconnex/front_end_code/provider/new_map_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'backend_code/firebase_scripts/firebase_options.dart';
import 'controller/app_manager.dart';
import 'front_end_code/pages/circle_pages/create_circle_page.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('initializing firebase...');
  await FirebaseInit.rootFirebase;
  print(FirebaseInit.rootFirebase);
  print('initialization complete');
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
    setState(() {
      isFirstTimeOpen = preferences.getBool("isFirstTime");
    });
    switch (isFirstTimeOpen) {
      case true:
        preferences.setBool("isFirstTime", false);
        print('First time!');
        break;
      case false:
        print("Do Nothing");
      case null:
        print('initial: ${isFirstTimeOpen}');
        preferences.setBool("isFirstTime", true);
        print('new: ${isFirstTimeOpen}');
        break;
    }
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
    print('init state: ${isFirstTimeOpen}');
    precacheImage(
        AssetImage("assets/images/create_circle_background.png"), context);
    precacheImage(AssetImage("assets/images/circle_background.png"), context);
    if (isFirstTimeOpen == null) {
      print('call preferences');
      setPreferences();
      print('done with preferences');
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
      // initialRoute: isFirstTimeOpen! == true ? "/" : "/login",
      // routes: {
      //   "/": (context) => OnBoardingScreen(),
      //   "/login": (context) => LoginPage(),
      //   "/home": (context) => AgencyMainScreen(),
      //   "/create_circle": (context) => CirclePage(),
      //   "/join_circle": (context) => JoinCirclePage(),
      //   "/changePassword": (context) => PasswordChange(),
      //   "/temp": (context) => NewMapProvider(),
      //   "/temp2": (context) => GeofencingPage(),
      //   "/temp3": (context) => CarouseSliderComponent(),
      // },
      home: LocationHistory(),
    );
  }
}
