// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable
import "package:flutter/material.dart";

class PassCheck extends StatefulWidget {
  PassCheck({
    super.key,
    required this.checkText,
    this.isValid,
  });

  String checkText;
  bool? isValid;

  @override
  State<PassCheck> createState() => _PassCheckState();
}

class _PassCheckState extends State<PassCheck> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: 17,
          height: 17,
          decoration: BoxDecoration(
            color: (widget.isValid ?? false)
                ? Color.fromARGB(255, 239, 131, 30)
                : Color.fromARGB(255, 254, 214, 128),
            borderRadius: BorderRadius.circular(50),
          ),
          //CHECK ICON
          child: Center(
            child: Text(
              String.fromCharCode(Icons.check.codePoint),
              style: TextStyle(
                inherit: false,
                color: Color.fromARGB(255, 255, 237, 188),
                fontSize: 14,
                fontWeight: FontWeight.w900,
                fontFamily: Icons.check.fontFamily,
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        //VALIDATION CRITERIA
        Text(
          widget.checkText,
          style: TextStyle(
            fontSize: 12.5,
            fontFamily: "OpunMai",
            fontWeight:
                (widget.isValid ?? false) ? FontWeight.w600 : FontWeight.normal,
            color: Color.fromARGB(255, 62, 73, 101),
          ),
        ),
      ],
    );
  }
}
