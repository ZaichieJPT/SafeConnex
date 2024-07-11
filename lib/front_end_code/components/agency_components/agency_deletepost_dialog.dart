// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_news_database.dart';

class AgencyDeletePost extends StatefulWidget {
  final Function onDeleteTapped;
  int postIndex;
  String postKey;

  AgencyDeletePost({
    super.key,
    required this.onDeleteTapped,
    required this.postIndex,
    required this.postKey,
  });

  @override
  State<AgencyDeletePost> createState() => _AgencyDeletePostState();
}

class _AgencyDeletePostState extends State<AgencyDeletePost> {
  final TextEditingController feedbackController = TextEditingController();
  bool isDeleteConfirmed = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: width * 0.04),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Container(
          height: height * 0.32,
          width: width,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 241, 241, 241),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: height * 0.045,
              ),
              Flexible(
                flex: 3,
                child: FittedBox(
                  child: Text(
                    'DELETE POST',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'OpunMai',
                      fontSize: width * 0.05,
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
                      'Are you sure you want to\ndelete this post?',
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
                    //DELETE BUTTON CONTAINER
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: height * 0.1,
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
                        //DELETE BUTTON
                        child: FractionallySizedBox(
                          widthFactor: 0.8,
                          heightFactor: 0.7,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isDeleteConfirmed = true;
                                widget.onDeleteTapped(
                                    isDeleteConfirmed, widget.postIndex);
                              });
                              DependencyInjector().locator<SafeConnexNewsDatabase>().deleteNews(widget.postKey);
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
      );
    });
  }
}