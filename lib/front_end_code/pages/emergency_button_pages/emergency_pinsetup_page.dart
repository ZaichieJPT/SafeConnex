// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class SOSPinSetupPage extends StatelessWidget {
  const SOSPinSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    bool _visible = MediaQuery.of(context).viewInsets.bottom == 0;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [
                Color.fromARGB(255, 225, 222, 222),
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //BACK BUTTON
              Flexible(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.035, left: width * 0.03),
                    child: IconButton(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.zero,
                      onPressed: () => Navigator.pop(context),
                      icon: Text(
                        String.fromCharCode(Icons.arrow_back_ios.codePoint),
                        style: TextStyle(
                          color: Color.fromARGB(255, 70, 85, 104),
                          fontFamily: Icons.arrow_back_ios.fontFamily,
                          fontWeight: FontWeight.w900,
                          fontSize: height * 0.035,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //PAGE TITLE
              Flexible(
                child: Text(
                  'SOS CANCELLATION PIN',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'OpunMai',
                    fontSize: height * 0.025,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 63, 74, 104),
                  ),
                ),
              ),
              //PAGE DESCRIPTION
              Flexible(
                child: Text(
                  'In case you wanted to cancel your\nSOS, you may enter this pin.',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'OpunMai',
                    fontSize: height * 0.02,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 63, 74, 104),
                  ),
                ),
              ),
              //CHOOSE PIN TEXT
              Flexible(
                child: Text(
                  'Lets choose your 4-digit PIN now;',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'OpunMai',
                    fontSize: height * 0.017,
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 63, 74, 104),
                  ),
                ),
              ),
              //PIN TEXT FIELD
              Flexible(
                child: Form(
                  child: Container(
                    //color: Colors.amber,
                    width: width * 0.8,
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
                                color: Color.fromARGB(255, 63, 74, 104),
                                width: 5,
                              ),
                            ),
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            cursorColor: Color.fromARGB(255, 63, 74, 104),
                            style: TextStyle(
                              fontFamily: 'OpunMai',
                              fontSize: height * 0.035,
                              fontWeight: FontWeight.w800,
                              color: Color.fromARGB(255, 63, 74, 104),
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
                                color: Color.fromARGB(255, 63, 74, 104),
                                width: 5,
                              ),
                            ),
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            cursorColor: Color.fromARGB(255, 63, 74, 104),
                            style: TextStyle(
                              fontFamily: 'OpunMai',
                              fontSize: height * 0.035,
                              fontWeight: FontWeight.w800,
                              color: Color.fromARGB(255, 63, 74, 104),
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
                                color: Color.fromARGB(255, 63, 74, 104),
                                width: 5,
                              ),
                            ),
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            cursorColor: Color.fromARGB(255, 63, 74, 104),
                            style: TextStyle(
                              fontFamily: 'OpunMai',
                              fontSize: height * 0.035,
                              fontWeight: FontWeight.w800,
                              color: Color.fromARGB(255, 63, 74, 104),
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
                                color: Color.fromARGB(255, 63, 74, 104),
                                width: 5,
                              ),
                            ),
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            cursorColor: Color.fromARGB(255, 63, 74, 104),
                            style: TextStyle(
                              fontFamily: 'OpunMai',
                              fontSize: height * 0.035,
                              fontWeight: FontWeight.w800,
                              color: Color.fromARGB(255, 63, 74, 104),
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
                  flex: 4,
                  child: Container(
                    width: width * 0.6,
                    child: Image.asset(
                        'assets/images/emergency_page/emergency-pinsetup-icon.png'),
                  ),
                ),
              ),

              //END DESCRIPTION
              Visibility(
                visible: _visible,
                child: Flexible(
                  child: Text(
                    'You can always reset your PIN\ncode in settings.',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'OpunMai',
                      fontSize: height * 0.02,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 63, 74, 104),
                    ),
                  ),
                ),
              ),

              //SAVE BUTTON

              Flexible(
                child: MaterialButton(
                  onPressed: () {},
                  height: height * 0.045,
                  minWidth: width * 0.5,
                  color: Color.fromARGB(255, 178, 64, 64),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: FittedBox(
                    child: Text(
                      'Save PIN',
                      style: TextStyle(
                        fontFamily: 'OpunMai',
                        fontWeight: FontWeight.w700,
                        fontSize: height * 0.02,
                        letterSpacing: 1.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: height * 0.05),
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
