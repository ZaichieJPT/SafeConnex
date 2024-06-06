// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class FeedbackDialog extends StatefulWidget {
  final double height;
  final double width;
  const FeedbackDialog({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  final TextEditingController feedbackController = TextEditingController();

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: widget.height * 0.5,
        //color: Colors.red,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: widget.height * 0.45,
              width: widget.width,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 241, 241, 241),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: widget.height * 0.05,
                  ),
                  Flexible(
                    child: FittedBox(
                      child: Text(
                        'Share your thoughts\nabout the app',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'OpunMai',
                          fontSize: widget.width * 0.045,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 120, 120, 120),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                        controller: feedbackController,
                        expands: true,
                        maxLines: null,
                        cursorColor: Color.fromARGB(255, 123, 123, 123),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontFamily: 'OpunMai',
                          fontSize: widget.width * 0.04,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 123, 123, 123),
                        ),
                      ),
                    ),
                  ),
                  //SPACE
                  SizedBox(
                    height: widget.height * 0.02,
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        //CANCEL BUTTON CONTAINER
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 153, 203, 172),
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
                        //SEND BUTTON CONTAINER
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: widget.height * 0.1,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 112, 195, 145),
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
                            //SEND BUTTON
                            child: FractionallySizedBox(
                              widthFactor: 0.8,
                              heightFactor: 0.7,
                              child: ElevatedButton(
                                onPressed: () {
                                  String userFeedback = feedbackController.text;
                                  print('The user entered: $userFeedback');
                                  showToast(
                                    'Phew, thanks for the feedback! :D\n\nWe were starting to think nobody actually used this app.',
                                    textStyle: TextStyle(
                                      fontFamily: 'OpunMai',
                                      fontWeight: FontWeight.w600,
                                      fontSize: widget.height * 0.018,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                    context: context,
                                    backgroundColor: Colors.green[300],
                                    position: StyledToastPosition.center,
                                    borderRadius: BorderRadius.circular(10),
                                    duration: Duration(milliseconds: 4000),
                                    animation: StyledToastAnimation.fade,
                                    reverseAnimation: StyledToastAnimation.fade,
                                    fullWidth: true,
                                  );
                                  Navigator.of(context).pop();
                                },
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                    Colors.amber[700],
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.amber[300],
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
                                    'Send',
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
            //FEEDBACK ICON
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CircleAvatar(
                radius: widget.height * 0.048,
                backgroundColor: Colors.white,
                child: Image.asset(
                  'assets/images/side_menu/sidemenu_feedback_icon.png',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}