// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class DeleteAccountDialog extends StatefulWidget {
  final double height;
  final double width;
  const DeleteAccountDialog({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  final TextEditingController feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  //DIALOG TITLE
                  Flexible(
                    flex: 3,
                    child: FittedBox(
                      child: Text(
                        'ARE YOU LEAVING?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'OpunMai',
                          fontSize: widget.width * 0.05,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 238, 29, 35),
                        ),
                      ),
                    ),
                  ),
                  //DIALOG MESSAGE
                  Flexible(
                    flex: 5,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: FittedBox(
                        child: Text(
                          'Are you sure you want to delete\nyour account? You might not be\nable to retrieve your data.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'OpunMai',
                            fontSize: widget.width * 0.037,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 238, 29, 35),
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
                              color: Color.fromARGB(255, 198, 164, 192),
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
                        //DELETE BUTTON CONTAINER
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: widget.height * 0.1,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 143, 75, 112),
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
                            //DELETE BUTTON
                            child: FractionallySizedBox(
                              widthFactor: 0.8,
                              heightFactor: 0.7,
                              child: ElevatedButton(
                                onPressed: () {
                                  showToast(
                                    'We are now deleting your account...',
                                    textStyle: TextStyle(
                                      fontFamily: 'OpunMai',
                                      fontWeight: FontWeight.w600,
                                      fontSize: widget.height * 0.018,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                    context: context,
                                    backgroundColor: Colors.red[400],
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
                                    Color.fromARGB(255, 133, 67, 101),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 200, 100, 152),
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
                                    'Delete',
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
                  'assets/images/side_menu/sidemenu_delete_icon.png',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
