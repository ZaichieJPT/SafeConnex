// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({
    super.key,
    required this.backgroundImage,
    required this.pageImage,
  });

  final AssetImage backgroundImage;
  final Image pageImage;

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: widget.backgroundImage,
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: height * 0.2,
          ),
          Flexible(
            flex: 5,
            child: SizedBox(
              width: width * 0.8,
              child: widget.pageImage,
            ),
          ),
          SizedBox(
            height: height * 0.45,
          ),
        ],
      ),
    );
  }
}
