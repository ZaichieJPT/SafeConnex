// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safeconnex/front_end_code/components/agency_components/notiftype_contactrequest_template.dart';
import 'package:safeconnex/front_end_code/components/agency_components/notiftype_soscancel_template.dart';
import 'package:safeconnex/front_end_code/components/agency_components/notiftype_sossent_template.dart';
import 'package:safeconnex/front_end_code/components/agency_components/notiftype_welcome_template.dart';

class AgencyNotificationPage extends StatefulWidget {
  const AgencyNotificationPage({super.key});

  @override
  State<AgencyNotificationPage> createState() => _AgencyNotificationPageState();
}

class _AgencyNotificationPageState extends State<AgencyNotificationPage> {
  int _currentNotifIndex = -1;
  final List<Map<String, dynamic>> notifications = [
    {
      'type': 1,
      'fullname': 'Garry Penoliar',
      'name': 'Garry',
      'age': '23',
    },
    {
      'type': 3,
      'fullname': 'Alliah Ferrer',
      'name': 'Alliah',
      'age': '',
    },
    {
      'type': 2,
      'fullname': 'Alliah Ferrer',
      'name': 'Alliah',
      'age': '21',
    },
    {
      'type': 1,
      'fullname': 'Charles Zolina',
      'name': 'Charles',
      'age': '22',
    },
    {
      'type': 4,
      'fullname': '',
      'name': '',
      'age': '',
    },
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 66, 79, 88),
        automaticallyImplyLeading: false,
        toolbarHeight: height * 0.08,
        leading: Padding(
          padding: EdgeInsets.only(left: height * 0.035),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            radius: 1,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color.fromARGB(255, 232, 220, 206),
                  width: 3,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 182, 176, 163),
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: FittedBox(
                child: Text(
                  String.fromCharCode(Icons.west.codePoint),
                  style: TextStyle(
                    fontFamily: Icons.west.fontFamily,
                    fontSize: width * 0.055,
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 110, 101, 94),
                    package: Icons.west.fontPackage,
                  ),
                ),
              ),
            ),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: width * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Notifications',
                style: TextStyle(
                  fontFamily: 'OpunMai',
                  fontSize: height * 0.025,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: width * 0.025,
              ),
              Image.asset(
                'assets/images/agency_app/agency_notification.png',
                width: width * 0.085,
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (contect, index) {
          return InkWell(
            onTap: () {
              setState(() {
                if (_currentNotifIndex == index) {
                  _currentNotifIndex = notifications.length + 1;
                } else {
                  _currentNotifIndex = index;
                }
              });
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Container(
              color: _currentNotifIndex == index
                  ? Colors.grey.shade300
                  : Colors.transparent,
              child: buildNotificationItem(
                notifications[index]['type'],
                notifications[index]['fullname'],
                notifications[index]['name'],
                notifications[index]['age'],
              ),
            ),
          );
        },
      ),
      floatingActionButton: InkWell(
        onTap: () {},
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Container(
          width: width * 0.15,
          height: width * 0.14,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(width * 0.035),
            border: Border.all(
              color: Color.fromARGB(255, 66, 79, 88),
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(-4, 3),
                color: Colors.grey.shade600,
              ),
            ],
          ),
          child: FittedBox(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.025),
              child: Icon(
                CupertinoIcons.delete_solid,
                size: width * 0.1,
                color: Color.fromARGB(255, 66, 79, 88),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNotificationItem(
      int notifType, String fullName, String firstName, String age) {
    switch (notifType) {
      case 1:
        return SOSNotifTemplate(
          fullName: fullName,
          firstName: firstName,
          age: age,
        );
      case 2:
        return SOSCancelNotifTemplate(
          fullName: fullName,
          firstName: firstName,
          age: age,
        );
      case 3:
        return ContactInfoRequestTemplate(
          firstName: firstName,
        );
      case 4:
        return WelcomeTemplate();
      default:
        return Text('Unknown Notification Type'); // Handle unexpected types
    }
  }
}
