// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:safeconnex/front_end_code/pages/emergency_button_pages/emergency_countdown_template.dart';

class EMGMiniButton extends StatefulWidget {
  final bool toggle;
  final Alignment alignment;
  final Color color;
  final Color iconColor;
  final IconData icon;
  final String tooltip;

  //FOR COUNTDOWN TEMPLATE
  final String countdownPageTitle;
  final String SOSType;
  final Color colorBG;

  const EMGMiniButton({
    super.key,
    required this.toggle,
    required this.alignment,
    required this.color,
    required this.icon,
    required this.iconColor,
    required this.tooltip,
    required this.countdownPageTitle,
    required this.SOSType,
    required this.colorBG,
  });

  @override
  State<EMGMiniButton> createState() => _EMGMiniButtonState();
}

class _EMGMiniButtonState extends State<EMGMiniButton> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return AnimatedAlign(
      // duration: widget.toggle
      //     ? const Duration(milliseconds: 875)
      //     : const Duration(milliseconds: 275),
      // alignment: widget.alignment,
      // curve: widget.toggle ? Curves.elasticOut : Curves.easeIn,
      duration: Duration(milliseconds: 700),
      curve: Curves.easeInOutBack,
      alignment: widget.alignment,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 275),
        curve: widget.toggle ? Curves.easeIn : Curves.easeOut,
        width: width * 0.155,
        height: width * 0.155,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Tooltip(
          message: widget.tooltip,
          preferBelow: false,
          verticalOffset: 40,
          textStyle: TextStyle(
            fontFamily: 'OpunMai',
            fontSize: 12,
            color: Color.fromARGB(255, 70, 85, 104),
          ),
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CountdownTemplate(
                    pageTitle: widget.countdownPageTitle,
                    buttonColor: widget.color,
                    fontColor: Color.fromARGB(255, 62, 73, 101),
                    PINColor: Color.fromARGB(255, 62, 73, 101),
                    gradientBG: const [
                      Color.fromARGB(255, 225, 222, 222),
                      Color.fromARGB(255, 241, 241, 241),
                    ],
                    pageIcon: Icon(
                      widget.icon,
                      color: Colors.white,
                      size: width * 0.15,
                    ),
                    SOSType: widget.SOSType,
                    colorBG: widget.colorBG,
                  ),
                ),
              );
            },
            icon: Icon(
              widget.icon,
              color: widget.iconColor,
              size: width * 0.1,
            ),
          ),
        ),
      ),
    );
  }
}
