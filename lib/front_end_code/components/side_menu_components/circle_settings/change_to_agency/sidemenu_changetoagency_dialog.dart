// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:safeconnex/front_end_code/components/side_menu_components/circle_settings/change_to_agency/changetoagency_step1_page.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/circle_settings/change_to_agency/changetoagency_step2_page.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/circle_settings/change_to_agency/changetoagency_step3_page.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/circle_settings/change_to_agency/changetoagency_step4_page.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/circle_settings/change_to_agency/changetoagency_step5_page.dart';

class ChangeToAgency extends StatefulWidget {
  final double height;
  final double width;
  const ChangeToAgency({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  State<ChangeToAgency> createState() => _ChangeToAgencyState();
}

class _ChangeToAgencyState extends State<ChangeToAgency> {
  final TextEditingController feedbackController = TextEditingController();
  int step = 1;

  _moveToNextStep() {
    setState(() {
      step++;
      if (step > 5) {
        step = 1;
      }
      print('Current page: $step');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.width * 0.06),
      ),
      //insetPadding: EdgeInsets.symmetric(horizontal: widget.width * 0.09),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SizedBox(
          height: widget.height * 0.73,
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: widget.height * 0.16,
                  //width: widget.width * 0.7,
                  alignment: Alignment.bottomCenter,
                  //color: Colors.red,
                  //REGISTRATION STATUS
                  child: Image.asset(
                    'assets/images/change_to_agency/agency_step${step}_status.png',
                    //fit: BoxFit.contain,
                  ),
                ),
                Container(
                  height: widget.height * 0.565,
                  decoration: BoxDecoration(
                    //color: Colors.yellow,
                    borderRadius: BorderRadius.circular(widget.width * 0.06),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    fit: StackFit.expand,
                    children: [
                      //BACKGROUND IMAGE
                      Image.asset(
                        'assets/images/change_to_agency/agency_dialog_bg.png',
                        fit: BoxFit.fill,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: widget.height * 0.01,
                          ),
                          //STEP 1 TEXT
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //BACKBUTTON
                                step > 1
                                    ? Flexible(
                                        child: Padding(
                                        padding: EdgeInsets.only(
                                          top: widget.height * 0.02,
                                          bottom: widget.height * 0.02,
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              step--;
                                            });
                                          },
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          radius: 1,
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Color.fromARGB(
                                                    255, 232, 220, 206),
                                                width: 3,
                                              ),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 182, 176, 163),
                                                  offset: Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                            child: FittedBox(
                                              child: Text(
                                                String.fromCharCode(
                                                    Icons.west.codePoint),
                                                style: TextStyle(
                                                  fontFamily:
                                                      Icons.west.fontFamily,
                                                  fontSize:
                                                      widget.width * 0.055,
                                                  fontWeight: FontWeight.w900,
                                                  color: Color.fromARGB(
                                                      255, 110, 101, 94),
                                                  package:
                                                      Icons.west.fontPackage,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))
                                    : Spacer(),
                                //STEP TITLE TEXT
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'STEP $step',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'OpunMai',
                                      fontSize: widget.width * 0.07,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                            // child: Text(
                            //   'STEP $step',
                            //   textAlign: TextAlign.center,
                            //   style: TextStyle(
                            //     fontFamily: 'OpunMai',
                            //     fontSize: widget.width * 0.07,
                            //     fontWeight: FontWeight.w700,
                            //     color: Colors.white,
                            //   ),
                            // ),
                          ),
                          //STEP BODY
                          Flexible(
                            flex: 6,
                            child: step == 1
                                ? AgencyStep1(
                                    toNextStep: _moveToNextStep,
                                  )
                                : step == 2
                                    ? AgencyStep2(
                                        toNextStep: _moveToNextStep,
                                      )
                                    : step == 3
                                        ? AgencyStep3(
                                            toNextStep: _moveToNextStep,
                                          )
                                        : step == 4
                                            ? AgencyStep4(
                                                toNextStep: _moveToNextStep,
                                              )
                                            : AgencyStep5(
                                                toNextStep: _moveToNextStep,
                                              ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
