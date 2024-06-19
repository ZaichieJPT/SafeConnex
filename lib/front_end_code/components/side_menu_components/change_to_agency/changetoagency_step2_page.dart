// ignore_for_file: prefer_const_constructors

import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:safeconnex/front_end_code/components/home_components/error_snackbar.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/change_to_agency/agency_step2_textfields.dart';

class AgencyStep2 extends StatefulWidget {
  final Function() toNextStep;
  const AgencyStep2({
    super.key,
    required this.toNextStep,
  });

  @override
  State<AgencyStep2> createState() => _AgencyStep2State();
}

class _AgencyStep2State extends State<AgencyStep2> {
  final TextEditingController _agencyRoleController = TextEditingController();
  final TextEditingController _agencyNameController = TextEditingController();
  final TextEditingController _agencyLocationController =
      TextEditingController();
  final TextEditingController _agencyMobileController = TextEditingController();
  final TextEditingController _agencyTelephoneController =
      TextEditingController();
  final TextEditingController _agencyEmailController = TextEditingController();
  final TextEditingController _agencyFBController = TextEditingController();
  final TextEditingController _agencyWebsiteController =
      TextEditingController();

  final _step2FormKey = GlobalKey<FormState>();
  double height = 0.0;
  double width = 0.0;

  final _toastQueue = Queue<String>();

  void displayToast(String message) {
    _toastQueue.add(message);
    print(_toastQueue.length);
  }

  void _showNextToast() async {
    if (_toastQueue.isNotEmpty) {
      setState(() {
        String message = _toastQueue.removeFirst();
        print(_toastQueue.toString());
        showToast(
          message,
          textStyle: TextStyle(
            fontFamily: 'OpunMai',
            fontWeight: FontWeight.w600,
            fontSize: height * 0.018,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
          context: context,
          backgroundColor: Colors.red[400],
          position: StyledToastPosition.center,
          borderRadius: BorderRadius.circular(10),
          duration: Duration(milliseconds: 3000),
          animation: StyledToastAnimation.fade,
          reverseAnimation: StyledToastAnimation.fade,
          fullWidth: true,
        );
      });
      await Future.delayed(const Duration(seconds: 3)); // Delay between toasts
      _showNextToast();
    }
  }

  @override
  void dispose() {
    _agencyNameController.dispose();
    _agencyLocationController.dispose();
    _agencyMobileController.dispose();
    _agencyTelephoneController.dispose();
    _agencyEmailController.dispose();
    _agencyFBController.dispose();
    _agencyWebsiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.sizeOf(context).height;
    width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.016),
      child: Container(
        //color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //STEP SUB HEADING
            Flexible(
              child: FittedBox(
                child: Text(
                  'Fill out your details',
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
            Expanded(
              flex: 9,
              child: Form(
                key: _step2FormKey,
                //TEXTFIELDS COLUMN
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //AGENCY ROLE TEXTFIELD
                    Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.07, left: width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //ROLE FIELD ICON
                          Image.asset(
                            'assets/images/change_to_agency/agency_step2_roleicon.png',
                            width: width * 0.06,
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          //ROLE TEXT FIELD
                          Expanded(
                            child: AgencyStep2TextField(
                              controller: _agencyNameController,
                              hintText: 'role or position',
                              validator: (value) {
                                if (value.toString().isEmpty) {
                                  displayToast(
                                      'Please enter your role or position');
                                  return '';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    //AGENCY NAME TEXTFIELD
                    Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.07, left: width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //NAME FIELD ICON
                          Image.asset(
                            'assets/images/change_to_agency/agency_step2_nameicon.png',
                            width: width * 0.06,
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          //NAME TEXT FIELD
                          Expanded(
                            child: AgencyStep2TextField(
                              controller: _agencyNameController,
                              hintText: 'name of the agency',
                              validator: (value) {
                                if (value.toString().isEmpty) {
                                  displayToast(
                                    'The name of your agency is required',
                                  );
                                  return '';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    //AGENCY LOCATION TEXTFIELD
                    Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.07, left: width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //LOCATION FIELD ICON
                          Image.asset(
                            'assets/images/change_to_agency/agency_step2_locationicon.png',
                            width: width * 0.06,
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          //LOCATION TEXT FIELD
                          Expanded(
                            child: AgencyStep2TextField(
                              controller: _agencyLocationController,
                              hintText: 'location of the agency',
                              validator: (value) {
                                if (value.toString().isEmpty) {
                                  displayToast(
                                    'The location of the agency is required',
                                  );
                                  return '';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    //AGENCY MOBILE TEXTFIELD
                    Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.07, left: width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //MOBILE FIELD ICON
                          Image.asset(
                            'assets/images/change_to_agency/agency_step2_mobileicon.png',
                            width: width * 0.06,
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          //MOBILE TEXT FIELD
                          Expanded(
                            child: AgencyStep2TextField(
                              controller: _agencyMobileController,
                              hintText: 'mobile number',
                              validator: (value) {
                                if (value.toString().isEmpty) {
                                  displayToast(
                                    'The mobile number of the agency is required',
                                  );
                                  return '';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.07, left: width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //MOBILE FIELD ICON
                          Image.asset(
                            'assets/images/change_to_agency/agency_step2_telephoneicon.png',
                            width: width * 0.06,
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          //MOBILE TEXT FIELD
                          Expanded(
                            child: AgencyStep2TextField(
                              controller: _agencyTelephoneController,
                              hintText: 'telephone number',
                              validator: (telephone) {
                                if (telephone.toString().isEmpty) {
                                  displayToast(
                                    'The telephone number of the agency is required',
                                  );
                                  return '';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.07, left: width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //EMAIL FIELD ICON
                          Image.asset(
                            'assets/images/change_to_agency/agency_step2_emailicon.png',
                            width: width * 0.065,
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          //EMAIL TEXT FIELD
                          Expanded(
                            child: AgencyStep2TextField(
                              controller: _agencyEmailController,
                              hintText: 'email address',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.07, left: width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //FB FIELD ICON
                          Image.asset(
                            'assets/images/change_to_agency/agency_step2_fbicon.png',
                            width: width * 0.065,
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          //FB TEXT FIELD
                          Expanded(
                            child: AgencyStep2TextField(
                              controller: _agencyFBController,
                              hintText: 'facebook link',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.07, left: width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //WEBSITE FIELD ICON
                          Image.asset(
                            'assets/images/change_to_agency/agency_step2_websiteicon.png',
                            width: width * 0.065,
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          //WEBSITE TEXT FIELD
                          Expanded(
                            child: AgencyStep2TextField(
                              controller: _agencyWebsiteController,
                              hintText: 'agency website',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                      print(_step2FormKey.currentState!);
                      if (_step2FormKey.currentState!.validate()) {
                        widget.toNextStep();
                      } else {
                        _showNextToast();
                      }
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
      ),
    );
  }
}
