// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safeconnex/front_end_code/components/agency_components/notiftype_contactrequest_template.dart';

class AgencyContactRequestPage extends StatefulWidget {
  const AgencyContactRequestPage({super.key});

  @override
  State<AgencyContactRequestPage> createState() =>
      _AgencyContactRequestPageState();
}

class _AgencyContactRequestPageState extends State<AgencyContactRequestPage> {
  int _currentNotifIndex = -1;
  final List<Map<String, dynamic>> notifications = [
    {
      'name': 'Garry',
    },
    {
      'name': 'Alliah',
    },
    {
      'name': 'Alliah',
    },
    {
      'name': 'Charles',
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
                  child: Image.asset(
                    'assets/images/agency_app/notif_contactrequest_icon.png',
                    width: width * 0.11,
                  ),
                ),
              ),
              //TEXT
              Expanded(
                child: Text(
                  'CONTACT INFORMATION\nREQUEST',
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontFamily: 'OpunMai',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
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
              child: ContactInfoRequestTemplate(
                firstName: notifications[index]['name'],
              ),
            ),
          );
        },
      ),
    );
  }
}
