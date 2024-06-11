import 'package:flutter/material.dart';

class PageNavigator{
  PageNavigator(BuildContext context, Widget screen){
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}