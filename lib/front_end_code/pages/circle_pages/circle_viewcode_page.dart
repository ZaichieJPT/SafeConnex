// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_circle_database.dart';

class ViewCircleCode extends StatefulWidget {
  const ViewCircleCode({super.key});

  @override
  State<ViewCircleCode> createState() => _ViewCircleCodeState();
}

class _ViewCircleCodeState extends State<ViewCircleCode> {
  @override
  Widget build(BuildContext context) {
    //SafeConnexCircleDatabase circleDatabase = SafeConnexCircleDatabase();
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image:
                  AssetImage("assets/images/circle_results_background.png"))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/create_circle_background.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Stack(
                    children: [
                      Container(
                        //height: height * 0.4,
                        width: width,
                        child: Image.asset(
                          'assets/images/circle-viewcode-bg.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          height: height * 0.3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              //HERE WE GO
                              Text(
                                'Here we go.\nYour Circle code is displayed\nbelow',
                                style: TextStyle(
                                  fontSize: height * 0.02,
                                  fontFamily: "OpunMai",
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                  color: Color.fromARGB(255, 62, 73, 101),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              //CIRCLE CODE
                              SelectableText(
                                '${DependencyInjector().locator<SafeConnexCircleDatabase>().currentCircleCode}',
                                style: TextStyle(
                                  fontSize: height * 0.05,
                                  fontFamily: "OpunMai",
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromARGB(255, 62, 73, 101),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              //CONTINUE BUTTON
                              Container(
                                height: height * 0.055,
                                width: width * 0.7,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                        style: BorderStyle.solid, width: 1.5)),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    surfaceTintColor: Colors.lightGreen[100],
                                    backgroundColor: Colors.lightGreen[100],
                                  ),
                                  child: Text(
                                    "CONTINUE",
                                    style: TextStyle(
                                      fontSize: height * 0.02,
                                      fontFamily: "OpunMai",
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromARGB(255, 62, 73, 101),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //CREATE CIRCLE BANNER
                if (MediaQuery.of(context).viewInsets.bottom == 0) ...[
                  Expanded(
                    flex: 2,
                    child: Stack(
                      children: [
                        Image.asset(
                          "assets/images/circle-viewcode-button.png",
                        ),
                      ],
                    ),
                  ),
                  Flexible(child: SizedBox()),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
