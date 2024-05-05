import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_auth.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_circle_database.dart';

class ConfirmJoinCircle extends StatefulWidget {
  const ConfirmJoinCircle({super.key});

  @override
  State<ConfirmJoinCircle> createState() => _ConfirmJoinCircleState();
}

class _ConfirmJoinCircleState extends State<ConfirmJoinCircle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 17,
              color: Colors.grey.shade200,
              style: BorderStyle.solid
            ),
            bottom:BorderSide(
                width: 13,
                color: Colors.grey.shade200,
                style: BorderStyle.solid
            ),
            left: BorderSide(
                width: 17,
                color: Colors.grey.shade200,
                style: BorderStyle.solid
            ),
            right: BorderSide(
                width: 17,
                color: Colors.grey.shade200,
                style: BorderStyle.solid
            ),
          )
        ),
        child: Stack(
          children: [
            Positioned(
              right: 7,
              bottom: 610,
              child: Container(
                height: 28,
                width: 28,
                decoration: BoxDecoration(
                  color: Colors.yellow.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Positioned(
              left: 40,
              bottom: 800,
              child: Container(
                height: 38,
                width: 38,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Positioned(
              bottom: 480,
              left: 5,
              child: Image.asset("assets/images/join_button.png", scale: 8.7,),
            ),
            Positioned(
              bottom: -130,
              right: -130,
              child: Container(
                height: 600,
                width: 660,
                decoration: BoxDecoration(
                  color: Colors.amber.shade300,
                  borderRadius: BorderRadius.circular(1500)
                ),
              ),
            ),
            Positioned(
              bottom: 375,
              left: 90,
              child: Text(
                "You are about to join",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "OpunMai",
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 62, 73, 101),
                ),
              ),
            ),
            Positioned(
              bottom: 290,
              left: 60,
              child: Container(
                width: 253,
                child: Text(
                  "${CircleDatabaseHandler.circleData['circle_name'].toString()}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    fontFamily: "OpunMai",
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 62, 73, 101),
                    shadows: [
                      Shadow(
                        color: Colors.white,
                        offset: Offset(1.5, 2.5)
                      )
                    ]
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 180,
              left: 55,
              child: Container(
                height: 50,
                width: 280,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    width: 1
                  )
                ),
                child: TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text(
                    "CANCEL",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "OpunMai",
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 62, 73, 101),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              left: 55,
              child: Container(
                height: 50,
                width: 280,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                        width: 1
                    )
                ),
                child: TextButton(
                  onPressed: (){
                    CircleDatabaseHandler circleDatabase = CircleDatabaseHandler();
                    FirebaseAuthHandler authHandler = FirebaseAuthHandler();
                    circleDatabase.addCircleMember(CircleDatabaseHandler.circleData["circle_code"].toString(), authHandler.authHandler.currentUser!.uid, authHandler.authHandler.currentUser!.displayName.toString(), CircleDatabaseHandler.circleData["circle_name"].toString(), authHandler.authHandler.currentUser!.email.toString(), "1");
                    Navigator.of(context).popUntil((route) => route.settings.name == "/home");
                  },
                  child: Text(
                    "CONTINUE",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "OpunMai",
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 62, 73, 101),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
