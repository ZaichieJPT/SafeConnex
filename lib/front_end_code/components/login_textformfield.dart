// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class LoginFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator? validator;
  final double? textMargin;
  final double? height;
  final double? verticalPadding;
  final double borderRadius;
  final String? errorText;

  const LoginFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.textMargin,
    this.height,
    this.verticalPadding,
    required this.borderRadius,
    this.errorText,
  });

  @override
  State<LoginFormField> createState() => _LoginFormFieldState();
}

class _LoginFormFieldState extends State<LoginFormField> {
  bool showClearButton = false;
  bool isValid = true;

  _getClearButton() {
    widget.controller.addListener(() {
      setState(() {
        showClearButton = widget.controller.text.isNotEmpty;
      });
    });
    if (showClearButton) {
      return SizedBox(
        width: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 25,
              height: 25,
              child: widget.controller.text.isNotEmpty
                  ? Container(
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                  //color: Colors.amber,
                  shape: BoxShape.circle,
                  //color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: FittedBox(
                  child: IconButton(
                    icon: Icon(Icons.cancel),
                    iconSize: 70,
                    alignment: AlignmentDirectional.center,
                    onPressed: () {
                      widget.controller.clear();
                    },
                  ),
                ),
              )
                  : null,
            ),
          ],
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      //child: SizedBox(
      //alignment: AlignmentDirectional.center,
      //height: 27,
      //color: Colors.black,
      child: Container(
        margin: EdgeInsets.only(right: widget.textMargin ?? 0),
        height: widget.height ?? 40, //widget.isValidated ? 40 :
        child: TextFormField(
          validator: widget.validator,
          controller: widget.controller,
          textAlignVertical: TextAlignVertical.center,
          cursorColor: Color.fromARGB(255, 175, 173, 173),
          maxLength: 55,
          style: TextStyle(
            fontSize: 12,
            fontFamily: "OpunMai",
          ),
          decoration: InputDecoration(
            //isDense: true,
            contentPadding: EdgeInsets.symmetric(
                vertical: widget.verticalPadding ?? 11, horizontal: 10),
            fillColor: Colors.white,
            filled: true,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Color.fromARGB(255, 175, 173, 173),
              fontSize: 12,
              height: 0.5,
            ),
            helperText: "",
            helperStyle: TextStyle(
              fontSize: 11,
              height: 0.05,
            ),
            errorStyle: TextStyle(
              fontSize: 11,
              height: 0.05,
            ),
            counterText: '',
            //floatingLabelStyle: TextStyle(color: Colors.black),
            suffixIcon: _getClearButton(),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            focusedErrorBorder: isValid
                ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: Colors.red,
                width: 1,
              ),
            )
                : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 175, 173, 173),
                width: 0.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),
      ),
      //),
    );
  }
}