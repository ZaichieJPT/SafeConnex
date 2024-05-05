import 'package:flutter/material.dart';
import 'package:safeconnex/front_end_code/pages/circle_page.dart';
import 'package:safeconnex/front_end_code/pages/circle_results_page.dart';
import 'package:safeconnex/front_end_code/pages/home_page.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_init.dart';
import 'package:safeconnex/front_end_code//pages/signup_page.dart';
import 'package:safeconnex/front_end_code/pages/join_circle.dart';
import 'package:safeconnex/front_end_code/pages/join_circle_confirm.dart';
import 'package:safeconnex/front_end_code/pages/login_page.dart';
import 'package:safeconnex/front_end_code/pages/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'backend_code/firebase_scripts/firebase_options.dart';
import 'front_end_code/pages/create_circle_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseInit.rootFirebase;
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/images/create_circle_background.png"), context);
    precacheImage(AssetImage("assets/images/circle_background.png"), context);
    return MaterialApp(
      title: 'Safe Connex',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 0, 21, 255)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/login",
      routes: {
        "/": (context) => OnBoardingScreen(),
        "/login": (context) => LoginPage(),
        "/home": (context) => HomePage(),
        "/create_circle": (context) => CirclePage(),
        "/join_circle": (context) => JoinCirclePage()
      },
      //home: LoginPage(),
    );
  }
}