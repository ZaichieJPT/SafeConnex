// ignore_for_file: prefer_const_constructors
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_authentication.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_circle_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_firestore.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_notification.dart';
import 'package:safeconnex/front_end_code/components/emergency_button_components/emergency_ripple_animation.dart';
import 'package:safeconnex/front_end_code/pages/emergency_button_pages/emergency_agencysent_template.dart';
import 'package:safeconnex/front_end_code/pages/emergency_button_pages/emergency_sent_page.dart';

class CountdownTemplate extends StatefulWidget {
  final String pageTitle;
  final List<Color>? gradientBG;
  final Color? colorBG;
  final Color buttonColor;
  final Color fontColor;
  final Color PINColor;

  //SOS SENT PAGE
  final Icon? pageIcon;
  final String SOSType;

  const CountdownTemplate({
    super.key,
    required this.pageTitle,
    required this.buttonColor,
    required this.fontColor,
    required this.PINColor,
    this.pageIcon,
    required this.SOSType,
    this.gradientBG,
    this.colorBG,
  });

  @override
  State<CountdownTemplate> createState() => _CountdownTemplateState();
}

class _CountdownTemplateState extends State<CountdownTemplate> {
  Timer? _timer;
  int timeLeft = 10;
  String? pinNumber;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (timeLeft > 0) {
          setState(() {
            timeLeft--;
          });
        } else {
          DependencyInjector().locator<SafeConnexNotification>().getNotificationTokens();
          for(var person in DependencyInjector().locator<SafeConnexNotification>().notificationTokenList){
            DependencyInjector().locator<SafeConnexNotification>().sendNotification(
                person,
                "${DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.displayName} needs help!",
                "Please send help!!",
                {
                  "location": DependencyInjector().locator<SafeConnexGeolocation>().geocodedStreet,
                });
          }
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => widget.SOSType == 'General'
                  ? SOSSentPage()
                  : SOSSentTemplate(
                      pageTitle: widget.pageTitle,
                      buttonColor: widget.buttonColor,
                      pageIcon: widget.pageIcon!,
                      colorBG: widget.colorBG,
                    ),
            ),
          );
          _timer!.cancel();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    List<Color> gradient = widget.gradientBG == null
        ? [
            widget.colorBG!,
            widget.colorBG!,
          ]
        : widget.gradientBG!;

    widget.gradientBG ?? [widget.colorBG!, widget.colorBG!];

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
              gradient: RadialGradient(
                colors: gradient,
                radius: 0.9,
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
                      color: widget.fontColor,
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
                      color: widget.fontColor,
                    ),
                  ),
                ),
                //PAGE DESCRIPTION
                Flexible(
                  child: Text(
                    'After 10 seconds, your SOS and location\nwill be send to your emergency contacts.',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'OpunMai',
                      fontSize: height * 0.018,
                      fontWeight: FontWeight.w400,
                      color: widget.fontColor,
                    ),
                  ),
                ),

                //COUNTDOWN
                Flexible(
                  flex: 1,
                  child: Container(
                    //padding: EdgeInsets.all(width * 0.07),
                    width: width * 0.25,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: widget.buttonColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      timeLeft.toString(),
                      style: TextStyle(
                        fontFamily: 'OpunMai',
                        fontSize: height * 0.05,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
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
                                  color: widget.fontColor,
                                  width: 5,
                                ),
                              ),
                            ),
                            child: TextFormField(
                              //controller: digit1Controller,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              cursorColor: widget.fontColor,
                              style: TextStyle(
                                fontFamily: 'OpunMai',
                                fontSize: height * 0.035,
                                fontWeight: FontWeight.w800,
                                color: widget.fontColor,
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
                                  pinNumber = pin;
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
                                  color: widget.fontColor,
                                  width: 5,
                                ),
                              ),
                            ),
                            child: TextFormField(
                             // controller: digit2Controller,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              cursorColor: widget.fontColor,
                              style: TextStyle(
                                fontFamily: 'OpunMai',
                                fontSize: height * 0.035,
                                fontWeight: FontWeight.w800,
                                color: widget.fontColor,
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
                                  pinNumber = pinNumber! + pin;
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
                                  color: widget.fontColor,
                                  width: 5,
                                ),
                              ),
                            ),
                            child: TextFormField(
                              //controller: digit3Controller,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              cursorColor: widget.fontColor,
                              style: TextStyle(
                                fontFamily: 'OpunMai',
                                fontSize: height * 0.035,
                                fontWeight: FontWeight.w800,
                                color: widget.fontColor,
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
                                  pinNumber = pinNumber! + pin;
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
                                  color: widget.fontColor,
                                  width: 5,
                                ),
                              ),
                            ),
                            child: TextFormField(
                              //controller: digit4Controller,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              cursorColor: widget.fontColor,
                              style: TextStyle(
                                fontFamily: 'OpunMai',
                                fontSize: height * 0.035,
                                fontWeight: FontWeight.w800,
                                color: widget.fontColor,
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
                                  pinNumber = pinNumber! + pin;
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
                            color: widget.fontColor,
                          ),
                        ),
                        //PIN TEXT
                        Text(
                          DependencyInjector().locator<SafeConnexAuthentication>().emergencyPin!,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'OpunMai',
                            fontSize: height * 0.017,
                            fontWeight: FontWeight.w400,
                            color: widget.PINColor,
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
                      if(pinNumber == DependencyInjector().locator<SafeConnexAuthentication>().emergencyPin!){
                        Navigator.pop(context);
                      }
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
