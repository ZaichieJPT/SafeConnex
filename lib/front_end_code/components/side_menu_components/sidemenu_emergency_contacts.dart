// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class EmergencyContacts extends StatefulWidget {
  final double height;
  final double width;

  const EmergencyContacts({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  State<EmergencyContacts> createState() => _EmergencyContactsState();
}

class _EmergencyContactsState extends State<EmergencyContacts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: const [
            Color.fromARGB(255, 221, 221, 221),
            Color.fromARGB(255, 241, 241, 241),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
