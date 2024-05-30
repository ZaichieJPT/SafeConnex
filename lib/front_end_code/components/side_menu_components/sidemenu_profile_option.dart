// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ProfileOption extends StatefulWidget {
  final String optionText;
  final String image;
  final int index;
  final int selectedMenuIndex;
  final Function onTap;
  final Function onMenuTapped;

  const ProfileOption({
    super.key,
    required this.optionText,
    required this.image,
    required this.index,
    required this.selectedMenuIndex,
    required this.onTap,
    required this.onMenuTapped,
  });

  @override
  State<ProfileOption> createState() => _ProfileOptionState();
}

class _ProfileOptionState extends State<ProfileOption> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onMenuTapped(widget.index);
        widget.onTap.call();
      },
      child: Container(
        //height: height * 0.09,
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: widget.selectedMenuIndex == widget.index
              ? Colors.white
              : Color.fromARGB(255, 241, 241, 241),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Image.asset(
                widget.image,
              ),
            ),
            Expanded(
              flex: 8,
              child: Text(
                widget.optionText,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'OpunMai',
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 62, 73, 101),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
