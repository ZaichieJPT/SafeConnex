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
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: widget.backgroundImage,
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 170,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 280,
              width: 280,
              child: widget.pageImage,
            ),
          ),
        ],
      ),
    );
  }
}
