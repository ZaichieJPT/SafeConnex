// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safeconnex/front_end_code/pages/emergency_button_pages/emergency_pinsetup_page.dart';

class InitialPinDialog extends StatefulWidget {
  const InitialPinDialog({
    super.key,
  });

  @override
  State<InitialPinDialog> createState() => _InitialPinDialogState();
}

class _InitialPinDialogState extends State<InitialPinDialog> {
  final TextEditingController feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Dialog(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: height * 0.3,
        width: width,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 241, 241, 241),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: height * 0.03,
            ),
            Flexible(
              flex: 3,
              child: FittedBox(
                child: Text(
                  'SOS CANCELLATION',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'OpunMai',
                    fontSize: width * 0.045,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 70, 85, 104),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 5,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: FittedBox(
                  child: Text(
                    'Please set up your PIN first\nin case you need to cancel\nyour SOS.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'OpunMai',
                      fontSize: width * 0.038,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 70, 85, 104),
                      letterSpacing: 0.7,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(),
            Flexible(
              flex: 3,
              child: Row(
                children: [
                  //SETUP PIN BUTTON CONTAINER
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: height * 0.1,
                      decoration: BoxDecoration(
                        color: Colors.red[300],
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                        ),
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 241, 241, 241),
                          ),
                          right: BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 241, 241, 241),
                          ),
                          left: BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 241, 241, 241),
                          ),
                        ),
                      ),
                      //SETUP PIN BUTTON
                      child: FractionallySizedBox(
                        widthFactor: 0.8,
                        heightFactor: 0.5,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SOSPinSetupPage(),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                              Colors.red[700],
                            ),
                            backgroundColor: MaterialStateProperty.all(
                              Colors.red[900],
                            ),
                            side: MaterialStateProperty.all<BorderSide>(
                              BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                          ),
                          child: FittedBox(
                            child: Text(
                              'Set up PIN',
                              style: TextStyle(
                                fontFamily: 'OpunMai',
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
