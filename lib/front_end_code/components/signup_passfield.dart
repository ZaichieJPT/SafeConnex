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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      //child: SizedBox(
      //alignment: AlignmentDirectional.center,
      //height: 27,
      //color: Colors.black,
      child: SizedBox(
        height: widget.height ?? 40, //widget.isValidated ? 40 :
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
