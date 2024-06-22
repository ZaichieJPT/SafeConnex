// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_auth.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_circle_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_users_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_authentication.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_database.dart';
import 'package:safeconnex/front_end_code/components/home_components/error_snackbar.dart';
import 'package:safeconnex/front_end_code/components/login_textformfield.dart';
import 'package:safeconnex/front_end_code/pages/circle_pages/circle_results_page.dart';
import 'package:safeconnex/front_end_code/pages/circle_pages/join_circle_confirm.dart';
import 'package:safeconnex/front_end_code/provider/setting_provider.dart';

class EditCircleName extends StatefulWidget {
  const EditCircleName({super.key});

  @override
  State<EditCircleName> createState() => _EditCircleNameState();
}

class _EditCircleNameState extends State<EditCircleName> {
  TextEditingController _circleNameController = TextEditingController();
  final _circleKey = GlobalKey<FormState>();
  SafeConnexCircleDatabase circleDatabase = SafeConnexCircleDatabase();
  SettingsProvider provider = SettingsProvider();

  @override
  void dispose() {
    _circleNameController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/create_circle_background.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: height * 0.05,
                bottom: height * 0.08,
              ),
              child: Container(
                height: height * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //BACK BUTTON
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.07),
                      child: Row(
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
                    ),
                    //ENTER CIRCLE NAME
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: width * 0.1),
                        child: Text(
                          "Enter your new circle name.",
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
                    //CIRCLE NAME TEXT FIELD
                    Form(
                      key: _circleKey,
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
                          controller: _circleNameController,
                          validator: (circleName) {
                            // print(circleName);
                            // print(circleName);
                            return provider.createCircleNameValidator(
                              context,
                              height,
                              width,
                              circleName.toString(),
                            );
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
                            fillColor: Colors.white,
                            //isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 0),
                            hintText: "Circle Name",
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
                      height: height * 0.045,
                      width: width * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(width),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (_circleKey.currentState!.validate()) {
                            if (_circleNameController.text.length <= 25) {
                              circleDatabase.changeCircleName(_circleNameController.text, SafeConnexCircleDatabase.currentCircleCode!, SafeConnexAuthentication.currentUser!.uid);
                              circleDatabase.listCircleDataForSettings(SafeConnexAuthentication.currentUser!.uid);
                            }
                          }

                          Navigator.pop(context);
                        },
                        child: FittedBox(
                          child: Text(
                            "ENTER",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "OpunMai",
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 62, 73, 101),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //CREATE CIRCL BANNER
            if (MediaQuery.of(context).viewInsets.bottom == 0) ...[
              Expanded(
                flex: 3,
                child: Image.asset(
                  "assets/images/circle-newcircle-button.png",
                ),
              ),
              Flexible(child: SizedBox()),
            ],
          ],
        ),
      ),
    );
  }
}
