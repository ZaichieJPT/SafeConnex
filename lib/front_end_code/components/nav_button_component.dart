import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_auth.dart';
import 'package:safeconnex/front_end_code/components/create_circle_component.dart';

class NavButtonComponent extends StatefulWidget {
  NavButtonComponent({super.key, required this.imageLocation, this.width, this.scale, this.margin, required this.route});
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
    bool selected = false;
    return InkWell(
        onTap: (){
          FirebaseAuthHandler firebaseAuthHandler = FirebaseAuthHandler();
          print("user");
          print(firebaseAuthHandler.authHandler.currentUser?.displayName!.toString());
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => widget.route)
          );
        },
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
