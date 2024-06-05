// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class CircleListTile extends StatefulWidget {
  final String title;
  final Function() onTap;

  const CircleListTile({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  State<CircleListTile> createState() => _CircleListTileState();
}

class _CircleListTileState extends State<CircleListTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: ListTile(
        title: Container(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 123, 123, 123),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            widget.title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'OpunMai',
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
