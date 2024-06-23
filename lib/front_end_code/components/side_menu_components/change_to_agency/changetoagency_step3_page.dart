// ignore_for_file: prefer_const_constructors

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_authentication.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_storage.dart';

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
  SafeConnexIDDatabase idStorage = SafeConnexIDDatabase();


  Future<void> _onFrontIDTapped() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    SafeConnexAgencyDatabase.frontIdLink = image!.path;
    if (image == null) return;
  }

  Future<void> _onBackTapped() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    SafeConnexAgencyDatabase.backIdLink = image!.path;
    if (image == null) return;
  }

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
                  child: InkWell(
                    onTap: (){
                      _onFrontIDTapped();
                    },
                    child: Image.asset(
                      'assets/images/change_to_agency/agency_step3_icon.png',
                      width: width * 0.2,
                    ),
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
                  child: InkWell(
                    onTap: (){
                      _onBackTapped();
                    },
                    child: Image.asset(
                      'assets/images/change_to_agency/agency_step3_icon.png',
                      width: width * 0.2,
                    ),
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
                      if(SafeConnexAgencyDatabase.frontIdLink == null && SafeConnexAgencyDatabase.backIdLink == null){

                      }
                      else{
                        //widget.toNextStep();
                      }

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
