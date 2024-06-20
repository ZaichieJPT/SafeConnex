// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class WelcomeTemplate extends StatelessWidget {
  const WelcomeTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Container(
      width: width,
      //color: Colors.grey,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: height * 0.02),
        child: Row(
          children: [
            //NOTIFICATION IMAGE
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Container(
                width: width * 0.13,
                height: width * 0.13,
                child: Image.asset(
                  'assets/images/agency_app/notif_welcome_icon.png',
                  width: width * 0.11,
                ),
              ),
            ),
            //NOTIFICATION TEXT
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: width,
                    child: Text(
                      'WELCOME TO AGENCY ACCESS',
                      style: TextStyle(
                        fontFamily: 'OpunMai',
                        fontWeight: FontWeight.w700,
                        fontSize: 12.5,
                        color: Color.fromARGB(255, 66, 79, 88),
                      ),
                    ),
                  ),
                  Container(
                    width: width,
                    padding: EdgeInsets.only(right: width * 0.08),
                    child: Text(
                      'You now have access to exclusive agency features!',
                      style: TextStyle(
                        fontFamily: 'OpunMai',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color.fromARGB(255, 66, 79, 88),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
