// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:safeconnex/front_end_code/components/emergency_button_components/emergency_ripple_animation.dart';
import 'package:safeconnex/front_end_code/pages/emergency_button_pages/emergency_sent_page.dart';

class SOSSentTemplate extends StatefulWidget {
  final String pageTitle;
  final Color? colorBG;
  final Color buttonColor;
  final Icon pageIcon;

  const SOSSentTemplate({
    super.key,
    required this.pageTitle,
    required this.buttonColor,
    required this.pageIcon,
    this.colorBG,
  });

  @override
  State<SOSSentTemplate> createState() => _SOSSentTemplateState();
}

class _SOSSentTemplateState extends State<SOSSentTemplate> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    bool _visible = MediaQuery.of(context).viewInsets.bottom == 0;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: PopScope(
        canPop: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            width: width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  widget.colorBG!,
                  Color.fromARGB(255, 241, 241, 241),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: height * 0.01,
                ),

                //PAGE TITLE
                Flexible(
                  child: Text(
                    widget.pageTitle,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'OpunMai',
                      fontSize: height * 0.027,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 62, 73, 101),
                    ),
                  ),
                ),

                //PAGE SUBTITLE
                Flexible(
                  child: Text(
                    'Enter your PIN to cancel',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'OpunMai',
                      fontSize: height * 0.017,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 62, 73, 101),
                    ),
                  ),
                ),
                //PAGE DESCRIPTION
                Flexible(
                  child: Text(
                    'Your SOS and location has been sent to\nyour emergency contacts.',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'OpunMai',
                      fontSize: height * 0.018,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 62, 73, 101),
                    ),
                  ),
                ),

                //PAGE ICON DO NOT DELETE
                // Flexible(
                //   flex: 1,
                //   child: Stack(
                //     alignment: Alignment.center,
                //     children: [
                //       //RIPPLE
                //       SizedBox(
                //         width: width,
                //         child: EmergencyRipple(
                //           rippleRadius: 0.001,
                //           //rippleColor: Colors.orange.shade600,
                //           child: Container(),
                //         ),
                //       ),
                //       //ICON
                //       Container(
                //         //padding: EdgeInsets.all(width * 0.07),
                //         width: width * 0.25,
                //         alignment: Alignment.center,
                //         decoration: BoxDecoration(
                //           color: widget.buttonColor,
                //           shape: BoxShape.circle,
                //         ),
                //         child: FittedBox(
                //           child: widget.pageIcon,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                Flexible(
                  child: Container(
                    //padding: EdgeInsets.all(width * 0.07),
                    width: width * 0.25,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: widget.buttonColor,
                      shape: BoxShape.circle,
                    ),
                    child: FittedBox(
                      child: widget.pageIcon,
                    ),
                  ),
                ),

                //PIN TEXT FIELD
                Flexible(
                  child: Form(
                    child: Container(
                      //color: Colors.amber,
                      width: width * 0.7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //FIRST DIGIT
                          Container(
                            width: width * 0.075,
                            height: height * 0.05,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromARGB(255, 62, 73, 101),
                                  width: 5,
                                ),
                              ),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              cursorColor: Color.fromARGB(255, 62, 73, 101),
                              style: TextStyle(
                                fontFamily: 'OpunMai',
                                fontSize: height * 0.035,
                                fontWeight: FontWeight.w800,
                                color: Color.fromARGB(255, 62, 73, 101),
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(),
                              ),
                              onChanged: (pin) {
                                if (pin.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                            ),
                          ),
                          //SECOND DIGIT
                          Container(
                            width: width * 0.075,
                            height: height * 0.05,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromARGB(255, 62, 73, 101),
                                  width: 5,
                                ),
                              ),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              cursorColor: Color.fromARGB(255, 62, 73, 101),
                              style: TextStyle(
                                fontFamily: 'OpunMai',
                                fontSize: height * 0.035,
                                fontWeight: FontWeight.w800,
                                color: Color.fromARGB(255, 62, 73, 101),
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(),
                              ),
                              onChanged: (pin) {
                                if (pin.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                            ),
                          ),
                          //THIRD DIGIT
                          Container(
                            width: width * 0.075,
                            height: height * 0.05,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromARGB(255, 62, 73, 101),
                                  width: 5,
                                ),
                              ),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              cursorColor: Color.fromARGB(255, 62, 73, 101),
                              style: TextStyle(
                                fontFamily: 'OpunMai',
                                fontSize: height * 0.035,
                                fontWeight: FontWeight.w800,
                                color: Color.fromARGB(255, 62, 73, 101),
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(),
                              ),
                              onChanged: (pin) {
                                if (pin.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                            ),
                          ),
                          //FOURTH DIGIT
                          Container(
                            width: width * 0.075,
                            height: height * 0.05,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromARGB(255, 62, 73, 101),
                                  width: 5,
                                ),
                              ),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              cursorColor: Color.fromARGB(255, 62, 73, 101),
                              style: TextStyle(
                                fontFamily: 'OpunMai',
                                fontSize: height * 0.035,
                                fontWeight: FontWeight.w800,
                                color: Color.fromARGB(255, 62, 73, 101),
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(),
                              ),
                              onChanged: (pin) {
                                if (pin.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //IMAGE
                Visibility(
                  visible: _visible,
                  child: Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                ),

                //END DESCRIPTION
                Visibility(
                  visible: _visible,
                  child: Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //YOUR PIN CODE
                        Text(
                          'Your PIN code is ',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'OpunMai',
                            fontSize: height * 0.017,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 62, 73, 101),
                          ),
                        ),
                        //PIN TEXT
                        Text(
                          '0000',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'OpunMai',
                            fontSize: height * 0.017,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 62, 73, 101),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //ENTER BUTTON
                Flexible(
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    height: height * 0.045,
                    minWidth: width * 0.5,
                    color: widget.buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: FittedBox(
                      child: Text(
                        'ENTER',
                        style: TextStyle(
                          fontFamily: 'OpunMai',
                          fontWeight: FontWeight.w700,
                          fontSize: height * 0.02,
                          letterSpacing: 3,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
