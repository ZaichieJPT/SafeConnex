// ignore_for_file: prefer_const_constructors

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_authentication.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_circle_database.dart';
import 'package:safeconnex/front_end_code/pages/circle_pages/join_circle_confirm.dart';
import 'package:safeconnex/front_end_code/provider/setting_provider.dart';

class JoinCirclePage extends StatefulWidget {
  const JoinCirclePage({super.key});

  @override
  State<JoinCirclePage> createState() => _JoinCirclePageState();
}

class _JoinCirclePageState extends State<JoinCirclePage> {
  final _joinCircleKey = GlobalKey<FormState>();
  final _joinCircleController = TextEditingController();
  SettingsProvider provider = SettingsProvider();
  //SafeConnexCircleDatabase circleDatabase = SafeConnexCircleDatabase();

  @override
  void dispose() {
    _joinCircleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            //SMALL CIRCLE
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.08,
                top: height * 0.02,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[100],
                    borderRadius: BorderRadius.circular(width),
                  ),
                ),
              ),
            ),
            //JOIN BANNER
            if (MediaQuery.of(context).viewInsets.bottom == 0) ...[
              Row(
                children: [
                  Container(
                    width: width * 0.9,
                    height: height * 0.4,
                    //color: Colors.amber,
                    child: Image.asset(
                      "assets/images/join_button.png",
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(width),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            //BACK BUTTON
            Expanded(
              child: Padding(
                padding:
                EdgeInsets.only(bottom: height * 0.2, left: width * 0.07),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          child: Align(
                            //alignment: Alignment.centerLeft,
                            child: Container(
                              width: width * 0.1,
                              height: width * 0.1,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: Color.fromARGB(255, 62, 73, 101),
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                Icons.arrow_back_ios_sharp,
                                size: height * 0.025,
                                color: Color.fromARGB(255, 62, 73, 101),
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    //ENTER CIRCLE CODE
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: width * 0.1),
                        child: Text(
                          "Enter your circle code.",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "OpunMai",
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 62, 73, 101),
                          ),
                        ),
                      ),
                    ),
                    //CIRCLE CODE TEXT FIELD
                    Form(
                      key: _joinCircleKey,
                      child: Container(
                        height: height * 0.07,
                        width: width * 0.6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.brown.shade100,
                              offset: Offset(3, 0),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          controller: _joinCircleController,
                          validator: (value) {
                            print(value);
                            return provider.joinCodeValidator(context, height,
                                width, value.toString());
                          },
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.center,
                          cursorColor: Color.fromARGB(255, 175, 173, 173),
                          maxLength: 6,
                          style: TextStyle(
                            fontSize: height * 0.015,
                            fontFamily: "OpunMai",
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.amber.shade100,
                            //isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 0),
                            hintText: "Circle Code",
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 175, 173, 173),
                              fontSize: 13,
                              height: 0.5,
                            ),
                            helperText: "",
                            helperStyle: TextStyle(
                              fontSize: 12,
                              height: 0.05,
                            ),
                            errorStyle: TextStyle(
                              fontSize: 15,
                              height: 0.05,
                            ),
                            counterText: '',
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1.5,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 175, 173, 173),
                                width: 0.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                    //ENTER BUTTON
                    Container(
                      height: height * 0.05,
                      width: width * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.lightGreen[100],
                        borderRadius: BorderRadius.circular(width * 0.025),
                      ),
                      child: TextButton(
                        onPressed: () {
                          DependencyInjector().locator<SafeConnexCircleDatabase>().getCircleToJoin(_joinCircleController.text).whenComplete((){
                            DependencyInjector().locator<SafeConnexCircleDatabase>().getCircleData(_joinCircleController.text).whenComplete((){
                              if(_joinCircleKey.currentState!.validate()){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmJoinCircle()));
                              }
                            });
                          });

                        },
                        child: Text(
                          "ENTER",
                          style: TextStyle(
                            fontSize: height * 0.02,
                            fontFamily: "OpunMai",
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 62, 73, 101),
                          ),
                        ),
                      ),
                    ),
                  ],
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

      /*
      Stack(
        children: [
          Positioned(
            right: 19,
            bottom: 610,
            child: Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                color: Colors.yellow.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Positioned(
            left: 52,
            bottom: 800,
            child: Container(
              height: 38,
              width: 38,
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Positioned(
            bottom: 500,
            left: 30,
            child: Image.asset(
              "assets/images/join_button.png",
              scale: 9.2,
            ),
          ),
          Positioned(
              bottom: 415,
              left: 40,
              child: InkWell(
                child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.black, width: 1)),
                    child: Icon(Icons.arrow_back_ios_sharp)),
                onTap: () {
                  Navigator.pop(context);
                },
              )),
          Positioned(
            bottom: 350,
            left: 60,
            child: Text(
              "Enter your circle code.",
              style: TextStyle(
                fontSize: 18,
                fontFamily: "OpunMai",
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 62, 73, 101),
              ),
            ),
          ),
          Positioned(
            bottom: 265,
            left: 80,
            child: Form(
              key: _joinCircleKey,
              child: Container(
                height: 65,
                width: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.brown.shade100,
                        offset: Offset(5, -1),
                      )
                    ]),
                child: TextFormField(
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  controller: _joinCircleController,
                  validator: (value) {
                    print(value);
                    if (value!.isEmpty) {
                      return "Please enter a Circle Code";
                    } else if (value.length < 6 || value.length > 6) {
                      return "Invalid Code";
                    } else {
                      if (CircleDatabaseHandler.circleData['circle_code'] ==
                              null ||
                          CircleDatabaseHandler.circleData['circle_name'] ==
                              null) {
                        return "Circle does not exist";
                      }
                      return null;
                    }
                  },
                  textAlignVertical: TextAlignVertical.center,
                  cursorColor: Color.fromARGB(255, 175, 173, 173),
                  maxLength: 6,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "OpunMai",
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.amber.shade100,
                    //isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 21, horizontal: 10),
                    hintText: "Circle Code",
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 175, 173, 173),
                      fontSize: 16,
                      height: 0.5,
                    ),
                    helperText: "",
                    helperStyle: TextStyle(
                      fontSize: 15,
                      height: 0.05,
                    ),
                    errorStyle: TextStyle(
                      fontSize: 15,
                      height: 0.05,
                    ),
                    counterText: '',
                    //floatingLabelStyle: TextStyle(color: Colors.black),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1.5,
                      ),
                    ),
                    focusedErrorBorder: true
                        ? OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.5,
                            ),
                          )
                        : null,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 175, 173, 173),
                        width: 0.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 180,
            left: 150,
            child: Container(
              height: 38,
              width: 120,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(13)),
              child: TextButton(
                onPressed: () {
                  circleDatabase.getCircle(_joinCircleController.text);
                  Future.delayed(Duration(milliseconds: 1500), () {
                    if (_joinCircleKey.currentState!.validate()) {
                      if (CircleDatabaseHandler.circleData.isEmpty) {
                        _joinCircleKey.currentState!.validate();
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConfirmJoinCircle()));
                      }
                    }
                  });
                },
                child: Text(
                  "ENTER",
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: "OpunMai",
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 62, 73, 101),
                  ),
                ),
              ),
            ),
          )
        ],
      ),*/
    );
  }
}