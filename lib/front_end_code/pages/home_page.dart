// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:safeconnex/front_end_code/components/home_components/emergency_mini_button.dart';
import 'package:safeconnex/front_end_code/components/home_components/home_app_bar.dart';
import 'package:safeconnex/front_end_code/pages/emergency_button_pages/emergency_countdown_template.dart';
import 'package:safeconnex/front_end_code/pages/emergency_button_pages/emergency_initialpin_dialog.dart';
import 'package:safeconnex/front_end_code/pages/emergency_button_pages/emergency_received_template.dart';
import 'package:safeconnex/front_end_code/provider/new_map_provider.dart';

class HomePage extends StatefulWidget {
  final double height;
  final double width;
  const HomePage({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? _timer;
  final ScrollController _scrollController = ScrollController();
  bool _toggle = false;
  double buttonScale = 0;
  double buttonScale_2 = 0;

  Alignment alignment1 = Alignment(0.0, 1.0);
  Alignment alignment2 = Alignment(0.0, 1.0);
  Alignment alignment3 = Alignment(0.0, 1.0);
  Alignment alignment4 = Alignment(0.0, 1.0);

  toggleButtons() {
    setState(() {
      _toggle = !_toggle;
      if (_toggle) {
        alignment1 = Alignment(-0.65, 0.9);
        alignment2 = Alignment(-0.3, 0.1);
        alignment3 = Alignment(0.3, 0.1);
        alignment4 = Alignment(0.65, 0.9);
      } else {
        alignment1 = Alignment(0.0, 1.0);
        alignment2 = Alignment(0.0, 1.0);
        alignment3 = Alignment(0.0, 1.0);
        alignment4 = Alignment(0.0, 1.0);
      }
      //print(_toggle);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //SCROLLABLE BODY
        //NewMapProvider(),

        //APP BAR
        HomeAppBar(
          height: widget.height,
          scrollController: _scrollController,
        ),
        if (_toggle)
          Opacity(
            opacity: 0.4,
            child: ModalBarrier(
              dismissible: true,
              onDismiss: () {
                toggleButtons();
                setState(() {
                  _toggle ? buttonScale = 0.9 : buttonScale = 0.1;
                });
              },
              color: Colors.black,
            ),
          ),

        //FAB SPEED DIAL
        Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: widget.height * 0.3,
                //color: Colors.white,
                child: Stack(
                  children: [
                    //BUTTONS CONTAINER TRAY
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: AnimatedScale(
                        duration: Duration(milliseconds: 700),
                        curve: Curves.easeInOutBack,
                        scale: buttonScale,
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(
                          'assets/images/emg-button-bg.png',
                        ),
                      ),
                    ),
                    //FIRE BUTTON
                    EMGMiniButton(
                      toggle: _toggle,
                      alignment: alignment1,
                      color: Colors.orange.shade400,
                      icon: Icons.local_fire_department_outlined,
                      iconColor: Colors.white,
                      tooltip: 'BFP',
                      countdownPageTitle: 'FIRE HAZARD SOS',
                      SOSType: 'Fire',
                      colorBG: Colors.orange.shade400,
                    ),
                    //SAFETY BUTTON
                    EMGMiniButton(
                      toggle: _toggle,
                      alignment: alignment2,
                      color: Colors.grey.shade700,
                      icon: Icons.local_police_outlined,
                      iconColor: Colors.white,
                      tooltip: 'PNP',
                      countdownPageTitle: 'CRIMINAL DANGER SOS',
                      SOSType: 'Criminal Safety',
                      colorBG: Color.fromARGB(255, 168, 168, 171),
                    ),
                    //MEDICAL/ACCIDENTS BUTTON
                    EMGMiniButton(
                      toggle: _toggle,
                      alignment: alignment3,
                      color: Colors.cyan.shade700,
                      icon: Icons.medical_services_outlined,
                      iconColor: Colors.white,
                      tooltip: 'PNP/CDRRMO',
                      countdownPageTitle: 'MEDICAL EMERGENCY SOS',
                      SOSType: 'Medical',
                      colorBG: Colors.cyan.shade700,
                    ),
                    //NATURAL EMERGENCY BUTTON
                    EMGMiniButton(
                      toggle: _toggle,
                      alignment: alignment4,
                      color: Colors.green.shade300,
                      icon: Icons.flood_outlined,
                      iconColor: Colors.white,
                      tooltip: 'CDRRMO',
                      countdownPageTitle:
                      'NATURAL DISASTER AND\n ACCIDENTS SOS',
                      SOSType: 'Disaster/Accident',
                      colorBG: Colors.green.shade300,
                    ),
                    //SCALING RED TRAY
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: AnimatedScale(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.linear,
                        scale: buttonScale_2,
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(
                          'assets/images/emg-button-bg.png',
                        ),
                      ),
                    ),

                    //EMERGENCY BUTTON
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          toggleButtons();
                          setState(() {
                            _toggle ? buttonScale = 0.9 : buttonScale = 0;
                          });
                        },
                        onLongPressDown: (details) {
                          double timeLeft = 1.5;
                          Future.delayed(Duration(milliseconds: 100), () {
                            _timer = Timer.periodic(
                              Duration(milliseconds: 500),
                                  (timer) {
                                setState(
                                      () {
                                    timeLeft -= 0.5;
                                    if (timeLeft > 0) {
                                      buttonScale_2 += 5;
                                      if (timeLeft == 3 ||
                                          timeLeft == 2 ||
                                          timeLeft == 1 ||
                                          timeLeft == 0) {
                                        print('time: ' + timeLeft.toString());
                                      }
                                    } else {
                                      timer.cancel();

                                      // showDialog(
                                      //   context: context,
                                      //   builder: (BuildContext context) {
                                      //     return InitialPinDialog();
                                      //   },
                                      // );

                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return EmergencyReceivedDialog();
                                        },
                                      );

                                      // Navigator.of(context).push(
                                      //   MaterialPageRoute(
                                      //     builder: (context) => CountdownTemplate(
                                      //       pageTitle: 'EMERGENCY SOS',
                                      //       buttonColor: Colors.red.shade400,
                                      //       fontColor: Colors.red.shade900,
                                      //       PINColor: Colors.yellow,
                                      //       colorBG: Colors.white,
                                      //       SOSType: 'General',
                                      //     ),
                                      //   ),
                                      // );
                                      buttonScale_2 = 0;
                                    }
                                  },
                                );
                              },
                            );
                          });
                        },
                        onLongPressEnd: (details) {
                          setState(
                                () {
                              _timer!.cancel();
                              buttonScale_2 = 0;
                            },
                          );
                        },
                        onLongPressCancel: () {
                          setState(
                                () {
                              _timer!.cancel();
                              buttonScale_2 = 0;
                            },
                          );
                        },
                        child: SizedBox(
                          width: widget.width * 0.3,
                          child: Image.asset(
                            'assets/images/home_emergency_btnIcon.png',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}