// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_database.dart';
import 'package:safeconnex/front_end_code/pages/home_mainscreen.dart';

class CircleResultsPage extends StatefulWidget {
  const CircleResultsPage({super.key});

  @override
  State<CircleResultsPage> createState() => _CircleResultsPageState();
}

class _CircleResultsPageState extends State<CircleResultsPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;;

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
                                '${SafeConnexCircleDatabase.generatedCode}',
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
                                    //PageNavigator(context, MainScreen());
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
                //CREATE CIRCL BANNER
                if (MediaQuery.of(context).viewInsets.bottom == 0) ...[
                  Expanded(
                    flex: 2,
                    child: Stack(
                      children: [
                        Image.asset(
                          "assets/images/create_button.png",
                        ),
                      ],
                    ),
                  ),
                  Flexible(child: SizedBox()),
                ],
              ],
            ),

            /*Stack(
          children: [
            Positioned(
              top: 95,
              left: 80,
              child: Text(
                'Here we go.\nYour Circle code is displayed\nbelow',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: "OpunMai",
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 62, 73, 101),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              top: 200,
              left: 140,
              child: SelectableText(
                '${CircleDatabaseHandler.generatedCode}',
                style: TextStyle(
                  fontSize: 35,
                  fontFamily: "OpunMai",
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 62, 73, 101),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              top: 290,
              left: 75,
              child: Container(
                height: 50,
                width: 270,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(style: BorderStyle.solid, width: 1.5)
                ),
                child: ElevatedButton(
                  child: Text(
                    "CONTINUE",
                    style: TextStyle(
                      fontSize: 21,
                      fontFamily: "OpunMai",
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 62, 73, 101),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: (){
                    Navigator.of(context).popUntil((route) => route.settings.name == "/home");
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 65,
              left: 72,
              child: Image.asset("assets/images/create_button.png", scale: 9.5,)
            )
          ],
        ),*/
          ),
        ),
      ),
    );
  }
}