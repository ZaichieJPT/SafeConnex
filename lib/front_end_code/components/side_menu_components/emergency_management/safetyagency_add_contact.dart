// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safeconnex/front_end_code/components/home_components/error_snackbar.dart';
import 'package:safeconnex/front_end_code/provider/setting_provider.dart';

class AddContact extends StatefulWidget {
  final TextEditingController agencyNameController;
  final TextEditingController agencyLocationController;
  final TextEditingController agencyMobileController;
  final TextEditingController agencyTelephoneController;
  final TextEditingController agencyEmailController;
  final TextEditingController agencyFBController;
  final TextEditingController agencyWebController;

  final agencyContactFormKey;

  const AddContact({
    super.key,
    required this.agencyContactFormKey,
    required this.agencyNameController,
    required this.agencyLocationController,
    required this.agencyMobileController,
    required this.agencyTelephoneController,
    required this.agencyEmailController,
    required this.agencyFBController,
    required this.agencyWebController,
  });

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  SettingsProvider provider = SettingsProvider();
  @override
  void dispose() {
    // widget.agencyNameController.dispose();
    // widget.agencyLocationController.dispose();
    // widget.agencyMobileController.dispose();
    // widget.agencyTelephoneController.dispose();
    // widget.agencyEmailController.dispose();
    // widget.agencyFBController.dispose();
    // widget.agencyWebController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: width * 0.08,
            right: width * 0.08,
          ),
          child: Container(
            height: height,
            //color: Colors.deepPurple[200],
          ),
        ),
        //MAIN AGENCY CONTACT CONTAINER
        GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              // dragGesturePosition = details.localPosition;
              // _showMagnifier = true;
            });
          },
          onPanEnd: (details) {
            setState(() {
              // _showMagnifier = false;
            });
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: width * 0.08,
              right: width * 0.08,
              top: height * 0.007,
              bottom: height * 0.0075,
            ),
            child: Container(
              height: height,
              width: width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 244, 244, 244),
                borderRadius: BorderRadius.circular(width * 0.03),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 205, 206, 204),
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: height * 0.01,
                  bottom: height * 0.0015,
                ),
                child: Form(
                  key: widget.agencyContactFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //CONTACT TITLE
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                          left: width * 0.04,
                          right: width * 0.04,
                        ),
                        //CONTACT TEXT FIELD
                        child: TextFormField(
                          controller: widget.agencyNameController,
                          cursorColor: Colors.grey,
                          textAlign: TextAlign.left,
                          validator: (agencyName) {
                            if (agencyName!.isEmpty) {
                              showErrorMessage(
                                  context,
                                  'Please enter the name of the agency.',
                                  height,
                                  width);
                              return '';
                            }
                            return null;
                          },
                          style: TextStyle(
                            fontFamily: 'OpunMai',
                            fontWeight: FontWeight.w700,
                            fontSize: height * 0.013,
                            color: Colors.grey,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            hintText: 'Name of Agency',
                            hintStyle: TextStyle(
                              fontFamily: 'OpunMai',
                              fontWeight: FontWeight.w700,
                              fontSize: height * 0.013,
                              color: Colors.grey,
                            ),
                            errorStyle: TextStyle(
                              fontSize: 0,
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ),

                      //AGENCY LOCATION
                      Row(
                        children: [
                          //LOCATION IMAGE
                          Container(
                            //color: Colors.grey,
                            padding: EdgeInsets.only(
                              left: width * 0.025,
                              right: width * 0.015,
                            ),

                            child: Image.asset(
                              'assets/images/side_menu/emergency_mgmt/safetyagency_location_icon.png',
                              width: width * 0.035,
                            ),
                          ),
                          //LOCATION TEXT FIELD
                          Expanded(
                            child: Container(
                              // color:
                              //     Colors.brown,
                              padding: EdgeInsets.only(right: width * 0.03),
                              child: TextFormField(
                                controller: widget.agencyLocationController,
                                cursorColor: Colors.grey,
                                textAlign: TextAlign.left,
                                validator: (location) {
                                  if (location!.isEmpty) {
                                    showErrorMessage(
                                        context,
                                        'Agency\'s location is required',
                                        height,
                                        width);
                                    return '';
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                  fontFamily: 'OpunMai',
                                  fontWeight: FontWeight.w600,
                                  fontSize: height * 0.011,
                                  color: Colors.grey,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  hintText: 'Location of Agency',
                                  hintStyle: TextStyle(
                                    fontFamily: 'OpunMai',
                                    fontWeight: FontWeight.w500,
                                    fontSize: height * 0.011,
                                    color: Colors.grey,
                                  ),
                                  errorStyle: TextStyle(
                                    fontSize: 0,
                                  ),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //AGENCY MOBILE
                      Row(
                        children: [
                          //MOBILE IMAGE
                          Container(
                            //color: Colors.grey,
                            padding: EdgeInsets.only(
                              left: width * 0.025,
                              right: width * 0.015,
                            ),

                            child: Image.asset(
                              'assets/images/side_menu/emergency_mgmt/safetyagency_mobile_icon.png',
                              width: width * 0.035,
                            ),
                          ),
                          //MOBILE TEXTFIELD
                          Expanded(
                            child: Container(
                              // color:
                              //     Colors.brown,
                              padding: EdgeInsets.only(right: width * 0.03),
                              child: TextFormField(
                                controller: widget.agencyMobileController,
                                cursorColor: Colors.grey,
                                textAlign: TextAlign.left,
                                validator: (mobile) {
                                  return provider.agencyPhoneNumberValidator(
                                    context,
                                    height,
                                    width,
                                    mobile!,
                                  );
                                },
                                style: TextStyle(
                                  fontFamily: 'OpunMai',
                                  fontWeight: FontWeight.w600,
                                  fontSize: height * 0.011,
                                  color: Colors.grey,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  hintText: 'Mobile Number',
                                  hintStyle: TextStyle(
                                    fontFamily: 'OpunMai',
                                    fontWeight: FontWeight.w600,
                                    fontSize: height * 0.011,
                                    color: Colors.grey,
                                  ),
                                  errorStyle: TextStyle(
                                    fontSize: 0,
                                  ),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //AGENCY TELEPHONE
                      Row(
                        children: [
                          //TELEPHONE ICON
                          Container(
                            //color: Colors.grey,
                            padding: EdgeInsets.only(
                              left: width * 0.025,
                              right: width * 0.015,
                            ),

                            child: Image.asset(
                              'assets/images/side_menu/emergency_mgmt/safetyagency_telephone_icon.png',
                              width: width * 0.035,
                            ),
                          ),
                          //TELEPHONE TEXTFIELD
                          Expanded(
                            child: Container(
                              // color:
                              //     Colors.brown,
                              padding: EdgeInsets.only(right: width * 0.03),
                              child: TextFormField(
                                controller: widget.agencyTelephoneController,
                                cursorColor: Colors.grey,
                                textAlign: TextAlign.left,
                                validator: (telephone) {
                                  return provider.agencyTelephoneValidator(
                                    context,
                                    height,
                                    width,
                                    telephone!,
                                  );
                                },
                                style: TextStyle(
                                  fontFamily: 'OpunMai',
                                  fontWeight: FontWeight.w600,
                                  fontSize: height * 0.011,
                                  color: Colors.grey,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  hintText: 'Telephone number',
                                  hintStyle: TextStyle(
                                    fontFamily: 'OpunMai',
                                    fontWeight: FontWeight.w600,
                                    fontSize: height * 0.011,
                                    color: Colors.grey,
                                  ),
                                  errorStyle: TextStyle(
                                    fontSize: 0,
                                  ),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //AGENCY EMAIL
                      Row(
                        children: [
                          //EMAIL IMAGE
                          Container(
                            //color: Colors.grey,
                            padding: EdgeInsets.only(
                              left: width * 0.025,
                              right: width * 0.015,
                            ),

                            child: Image.asset(
                              'assets/images/side_menu/emergency_mgmt/safetyagency_email_icon.png',
                              width: width * 0.035,
                            ),
                          ),
                          //EMAIL TEXT FIELD
                          Expanded(
                            child: Container(
                              // color:
                              //     Colors.brown,
                              padding: EdgeInsets.only(right: width * 0.03),
                              child: TextFormField(
                                controller: widget.agencyEmailController,
                                cursorColor: Colors.grey,
                                textAlign: TextAlign.left,
                                validator: (email) {
                                  return provider.agencyEmailValidator(
                                    context,
                                    height,
                                    width,
                                    email!,
                                  );
                                },
                                style: TextStyle(
                                  fontFamily: 'OpunMai',
                                  fontWeight: FontWeight.w600,
                                  fontSize: height * 0.011,
                                  color: Colors.grey,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  hintText: 'Email address',
                                  hintStyle: TextStyle(
                                    fontFamily: 'OpunMai',
                                    fontWeight: FontWeight.w600,
                                    fontSize: height * 0.011,
                                    color: Colors.grey,
                                  ),
                                  errorStyle: TextStyle(
                                    fontSize: 0,
                                  ),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //AGENCY FACEBOOK
                      Row(
                        children: [
                          //FB IMAGE
                          Container(
                            //color: Colors.grey,
                            padding: EdgeInsets.only(
                              left: width * 0.025,
                              right: width * 0.015,
                            ),

                            child: Image.asset(
                              'assets/images/side_menu/emergency_mgmt/safetyagency_fb_icon.png',
                              width: width * 0.035,
                            ),
                          ),
                          //FB TEXTFIELD
                          Expanded(
                            child: Container(
                              // color:
                              //     Colors.brown,
                              padding: EdgeInsets.only(right: width * 0.03),
                              child: TextFormField(
                                controller: widget.agencyFBController,
                                cursorColor: Colors.grey,
                                textAlign: TextAlign.left,
                                validator: (fb) {
                                  return provider.agencyFBValidator(
                                    context,
                                    height,
                                    width,
                                    fb!,
                                  );
                                },
                                style: TextStyle(
                                  fontFamily: 'OpunMai',
                                  fontWeight: FontWeight.w600,
                                  fontSize: height * 0.011,
                                  color: Colors.grey,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  hintText: 'Facebook link',
                                  hintStyle: TextStyle(
                                    fontFamily: 'OpunMai',
                                    fontWeight: FontWeight.w600,
                                    fontSize: height * 0.011,
                                    color: Colors.grey,
                                  ),
                                  errorStyle: TextStyle(
                                    fontSize: 0,
                                  ),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //AGENCY WEBSITE
                      Row(
                        children: [
                          //WEBSITE IMAGE
                          Container(
                            //color: Colors.grey,
                            padding: EdgeInsets.only(
                              left: width * 0.025,
                              right: width * 0.015,
                            ),

                            child: Image.asset(
                              'assets/images/side_menu/emergency_mgmt/safetyagency_web_icon.png',
                              width: width * 0.035,
                            ),
                          ),
                          //WEBSITE TEXTFIELD
                          Expanded(
                            child: Container(
                              // color:
                              //     Colors.brown,
                              padding: EdgeInsets.only(right: width * 0.03),
                              child: TextFormField(
                                controller: widget.agencyWebController,
                                cursorColor: Colors.grey,
                                textAlign: TextAlign.left,
                                validator: (web) {
                                  return provider.agencyWebsiteValidator(
                                    context,
                                    height,
                                    width,
                                    web!,
                                  );
                                },
                                style: TextStyle(
                                  fontFamily: 'OpunMai',
                                  fontWeight: FontWeight.w600,
                                  fontSize: height * 0.011,
                                  color: Colors.grey,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  hintText: 'Website link',
                                  hintStyle: TextStyle(
                                    fontFamily: 'OpunMai',
                                    fontWeight: FontWeight.w600,
                                    fontSize: height * 0.011,
                                    color: Colors.grey,
                                  ),
                                  errorStyle: TextStyle(
                                    fontSize: 0,
                                  ),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        //SELECTED TOP CONTAINER
        Positioned(
          top: 0,
          right: width * 0.12,
          child: Container(
            height: height * 0.02,
            width: width * 0.2,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(width * 0.01),
              border: Border.all(
                color: Color.fromARGB(255, 217, 217, 217),
                width: 1.5,
              ),
            ),
            child: Text(
              'unselected',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'OpunMai',
                fontSize: height * 0.0135,
                fontWeight: FontWeight.w700,
                color: Colors.red,
              ),
            ),
          ),
        ),
        // if (_showMagnifier) ...[
        //   Positioned(
        //     left: dragGesturePosition.dx - (width * 0.3) / 2,
        //     top: dragGesturePosition.dy - (width * 0.3),
        //     child: RawMagnifier(
        //       focalPointOffset: Offset.zero,
        //       magnificationScale: 2,
        //       size: Size(width * 0.3, height * 0.3),
        //       decoration: MagnifierDecoration(
        //         shape: CircleBorder(
        //           side: BorderSide(
        //             color: Color.fromARGB(255, 14, 46, 67),
        //             width: 1.5,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ],
      ],
    );
  }
}
