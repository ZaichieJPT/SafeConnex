// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safeconnex/front_end_code/components/nav_button_component.dart';
import 'package:safeconnex/front_end_code/pages/circle_pages/create_circle_page.dart';
import 'package:safeconnex/front_end_code/pages/join_circle.dart';
import 'package:safeconnex/front_end_code/pages/signup_page.dart';

class CirclePage extends StatefulWidget {
  const CirclePage({super.key});

  @override
  State<CirclePage> createState() => _CirclePageState();
}

class _CirclePageState extends State<CirclePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/circle_background.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: width,
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.065,
                  vertical: height * 0.05,
                ),
                child: NavButtonComponent(
                  imageLocation: "assets/images/join_button.png",
                  route: JoinCirclePage(),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: width,
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.065,
                  vertical: height * 0.05,
                ),
                child: NavButtonComponent(
                  imageLocation: "assets/images/create_button.png",
                  route: CreateCirclePage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
