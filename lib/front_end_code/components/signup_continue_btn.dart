// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";

class BtnContinue extends StatefulWidget {
  const BtnContinue({
    super.key,
    required this.backgroundColor,
    required this.borderColor,
    this.fontColor,
    required this.btnName,
    this.borderRadius,
    this.borderWidth,
    required this.height,
    required this.topMargin,
    required this.leftMargin,
    required this.rightMargin,
    required this.fontSize,
    required this.continueClicked,
    this.formKey,
  });

  final Color backgroundColor;
  final Color borderColor;
  final Color? fontColor;
  final String btnName;
  final double? borderRadius;
  final double? borderWidth;
  final double height;
  final double fontSize;
  final double topMargin;
  final double leftMargin;
  final double rightMargin;
  final Function() continueClicked;

  final GlobalKey<FormState>? formKey;

  @override
  State<BtnContinue> createState() => _BtnContinueState();
}

class _BtnContinueState extends State<BtnContinue> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      width: double.infinity,
      height: widget.height,
      margin: EdgeInsets.only(
        left: widget.leftMargin,
        right: widget.rightMargin,
        top: widget.topMargin,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 5),
            side: BorderSide(
              color: widget.borderColor,
              width: widget.borderWidth ?? 2,
            ),
          ),
        ),
        onPressed: widget.continueClicked,
        child: FittedBox(
          child: Text(
            widget.btnName,
            style: TextStyle(
              fontSize: widget.fontSize,
              fontFamily: "OpunMai",
              fontWeight: FontWeight.w700,
              color: widget.fontColor ?? Color.fromARGB(255, 62, 73, 101),
            ),
          ),
        ),
      ),
    );
  }
}