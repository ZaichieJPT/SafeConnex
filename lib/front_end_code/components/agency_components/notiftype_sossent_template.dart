// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SOSNotifTemplate extends StatelessWidget {
  final String firstName;
  final String fullName;
  final String age;
  const SOSNotifTemplate({
    super.key,
    required this.age,
    required this.firstName,
    required this.fullName,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Container(
      width: width,
      //color: Colors.grey,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: height * 0.01),
        child: Row(
          children: [
            //NOTIFICATION IMAGE
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Container(
                width: width * 0.13,
                height: width * 0.13,
                padding: EdgeInsets.only(
                  left: width * 0.025,
                  right: width * 0.025,
                  bottom: 5,
                ),
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: const [
                      Color.fromARGB(255, 238, 29, 35),
                      Color.fromARGB(255, 155, 34, 34),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/side_menu/emergency_mgmt/contacts_main_icon.png',
                  fit: BoxFit.contain,
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
                      'SOS REPORT',
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
                    child: Text(
                      '$firstName needs help!\nFull name: $fullName\nAge: $age\nClick here to view the location',
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
