import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safeconnex/front_end_code/pages/home_page.dart';
import 'package:safeconnex/front_end_code/pages/news_page.dart';
import 'package:safeconnex/front_end_code/pages/home_mainscreen.dart';
import 'package:safeconnex/front_end_code/pages/password_change_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return MaterialApp(
      title: 'Home and Settings Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/changePassword': (context) => PasswordChange(),
        '/mainscreen': (context) => MainScreen(),
        '/newsfeed': (context) => NewsPage(),
      },
      home: const MainScreen(),
    );
  }
}
