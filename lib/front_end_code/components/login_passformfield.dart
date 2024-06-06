// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PassFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController passController;
  final FormFieldValidator? validator;
  final void Function(String)? onChanged;
  final bool isValidated;
  final double? textMargin;
  final double? height;
  final double? verticalPadding;
  final double? fontSize;

  const PassFormField({
    super.key,
    required this.hintText,
    required this.passController,
    this.validator,
    this.onChanged,
    required this.isValidated,
    this.textMargin,
    this.height,
    this.verticalPadding,
    this.fontSize,
  });

  @override
  State<PassFormField> createState() => _PassFormFieldState();
}

class _PassFormFieldState extends State<PassFormField> {
  bool obscureText = true;

  _getVisibleButton() {
    return SizedBox(
      width: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 25,
            height: 25,
            child: Container(
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                //color: Colors.amber,
                shape: BoxShape.circle,
                //color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: FittedBox(
                child: IconButton(
                  icon: obscureText
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                  iconSize: 70,
                  alignment: AlignmentDirectional.center,
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        //color: Colors.blue,
        margin: EdgeInsets.only(right: widget.textMargin ?? 10),
        alignment: AlignmentDirectional.center,
        //height: widget.height.toString().isEmpty ? 30 : widget.height,
        child: TextFormField(
          maxLength: 55,
          validator: widget.validator,
          onChanged: widget.onChanged,
          textAlignVertical: TextAlignVertical.center,
          controller: widget.passController,
          obscureText: obscureText,
          cursorColor: Color.fromARGB(255, 175, 173, 173),
          style: TextStyle(
            fontSize: 12,
            fontFamily: "OpunMai",
          ),
          decoration: InputDecoration(
            //isCollapsed: widget.height.toString().isEmpty ? true : true,
            contentPadding: EdgeInsets.symmetric(
              //vertical: widget.verticalPadding ?? 5,
              horizontal: 10,
            ),
            fillColor: Colors.white,
            filled: true,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Color.fromARGB(255, 175, 173, 173),
              fontSize: 12,
            ),
            helperText: "",
            helperStyle: TextStyle(
              fontSize: widget.fontSize ?? 11,
              height: 0.05,
              decorationColor: Colors.black,
            ),
            errorStyle: TextStyle(
              fontSize: 11,
              height: 0.05,
            ),

            counterText: '',
            suffixIcon: _getVisibleButton(),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 175, 173, 173),
                width: 0.0,
              ),
              borderRadius: BorderRadius.circular(7),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        ),
      ),
    );
  }
}
