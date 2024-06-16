// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/emergency_management/emergency_contacts_options.dart';

class EmergencyContacts extends StatefulWidget {
  const EmergencyContacts({super.key});

  @override
  State<EmergencyContacts> createState() => _EmergencyContactsState();
}

class _EmergencyContactsState extends State<EmergencyContacts> {
  bool _isMainCircleCheck = true;
  bool _isMainAgencyCheck = false;
  bool _isFireCircleCheck = true;
  bool _isFireAgencyCheck = false;
  bool _isCrimeCircleCheck = true;
  bool _isCrimeAgencyCheck = false;
  bool _isMedicalCircleCheck = true;
  bool _isMedicalAgencyCheck = false;
  bool _isDisasterCircleCheck = true;
  bool _isDisasterAgencyCheck = false;

  _onMainTap(bool circleCheck, bool agencyCheck) {
    setState(() {
      _isMainCircleCheck = circleCheck;
      _isMainAgencyCheck = agencyCheck;
    });
  }

  _onFireTap(bool circleCheck, bool agencyCheck) {
    setState(() {
      _isFireCircleCheck = circleCheck;
      _isFireAgencyCheck = agencyCheck;
    });
  }

  _onCrimeTap(bool circleCheck, bool agencyCheck) {
    setState(() {
      _isCrimeCircleCheck = circleCheck;
      _isCrimeAgencyCheck = agencyCheck;
    });
  }

  _onMedTap(bool circleCheck, bool agencyCheck) {
    setState(() {
      _isMedicalCircleCheck = circleCheck;
      _isMedicalAgencyCheck = agencyCheck;
    });
  }

  _onDisasterTap(bool circleCheck, bool agencyCheck) {
    setState(() {
      _isDisasterCircleCheck = circleCheck;
      _isDisasterAgencyCheck = agencyCheck;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 14, 46, 67),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              //color: Colors.yellow,
              height: height * 0.09,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //BACK BUTTON
                  Expanded(
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
                  //EMERGENCY CONTACT TITLE
                  Expanded(
                    flex: 4,
                    child: Container(
                      width: width,
                      //color: Colors.black,
                      child: FittedBox(
                        child: Text(
                          'EMERGENCY CONTACTS',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'OpunMai',
                            fontSize: height * 0.025,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: width,
                    ),
                  ),
                ],
              ),
            ),
            //DESCRIPTION
            Container(
              //color: Colors.lightGreen,
              height: height * 0.05,
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                child: Text(
                  'In case of emergency, you can decide who can receive your SOS.',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontFamily: 'OpunMai',
                    fontSize: height * 0.02,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            //EMERGENCY CONTACTS SOS SETTINGS
            Expanded(
              child: SizedBox(
                height: height * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //GENERAL EMERGENCY SOS
                    ContactOptions(
                      sOSType: 'General Emergency SOS',
                      sOSFontColor: Colors.red.shade600,
                      typeGradient: const [
                        Color.fromARGB(255, 238, 29, 35),
                        Color.fromARGB(255, 155, 34, 34),
                      ],
                      typeImage:
                          'assets/images/side_menu/emergency_mgmt/contacts_main_icon.png',
                      isCircleCheck: _isMainCircleCheck,
                      isAgencyCheck: _isMainAgencyCheck,
                      onCheck: _onMainTap,
                    ),
                    //FIRE INCIDENT SOS
                    ContactOptions(
                      sOSType: 'Fire Incident SOS',
                      sOSFontColor: Colors.amberAccent,
                      typeColor: Colors.orange.shade300,
                      typeIcon: Icons.local_fire_department_outlined,
                      isCircleCheck: _isFireCircleCheck,
                      isAgencyCheck: _isFireAgencyCheck,
                      onCheck: _onFireTap,
                    ),
                    //CRIME and INCIDENT SOS
                    ContactOptions(
                      sOSType: 'Crime and Incident SOS',
                      sOSFontColor: Colors.grey.shade100,
                      typeColor: Colors.grey.shade600,
                      typeIcon: Icons.local_police_outlined,
                      isCircleCheck: _isCrimeCircleCheck,
                      isAgencyCheck: _isCrimeAgencyCheck,
                      onCheck: _onCrimeTap,
                    ),
                    //MEDICAL EMERGENCY SOS
                    ContactOptions(
                      sOSType: 'Medical Emergency SOS',
                      sOSFontColor: Colors.cyan.shade200,
                      typeColor: Colors.cyan.shade600,
                      typeIcon: Icons.medical_services_outlined,
                      isCircleCheck: _isMedicalCircleCheck,
                      isAgencyCheck: _isMedicalAgencyCheck,
                      onCheck: _onMedTap,
                    ),
                    //NATURAL DISASTER AND ACCIDENT
                    ContactOptions(
                      sOSType: 'Natural Disaster and Accident SOS',
                      sOSFontColor: Colors.green.shade200,
                      typeColor: Colors.green.shade400,
                      typeIcon: Icons.flood_outlined,
                      isCircleCheck: _isDisasterCircleCheck,
                      isAgencyCheck: _isDisasterAgencyCheck,
                      onCheck: _onDisasterTap,
                    ),
                    SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
