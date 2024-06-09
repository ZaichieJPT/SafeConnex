// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_auth.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_circle_database.dart';

class LeaveDialog extends StatefulWidget {
  final double height;
  final double width;
  final String? circleName;
  final String? circleCode;

  const LeaveDialog({
    super.key,
    required this.height,
    required this.width,
    this.circleName,
    this.circleCode,
  });

  @override
  State<LeaveDialog> createState() => _LeaveDialogState();
}

class _LeaveDialogState extends State<LeaveDialog> {
  final TextEditingController feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? _circleName = widget.circleName;
    CircleDatabaseHandler circleDatabaseHandler = CircleDatabaseHandler();
    FirebaseAuthHandler authHandler = FirebaseAuthHandler();
    return Dialog(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: widget.height * 0.37,
        color: Colors.transparent,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: widget.height * 0.32,
              width: widget.width,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 241, 241, 241),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: widget.height * 0.045,
                  ),
                  Flexible(
                    flex: 3,
                    child: FittedBox(
                      child: Text(
                        'EXIT THIS CIRCLE?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'OpunMai',
                          fontSize: widget.width * 0.05,
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
                          'Are you sure you want to\nleave this circle?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'OpunMai',
                            fontSize: widget.width * 0.038,
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
                        //CANCEL BUTTON CONTAINER
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 208, 228, 233),
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
                                right: BorderSide(
                                  width: 1,
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
                                  Icons.cancel,
                                  fill: 0,
                                  color: Color.fromARGB(255, 123, 123, 123),
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //CONTINUE BUTTON CONTAINER
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: widget.height * 0.1,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 70, 85, 104),
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
                                left: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 241, 241, 241),
                                ),
                              ),
                            ),
                            //LOGOUT BUTTON
                            child: FractionallySizedBox(
                              widthFactor: 0.8,
                              heightFactor: 0.7,
                              child: ElevatedButton(
                                onPressed: () {
                                  showToast(
                                    'You have left the\n$_circleName circle',
                                    textStyle: TextStyle(
                                      fontFamily: 'OpunMai',
                                      fontWeight: FontWeight.w600,
                                      fontSize: widget.height * 0.018,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                    context: context,
                                    backgroundColor: Colors.blue[300],
                                    position: StyledToastPosition.center,
                                    borderRadius: BorderRadius.circular(10),
                                    duration: Duration(milliseconds: 4000),
                                    animation: StyledToastAnimation.fade,
                                    reverseAnimation: StyledToastAnimation.fade,
                                    fullWidth: true,
                                  );
                                  // Circle leave Function
                                  circleDatabaseHandler.leaveCircle(authHandler.authHandler.currentUser!.uid, widget.circleCode!);
                                  Navigator.of(context).pop();
                                },
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 96, 96, 96),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 123, 123, 123),
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
                                    'Leave Circle',
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
            //LOGOUT ICON
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CircleAvatar(
                radius: widget.height * 0.048,
                backgroundColor: Colors.white,
                child: Image.asset(
                  'assets/images/side_menu/circle_settings/circlesettings_leave_icon.png',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
