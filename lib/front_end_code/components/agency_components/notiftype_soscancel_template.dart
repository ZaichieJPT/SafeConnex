// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SOSCancelNotifTemplate extends StatelessWidget {
  final String firstName;
  final String fullName;
  final String age;
  final String date;
  const SOSCancelNotifTemplate({
    super.key,
    required this.age,
    required this.firstName,
    required this.fullName,
    required this.date,
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
                    colors: [
                      Colors.white,
                      Colors.grey.shade500,
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
                  Row(
                    children: [
                      //TITLE
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: width,
                          child: Text(
                            'CANCELLED SOS REPORT',
                            style: TextStyle(
                              fontFamily: 'OpunMai',
                              fontWeight: FontWeight.w700,
                              fontSize: 12.5,
                              color: Color.fromARGB(255, 66, 79, 88),
                            ),
                          ),
                        ),
                      ),
                      //DATE
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: width * 0.02),
                          child: Text(
                            date,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: 'OpunMai',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color.fromARGB(255, 66, 79, 88),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: width,
                    child: Text(
                      '$firstName needs help!\nFull name: $fullName\nAge: $age',
                      style: TextStyle(
                        fontFamily: 'OpunMai',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color.fromARGB(255, 66, 79, 88),
                      ),
                    ),
                  ),
                  Container(
                    width: width,
                    child: Text(
                      'Click here to view the location',
                      style: TextStyle(
                        fontFamily: 'OpunMai',
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
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