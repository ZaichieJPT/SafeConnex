// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class LoginPassField extends StatefulWidget {
  final String hintText;
  final TextEditingController passController;
  final FormFieldValidator? validator;
  final void Function(String)? onChanged;
  final bool isValidated;
  final double? height;
  final double? verticalPadding;

  const LoginPassField({
    super.key,
    required this.hintText,
    required this.passController,
    this.validator,
    this.onChanged,
    required this.isValidated,
    this.height,
    this.verticalPadding,
  });

  @override
  State<LoginPassField> createState() => _LoginPassFieldState();
}

class _LoginPassFieldState extends State<LoginPassField> {
  bool obscureText = true;
  double height = 0;

  _getVisibleButton() {
    return InkWell(
      onTap: () {
        setState(() {
          obscureText = !obscureText;
        });
      },
      child: Container(
        padding: EdgeInsets.only(right: 15),
        child: Icon(
          obscureText ? Icons.visibility_off : Icons.visibility,
          size: height * 0.025,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      //child: SizedBox(
      //alignment: AlignmentDirectional.center,
      //height: 27,
      //color: Colors.black,
      child: SizedBox(
        height: widget.height ?? height * 0.05, //widget.isValidated ? 40 :
        child: TextFormField(
          validator: widget.validator,
          onChanged: widget.onChanged,
          controller: widget.passController,
          textAlignVertical: TextAlignVertical.center,
          obscureText: obscureText,
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

            suffixIcon: _getVisibleButton(),
            suffixIconConstraints: BoxConstraints(maxHeight: height * 0.5),
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
          //autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ),
      //),
    );
  }
}