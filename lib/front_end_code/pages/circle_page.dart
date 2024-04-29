import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safeconnex/front_end_code/components/nav_button_component.dart';
import 'package:safeconnex/front_end_code/pages/create_circle_page.dart';
import 'package:safeconnex/front_end_code/pages/signup_page.dart';

class CirclePage extends StatefulWidget {
  const CirclePage({super.key});

  @override
  State<CirclePage> createState() => _CirclePageState();
}

class _CirclePageState extends State<CirclePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              child: Image.asset("assets/images/circle_background.png",),
              alignment: Alignment.center,
            ),
            Positioned(
              child: NavButtonComponent(
                imageLocation: "assets/images/join_button.png", scale: 9,
                route: SignupPage(),
              ),
              top: 90,
              right: 40,
            ),
            Positioned(
              child: NavButtonComponent(
                imageLocation: "assets/images/create_button.png", scale: 9,
                route: CreateCirclePage(),
              ),
              bottom: 60,
              right: 10,
            )
          ],
        ),
    );
  }
}
