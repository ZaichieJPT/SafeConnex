// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmergencyReceivedDialog extends StatefulWidget {
  const EmergencyReceivedDialog({super.key});

  @override
  State<EmergencyReceivedDialog> createState() =>
      _EmergencyReceivedDialogState();
}

class _EmergencyReceivedDialogState extends State<EmergencyReceivedDialog> {
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
        height: height * 0.445,
        color: Colors.transparent,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: height * 0.4,
              width: width,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 241, 241, 241),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Container(
                    width: width * 0.22,
                    height: width * 0.22,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.red,
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red,
                          offset: Offset(0, 5),
                          blurRadius: width * 0.04,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    child: FittedBox(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: height * 0.02),
                        child: Column(
                          children: [
                            //MAIN EMERGENCY MESSAGE
                            Text(
                              'Garry needs help!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'OpunMai',
                                fontSize: height * 0.022,
                                fontWeight: FontWeight.w700,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            //SUB MESSAGE
                            Text(
                              'Garry has triggered an SOS.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'OpunMai',
                                fontSize: height * 0.02,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 70, 85, 104),
                                letterSpacing: 0.7,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: height * 0.1,
                      width: width,
                      color: Colors.grey.shade300,
                      child: Column(
                        children: [
                          //WARNING ICONS
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 5, left: 5),
                                  child: Image.asset(
                                    'assets/images/emergency_page/emergency_triggered_icon.png',
                                    width: width * 0.07,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Image.asset(
                                    'assets/images/emergency_page/emergency_triggered_icon.png',
                                    width: width * 0.07,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Image.asset(
                                    'assets/images/emergency_page/emergency_triggered_icon.png',
                                    width: width * 0.07,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //CHECK THE LOCATION TEXT
                          Expanded(
                            child: Text(
                              'CHECK THE LOCATION?',
                              style: TextStyle(
                                fontFamily: 'OpunMai',
                                fontSize: height * 0.015,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 70, 85, 104),
                                letterSpacing: 0.7,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //SizedBox(),
                  Flexible(
                    flex: 3,
                    child: Row(
                      children: [
                        //CANCEL BUTTON CONTAINER
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 49, 56, 74),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                              ),
                              border: Border(
                                bottom: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 241, 241, 241),
                                ),
                                left: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 241, 241, 241),
                                ),
                              ),
                            ),
                            //CANCEL BUTTON
                            child: FittedBox(
                              child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(
                                  Icons.cancel_outlined,
                                  fill: 0,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //CONTINUE BUTTON CONTAINER
                        Expanded(
                          flex: 4,
                          child: Container(
                            height: height * 0.1,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 70, 86, 101),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(25),
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
                              ),
                            ),
                            //OKAY BUTTON
                            child: FractionallySizedBox(
                              widthFactor: 0.75,
                              heightFactor: 0.6,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 102, 143, 104),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 143, 201, 146),
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
                                    'OKAY',
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
            //EMERGENCY AGENCY ICON
            Positioned(
              top: 0,
              left: width * 0.07,
              right: width * 0.07,
              child: Container(
                height: height * 0.055,
                width: width * 0.1,
                padding: EdgeInsets.symmetric(vertical: height * 0.005),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width * 0.25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.local_fire_department_outlined,
                    color: Colors.white,
                    size: width * 0.085,
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
