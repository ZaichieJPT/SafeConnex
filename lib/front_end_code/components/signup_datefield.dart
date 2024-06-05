// ignore_for_file: prefer_const_constructors

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class SignupDateField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator? validator;
  //final void Function(String)? onChanged;
  final double? textMargin;
  final double? height;
  final double? verticalPadding;

  const SignupDateField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    //this.onChanged,
    this.textMargin,
    this.height,
    this.verticalPadding,
  });

  @override
  State<SignupDateField> createState() => _SignupDateFieldState();
}

class _SignupDateFieldState extends State<SignupDateField> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      //child: SizedBox(
      //alignment: AlignmentDirectional.center,
      //height: 27,
      //color: Colors.black,
      child: Container(
        margin: EdgeInsets.only(right: widget.textMargin ?? 0),
        height: widget.height ?? height * 0.05, //widget.isValidated ? 40 :
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
            suffixIcon: Icon(
              Icons.calendar_month_outlined,
              size: height * 0.03,
            ),
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
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 175, 173, 173),
                width: 0.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          onTap: () async {
            DateTime? datePicked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
            if (datePicked != null) {
              setState(() {
                widget.controller.text =
                    DateFormat('yMMMMd').format(datePicked);
              });
            }
          },
        ),
      ),
      //),
    );
  }
}
