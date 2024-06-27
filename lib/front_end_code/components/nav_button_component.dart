import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavButtonComponent extends StatefulWidget {
  NavButtonComponent(
      {super.key,
        required this.imageLocation,
        this.width,
        this.scale,
        this.margin,
        required this.route});
  final String imageLocation;
  double? width;
  double? scale;
  EdgeInsetsGeometry? margin;
  Widget route;

  @override
  State<NavButtonComponent> createState() => _NavButtonComponentState();
}

class _NavButtonComponentState extends State<NavButtonComponent> {
  TextEditingController? textController;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    bool selected = false;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => widget.route),
          );
        },
        borderRadius: BorderRadius.circular(width),
        splashColor: Colors.white.withOpacity(0.2),
        child: Container(
          //color: const Color.fromARGB(105, 0, 0, 0),

          width: widget.width,
          child: Image.asset(
            widget.imageLocation,
          ),
        ),
      ),
    );
  }
}