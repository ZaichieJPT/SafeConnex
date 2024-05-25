import 'package:flutter/material.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_auth.dart';
import 'package:safeconnex/front_end_code/components/nav_button_component.dart';
import 'package:safeconnex/front_end_code/pages/circle_page.dart';
import 'package:safeconnex/front_end_code/pages/geofencing_page.dart';
import 'package:safeconnex/front_end_code/pages/signup_page.dart';
import 'package:safeconnex/front_end_code/provider/map_provider.dart';
import 'package:safeconnex/front_end_code/provider/new_map_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void showCircleCards(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return Stack(
          children: [
            Positioned(
                height: 380,
                width: 270,
                left: 73,
                top: 230,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.lightGreenAccent.shade700,
                    borderRadius: BorderRadius.circular(30),
                  ),
                )
            ),
            Positioned(
              height: 363,
              width: 250,
              top: 238,
              left: 83,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Positioned(
              top: 140,
              left: 118,
              width: 180,
              height: 180,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 60,
                      offset: Offset(0, 9)
                    )
                  ]
                ),
              ),
            ),
            Positioned(
              top:340,
              left: 90,
              width: 230,
              child: Column(
                children: [
                  Material(
                    type: MaterialType.transparency,
                    child: Text(
                      "Charles",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blueGrey.shade800,
                        fontSize: 25,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  Material(
                    type: MaterialType.transparency,
                    child: Text(
                      "Circle Creator",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.blueGrey.shade800,
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top:410,
              left: 87,
              width: 230,
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  "Safety Status:",
                  style: TextStyle(
                    color: Colors.blueGrey.shade800,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            Positioned(
              top:430,
              left: 87,
              width: 230,
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  "Current Location:",
                  style: TextStyle(
                    color: Colors.blueGrey.shade800,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 450,
              left: 90,
              child: Container(
                height: 22,
                width: 232,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueGrey.shade800,
                    width: 2
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Material(
                  child: Text(
                    "Hello Worlds",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blueGrey.shade800,
                      fontSize: 12,
                      fontWeight: FontWeight.w600
                    ),
                  )),
              ),
            ),
            Positioned(
              top:475,
              left: 87,
              width: 230,
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  "Email Account:",
                  style: TextStyle(
                    color: Colors.blueGrey.shade800,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 495,
              left: 90,
              child: Container(
                height: 22,
                width: 232,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.blueGrey.shade800,
                      width: 2
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Material(
                    child: Text(
                      "Hello Worlds",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.blueGrey.shade800,
                          fontSize: 12,
                          fontWeight: FontWeight.w600
                      ),
                    )),
              ),
            ),
            Positioned(
              top:520,
              left: 87,
              width: 230,
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  "Phone Number:",
                  style: TextStyle(
                    color: Colors.blueGrey.shade800,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 540,
              left: 90,
              child: Container(
                height: 22,
                width: 232,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.blueGrey.shade800,
                      width: 2
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Material(
                    child: Text(
                      "Hello Worlds",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.blueGrey.shade800,
                          fontSize: 12,
                          fontWeight: FontWeight.w600
                      ),
                    )
                ),
              ),
            ),
            Positioned(
              top: 560,
              left: 90,
              width: 230,
              child: TextButton(
                onPressed: (){},
                child: Text(
                  "View Location History",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blueGrey.shade800
                  ),
                ),
              ),
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 150,
        actions: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.grey,
                          width: 0.1
                      ),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade600,
                          spreadRadius: 2,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                    child: IconButton(
                      style: IconButton.styleFrom(
                        shape: CircleBorder(),
                        backgroundColor: Colors.yellow.shade400,
                      ),
                      icon: Image.asset("assets/images/add_circle.png", scale: 8,),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CirclePage()));
                      },
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    alignment: Alignment.centerLeft,
                    clipBehavior: Clip.antiAlias,
                    height: 60,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.5
                        ),
                        borderRadius: BorderRadius.circular(9),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 5,
                              offset: Offset(5, 6)
                          )
                        ]
                    ),
                    child: IconButton(
                      style: IconButton.styleFrom(
                        shape: RoundedRectangleBorder(),
                        fixedSize: Size(250, 60)
                      ),
                      onPressed: (){},
                      icon: Row(
                        children: [
                          Icon(
                            Icons.keyboard_arrow_down_outlined,
                            size: 40,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "No Circle",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "OpunMai",
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                              color: Color.fromARGB(255, 62, 73, 101),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    ),
                  ),
                ]
              ),
              SizedBox(height: 65,)
            ],
          ),
        ],
        leadingWidth: 120,
        leading: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(width: 15),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.grey,
                        width: 0.1
                    ),
                    borderRadius: BorderRadius.circular(9),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade600,
                        spreadRadius: 2,
                        offset: Offset(-2, 3),
                      )
                    ],
                  ),
                  child: IconButton(
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(),
                    ),
                    icon: Image.asset("assets/images/settings_icon.png"),
                    onPressed: (){
                      FirebaseAuthHandler authHandler = FirebaseAuthHandler();
                      authHandler.signOutAccount();
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.grey,
                        width: 0.1
                    ),
                    borderRadius: BorderRadius.circular(9),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade600,
                        spreadRadius: 2,
                        offset: Offset(-2, 3),
                      )
                    ],
                  ),
                  child: IconButton(
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(),
                    ),
                    icon: Image.asset("assets/images/geofencing_icon.png"),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GeofencingPage()));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Stack(
        alignment: Alignment(0, 0.86),
          children: [
            //NewMapProvider(),
            NavButtonComponent(imageLocation: 'assets/images/emergency_button.png', scale: 8, route: HomePage(),),
          ],
        ),
      extendBodyBehindAppBar: true,
      bottomSheet: BottomAppBar(
        height: 110,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(),
              ),
              onPressed: (){
                showCircleCards(context);
              },
              icon: Container(
                height: 65,
                width: 85,
                decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.shade300,
                      spreadRadius: 0.1,
                      offset: Offset(0, 3)
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "CIRCLE",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "OpunMai",
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(9),
                              bottomRight: Radius.circular(9)
                          )
                      ),
                      child: Image.asset("assets/images/circle_icon.png", scale: 9)
                      ),
                  ],
                ),
              ),
            ),
            IconButton(
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(),
              ),
              onPressed: (){},
              icon: Container(
                height: 65,
                width: 85,
                decoration: BoxDecoration(
                  color: Colors.amber.shade400,
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.amber.shade400,
                        spreadRadius: 0.1,
                        offset: Offset(0, 3)
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "LOCATION",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "OpunMai",
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.amber.shade100,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(9),
                                bottomRight: Radius.circular(9)
                            )
                        ),
                        child: Image.asset("assets/images/home_icon.png", scale: 9)
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(),
              ),
              onPressed: (){},
              icon: Container(
                height: 65,
                width: 85,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 0.1,
                        offset: Offset(0, 3)
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "FEED",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "OpunMai",
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey.shade100,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(9),
                                bottomRight: Radius.circular(9)
                            )
                        ),
                        child: Image.asset("assets/images/feed_icon.png", scale: 9)
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        color: Colors.white,
      ),
    );
  }
}


