// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safeconnex/front_end_code/components/agency_components/notiftype_contactrequest_template.dart';
import 'package:safeconnex/front_end_code/components/agency_components/notiftype_soscancel_template.dart';
import 'package:safeconnex/front_end_code/components/agency_components/notiftype_sossent_template.dart';
import 'package:safeconnex/front_end_code/components/agency_components/notiftype_welcome_template.dart';
import 'package:safeconnex/front_end_code/pages/agency_pages/agency_summary_page.dart';

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
      'date': '06/15/2024'
    },
    {
      'type': 3,
      'fullname': 'Alliah Ferrer',
      'name': 'Alliah',
      'age': '',
      'date': '06/15/2024'
    },
    {
      'type': 2,
      'fullname': 'Alliah Ferrer',
      'name': 'Alliah',
      'age': '21',
      'date': '06/15/2024'
    },
    {
      'type': 1,
      'fullname': 'Charles Zolina',
      'name': 'Charles',
      'age': '22',
      'date': '06/15/2024'
    },
    {'type': 4, 'fullname': '', 'name': '', 'age': '', 'date': '06/15/2024'},
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
          padding: EdgeInsets.only(left: width * 0.035),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: Text(
              String.fromCharCode(Icons.chevron_left.codePoint),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: Icons.chevron_left.fontFamily,
                fontSize: height * 0.055,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                package: Icons.chevron_left.fontPackage,
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
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AgencySummaryPage(),
                    ),
                  );
                },
                //REPORTS BUTTON
                child: Container(
                  height: width * 0.1,
                  width: width * 0.11,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.015),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(width * 0.02),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(-3, 3),
                        color: Colors.grey.shade600,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/images/agency_app/agency_reports_icon.png',
                  ),
                ),
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
                notifications[index]['date'],
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

  Widget buildNotificationItem(int notifType, String fullName, String firstName,
      String age, String date) {
    switch (notifType) {
      case 1:
        return SOSNotifTemplate(
          fullName: fullName,
          firstName: firstName,
          age: age,
          date: date,
        );
      case 2:
        return SOSCancelNotifTemplate(
          fullName: fullName,
          firstName: firstName,
          age: age,
          date: date,
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