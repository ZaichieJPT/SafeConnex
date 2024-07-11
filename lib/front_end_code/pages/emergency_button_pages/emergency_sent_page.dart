// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_authentication.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_notification_database.dart';
import 'package:safeconnex/front_end_code/components/emergency_button_components/emergency_ripple_animation.dart';

class SOSSentPage extends StatelessWidget {
  const SOSSentPage({super.key, this.agencyType});
  final String? agencyType;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    bool _visible = MediaQuery.of(context).viewInsets.bottom == 0;

    String? pinNumber;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: width,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: const [
                Color.fromARGB(255, 238, 29, 35),
                Color.fromARGB(255, 155, 34, 34),
              ],
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
                  'EMERGENCY SOS',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'OpunMai',
                    fontSize: height * 0.027,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
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
                    color: Colors.white,
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
                    color: Colors.white,
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
                                color: Colors.white,
                                width: 5,
                              ),
                            ),
                          ),
                          child: TextFormField(
                            //controller: digit1Controller,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            cursorColor: Colors.white,
                            style: TextStyle(
                              fontFamily: 'OpunMai',
                              fontSize: height * 0.035,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
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
                                color: Colors.white,
                                width: 5,
                              ),
                            ),
                          ),
                          child: TextFormField(
                            //controller: digit2Controller,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            cursorColor: Colors.white,
                            style: TextStyle(
                              fontFamily: 'OpunMai',
                              fontSize: height * 0.035,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
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
                                color: Colors.white,
                                width: 5,
                              ),
                            ),
                          ),
                          child: TextFormField(
                            //controller: digit3Controller,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            cursorColor: Colors.white,
                            style: TextStyle(
                              fontFamily: 'OpunMai',
                              fontSize: height * 0.035,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
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
                                color: Colors.white,
                                width: 5,
                              ),
                            ),
                          ),
                          child: TextFormField(
                            //controller: digit4Controller,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            cursorColor: Colors.white,
                            style: TextStyle(
                              fontFamily: 'OpunMai',
                              fontSize: height * 0.035,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
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
                  flex: 4,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: width,
                        child: EmergencyRipple(
                          rippleRadius: 0.75,
                          //rippleColor: Color.fromARGB(255, 155, 34, 34),
                          child: Container(),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(width * 0.1),
                        width: width * 0.8,
                        //color: Colors.white,
                        child: Image.asset(
                            'assets/images/emergency_page/emergency-cancelpage-icon.png'),
                      ),
                    ],
                  ),
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
                          color: Colors.white,
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
                          color: Colors.yellow,
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
                    if(pinNumber == DependencyInjector().locator<SafeConnexAuthentication>().emergencyPin){
                      DependencyInjector().locator<SafeConnexNotificationDatabase>().sendNotificationToAgency(
                        2,
                        DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.displayName!,
                        DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.displayName!.trimRight(),
                        DependencyInjector().locator<SafeConnexAuthentication>().userData["age"]!,
                        DateFormat('yyyy/MMMM/dd hh:mm aaa').format(DateTime.now()),
                        agencyType
                      );
                      Navigator.pop(context);
                    }
                  },
                  height: height * 0.045,
                  minWidth: width * 0.5,
                  color: Colors.red[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(
                      color: Colors.white,
                      width: 1.5,
                    ),
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
    );
  }
}
