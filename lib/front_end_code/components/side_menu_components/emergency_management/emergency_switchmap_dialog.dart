// ignore_for_file: prefer_const_constructors

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_database.dart';

class SwitchMapDialog extends StatefulWidget {
  SwitchMapDialog({
    super.key,
  });

  @override
  State<SwitchMapDialog> createState() => _SwitchMapDialogState();
}

class _SwitchMapDialogState extends State<SwitchMapDialog> {
  final TextEditingController feedbackController = TextEditingController();
  bool _isMapSwitched = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return StatefulBuilder(builder: (context, setState) {
      return Dialog(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: height * 0.37,
          color: Colors.transparent,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: height * 0.33,
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
                          'SWITCH MAP LAYER?',
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
                      flex: 3,
                      child: AnimatedToggleSwitch.size(
                        current: _isMapSwitched,
                        values: const [false, true],
                        iconOpacity: 1,
                        indicatorSize: Size.fromWidth(width * 0.2),
                        borderWidth: width * 0.01,
                        iconAnimationType: AnimationType.onHover,
                        selectedIconScale: 2.0,
                        customIconBuilder: (context, local, global) =>
                            FittedBox(
                          child: Text(
                            local.value
                                ? String.fromCharCode(Icons.check.codePoint)
                                : String.fromCharCode(Icons.close.codePoint),
                            style: TextStyle(
                              fontFamily: local.value
                                  ? Icons.check.fontFamily
                                  : Icons.close.fontFamily,
                              fontWeight: FontWeight.w900,
                              fontSize: height * 0.05,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        style: ToggleStyle(
                          indicatorColor: Colors.white,
                          borderRadius: BorderRadius.circular(width * 0.02),
                          borderColor: Colors.transparent,
                          backgroundColor: _isMapSwitched
                              ? Color.fromARGB(255, 49, 56, 74)
                              : Color.fromARGB(255, 121, 189, 148),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _isMapSwitched = value;
                            SafeConnexSafetyScoringDatabase.isMapSwitched = value;
                            print('Switched: ${_isMapSwitched}');
                          });
                        },
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: FittedBox(
                          child: Text(
                            'View Safety Score Mapping',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'OpunMai',
                              fontSize: height * 0.02,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 70, 85, 104),
                              letterSpacing: 0.7,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //SizedBox(),
                    Flexible(
                      flex: 4,
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
                              height: height * 0.1,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 49, 56, 74),
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
                                    Navigator.pop(context);
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
                                      'Confirm',
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
                  radius: height * 0.045,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    'assets/images/side_menu/emergency_mgmt/emergencymgmt_switchmap_icon.png',
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
