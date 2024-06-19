// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AgencyStep3 extends StatefulWidget {
  final Function() toNextStep;
  const AgencyStep3({
    super.key,
    required this.toNextStep,
  });

  @override
  State<AgencyStep3> createState() => _AgencyStep3State();
}

class _AgencyStep3State extends State<AgencyStep3> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //STEP SUB HEADING
          Flexible(
            child: FittedBox(
              child: Text(
                'Upload your Agency ID',
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
          //UPLOAD IMAGES
          Flexible(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //FRONT PART TEXT
                Padding(
                  padding: EdgeInsets.only(left: width * 0.075),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Front Part:',
                      style: TextStyle(
                        fontFamily: 'OpunMai',
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                //FRONT PART UPLOAD BUTTON
                Flexible(
                  child: Image.asset(
                    'assets/images/change_to_agency/agency_step3_icon.png',
                    width: width * 0.2,
                  ),
                ),
                //BACK PART TEXT
                Padding(
                  padding: EdgeInsets.only(left: width * 0.075),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Back Part:',
                      style: TextStyle(
                        fontFamily: 'OpunMai',
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                //BACK PART UPLOAD BUTTON
                Flexible(
                  child: Image.asset(
                    'assets/images/change_to_agency/agency_step3_icon.png',
                    width: width * 0.2,
                  ),
                ),
              ],
            ),
          ),

          //CONFIRM BUTTON
          Flexible(
            flex: 1,
            child: Center(
              child: Container(
                width: width * 0.6,
                //color: Colors.grey,
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      widget.toNextStep();
                    });
                  },
                  elevation: 2,
                  height: height * 0.05,
                  color: const Color.fromARGB(255, 121, 192, 148),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(width * 0.2),
                  ),
                  child: Text(
                    'Confirm',
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
