
import 'package:flutter/material.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_authentication.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_circle_database.dart';

class CircularLoadingScreen extends StatefulWidget {
  const CircularLoadingScreen({super.key});

  @override
  State<CircularLoadingScreen> createState() => _CircularLoadingScreenState();
}

class _CircularLoadingScreenState extends State<CircularLoadingScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), (){
      DependencyInjector().locator<SafeConnexCircleDatabase>().getCircleList(DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.uid);
      Navigator.popAndPushNamed(context, "/home");
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
