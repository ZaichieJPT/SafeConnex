import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonComponent extends StatefulWidget {
  ButtonComponent({super.key, required this.imageLocation, this.width, this.scale, this.margin});
  final String imageLocation;
  double? width;
  double? scale;
  EdgeInsetsGeometry? margin;

  @override
  State<ButtonComponent> createState() => _ButtonComponentState();
}

class _ButtonComponentState extends State<ButtonComponent> {
  @override
  Widget build(BuildContext context) {
    bool selected = false;
    return InkWell(
        onTap: (){print('test');},
        borderRadius: BorderRadius.circular(10),
        splashColor: Colors.blueGrey.withOpacity(0.5),
        child: Container(
            margin: widget.margin,
            width: widget.width,
            child: Image.asset(widget.imageLocation, scale: widget.scale,)
        )
    );
  }
}