// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safeconnex/front_end_code/components/agency_components/notiftype_sossent_template.dart';

class AgencySOSReports extends StatefulWidget {
  const AgencySOSReports({super.key});

  @override
  State<AgencySOSReports> createState() => _AgencySOSReportsState();
}

class _AgencySOSReportsState extends State<AgencySOSReports> {
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
        leadingWidth: width * 0.1,
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
        title: Container(
          height: height * 0.05,
          width: width,
          child: Row(
            children: [
              //LOGO
              Padding(
                padding: EdgeInsets.only(
                  left: width * 0.05,
                  right: width * 0.02,
                ),
                child: Container(
                  width: width * 0.13,
                  height: width * 0.13,
                  padding: EdgeInsets.only(
                    left: width * 0.03,
                    right: width * 0.03,
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
              //TEXT
              Expanded(
                child: Text(
                  'SOS REPORTS',
                  style: TextStyle(
                    fontFamily: 'OpunMai',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 4,
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
              child: SOSNotifTemplate(
                fullName: notifications[index]['fullname'],
                firstName: notifications[index]['name'],
                age: notifications[index]['age'],
                date: notifications[index]['date'],
              ),
            ),
          );
        },
      ),
    );
  }
}
