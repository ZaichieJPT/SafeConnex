import 'package:flutter/material.dart';

class LocationList extends StatefulWidget {
  const LocationList({super.key, required this.text});
  final String text;

  @override
  State<LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 10),
      child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10, top: 10),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.brown.shade100,
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Icon(
                      Icons.location_pin,
                      size: 35,
                      color: Colors.blueGrey.shade800,
                    ),
                  ),
                  SizedBox(width: 20,),
                  Text(
                    "${widget.text}",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.blueGrey.shade800,
                        fontWeight: FontWeight.w400
                    ),
                  )
                ],
              ),
            ),
          ]
      ),
    );
  }
}

