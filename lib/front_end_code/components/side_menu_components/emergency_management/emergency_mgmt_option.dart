// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class EmergencyMgmtOption extends StatefulWidget {
  final String optionTitle;
  final String optionContent;
  final String image;
  final int index;
  final int selectedIndex;
  final Function onOptionTap;

  const EmergencyMgmtOption({
    super.key,
    required this.optionTitle,
    required this.optionContent,
    required this.image,
    required this.index,
    required this.selectedIndex,
    required this.onOptionTap,
  });

  @override
  State<EmergencyMgmtOption> createState() => _EmergencyMgmtOptionState();
}

class _EmergencyMgmtOptionState extends State<EmergencyMgmtOption> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return InkWell(
      onTap: () {
        widget.onOptionTap(widget.index);
      },
      child: Container(
        height: height * 0.095,
        color: widget.selectedIndex == widget.index
            ? Colors.white
            : Colors.transparent,
        child: Row(
          children: [
            //SETTING IMAGE
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.055,
                vertical: height * 0.0125,
              ),
              child: Image.asset(
                widget.image,
                width: width * 0.15,
              ),
            ),
            //SPACE
            SizedBox(
              width: width * 0.015,
            ),

            //SETTING TITLE AND CONTENT
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.006),
                child: Column(
                  children: [
                    //SETTING TITLE
                    Expanded(
                      child: Container(
                        width: width,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.optionTitle,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'OpunMai',
                            fontSize: height * 0.018,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 70, 81, 97),
                          ),
                        ),
                      ),
                    ),
                    //SETTING CONTENT
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(right: width * 0.075),
                        child: Text(
                          widget.optionContent,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontFamily: 'OpunMai',
                            fontSize: height * 0.017,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 70, 81, 97),
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
      ),
    );
  }
}
