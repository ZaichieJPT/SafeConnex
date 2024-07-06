// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_agency_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_circle_database.dart';

class AgencyStep5 extends StatefulWidget {
  final Function() toNextStep;
  const AgencyStep5({
    super.key,
    required this.toNextStep,
  });

  @override
  State<AgencyStep5> createState() => _AgencyStep3State();
}

class _AgencyStep3State extends State<AgencyStep5> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    //SafeConnexAgencyDatabase agencyDatabase = SafeConnexAgencyDatabase();
    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.03),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //STEP SUB HEADING
          Flexible(
            child: FittedBox(
              child: Text(
                'Pending Approval...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'OpunMai',
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          //STEP 5 ICON
          Flexible(
            flex: 3,
            child: Image.asset(
              'assets/images/change_to_agency/agency_step5_icon.png',
            ),
          ),

          //EVALUATING PROFILE TEXT
          Flexible(
            child: Text(
              'We\'re evaluating your profile',
              style: TextStyle(
                fontFamily: 'OpunMai',
                fontSize: width * 0.045,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),

          //STEP 5 DESCRIPTION
          Flexible(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Text(
                'Thank you for going through the verification process to access agency-exclusive features. We’ll notify you once your account has been fully reviewed. ',
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontFamily: 'OpunMai',
                  fontSize: width * 0.03,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          //OKAY BUTTON
          Flexible(
            flex: 1,
            child: Center(
              child: Container(
                width: width * 0.6,
                //color: Colors.grey,
                child: MaterialButton(
                  onPressed: () {
                    DependencyInjector().locator<SafeConnexAgencyDatabase>().joinTheAgency();
                    setState(() {
                      Navigator.of(context).popAndPushNamed("/agencyPage");
                    });
                  },
                  elevation: 2,
                  height: height * 0.05,
                  color: const Color.fromARGB(255, 121, 192, 148),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(width * 0.2),
                  ),
                  child: Text(
                    'Okay',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'OpunMai',
                      fontSize: height * 0.023,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
