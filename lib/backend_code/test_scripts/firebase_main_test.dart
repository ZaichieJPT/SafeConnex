import 'package:flutter/cupertino.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_circle_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_news_database.dart';
import '../firebase_scripts/firebase_init.dart';
import '../firebase_scripts/firebase_auth.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {

  //FirebaseInit.rootFirebase;
  CircleDatabaseHandler circleDatabaseHandler = CircleDatabaseHandler();
  print(circleDatabaseHandler.codeGenerator(6));
  //FirebaseAuthHandler authentication = FirebaseAuthHandler();
  //NewsDatabaseHandler databaseHandler = NewsDatabaseHandler();
  //databaseHandler.listenOnTheNews();
  //authentication.registerEmailAccount("charleszolina19@gmail.com", "charleszolina1000", "Charles", "Zolina", 9512807552, "2000/12/24", "link");
  //authentication.loginEmailAccount("charleszolina19@gmail.com", "charleszolina1000");
  //authentication.phoneVerificationAndroid('+447444555666');
  //authentication.phoneVerificationAndroid("+639608975193");
  //databaseHandler.createNews("PNP", "Another", "Stay Away");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Safe Connex',
        home: Placeholder()
    );
  }
}