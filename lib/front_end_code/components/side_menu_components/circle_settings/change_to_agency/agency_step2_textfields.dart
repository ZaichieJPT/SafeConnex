// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AgencyStep2TextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator? validator;
  const AgencyStep2TextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
  });

  @override
  State<AgencyStep2TextField> createState() => _AgencyStep2TextFieldState();
}

class _AgencyStep2TextFieldState extends State<AgencyStep2TextField> {
  bool showClearButton = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    //double width = MediaQuery.sizeOf(context).width;

    _getClearButton() {
      widget.controller.addListener(() {
        if (mounted) {
          setState(() {
            showClearButton = widget.controller.text.isNotEmpty;
          });
        }
      });
      if (showClearButton) {
        return widget.controller.text.isNotEmpty
            ? InkWell(
                onTap: () {
                  setState(() {
                    widget.controller.clear();
                  });
                },
                child: Icon(
                  Icons.cancel,
                  size: height * 0.025,
                  color: Colors.grey,
                ),
              )
            : null;
      }
      return null;
    }

    return TextFormField(
      controller: widget.controller,
      //validator: widget.validator,
      cursorColor: Colors.grey,
      style: TextStyle(
        fontFamily: 'OpunMai',
        fontWeight: FontWeight.w500,
        fontSize: height * 0.015,
        color: Colors.grey,
      ),
      decoration: InputDecoration(
        isDense: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontFamily: 'OpunMai',
          fontWeight: FontWeight.w500,
          fontSize: height * 0.015,
          color: Colors.grey,
        ),
        suffixIconConstraints: BoxConstraints(
          maxHeight: height,
        ),
        suffixIcon: _getClearButton(),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.5,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
