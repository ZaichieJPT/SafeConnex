// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class HomeBottomNavBar extends StatefulWidget {
  final double height;
  final double width;
  final int selectedIndex;
  final Function onItemTapped;

  const HomeBottomNavBar({
    super.key,
    required this.height,
    required this.width,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  State<HomeBottomNavBar> createState() => _HomeBottomNavBarState();
}

class _HomeBottomNavBarState extends State<HomeBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: widget.height * 0.12,
          child: Container(
            height: widget.height * 0.12,
            width: widget.width,
            color: Colors.white,
            child: Column(
              children: [
                Flexible(
                  flex: 10,
                  //Row Container for the 3 tabs
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //CIRCLE TAB
                      Expanded(
                        child: Material(
                          color: widget.selectedIndex == 0
                              ? Color.fromRGBO(237, 237, 237, 1.0)
                              : Colors.transparent,
                          child: InkWell(
                            onTap: () => widget.onItemTapped(0),
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: FractionallySizedBox(
                              heightFactor: 1,
                              widthFactor: 1,
                              child: FractionallySizedBox(
                                heightFactor: 0.70,
                                widthFactor: 0.6,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade300,
                                    borderRadius: BorderRadius.circular(9),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.green.shade300,
                                        spreadRadius: 0.1,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "CIRCLE",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: "OpunMai",
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 0.6,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.green.shade100,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(9),
                                              bottomRight: Radius.circular(9),
                                            ),
                                          ),
                                          child: FractionallySizedBox(
                                            widthFactor: 1,
                                            child: Image.asset(
                                              'assets/images/circle_icon.png',
                                              scale: 8,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      //HOME TAB
                      Expanded(
                        child: Material(
                          color: widget.selectedIndex == 1
                              ? Color.fromRGBO(237, 237, 237, 1.0)
                              : Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              widget.onItemTapped(1);
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: FractionallySizedBox(
                              heightFactor: 1,
                              widthFactor: 1,
                              child: FractionallySizedBox(
                                heightFactor: 0.70,
                                widthFactor: 0.6,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 234, 176, 50),
                                    borderRadius: BorderRadius.circular(9),
                                    boxShadow: const [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 234, 176, 50),
                                        spreadRadius: 0.1,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "HOME",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: "OpunMai",
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 0.6,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 251, 218, 148),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(9),
                                              bottomRight: Radius.circular(9),
                                            ),
                                          ),
                                          child: FractionallySizedBox(
                                            widthFactor: 1,
                                            child: Image.asset(
                                              'assets/images/home_icon.png',
                                              scale: 8,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      //FEED TAB
                      Expanded(
                        flex: 1,
                        child: Material(
                          color: widget.selectedIndex == 2
                              ? Color.fromRGBO(237, 237, 237, 1.0)
                              : Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                widget.onItemTapped(2);
                              });
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: FractionallySizedBox(
                              heightFactor: 1,
                              widthFactor: 1,
                              child: FractionallySizedBox(
                                heightFactor: 0.70,
                                widthFactor: 0.6,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 132, 151, 148),
                                    borderRadius: BorderRadius.circular(9),
                                    boxShadow: const [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 132, 151, 148),
                                        spreadRadius: 0.1,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "FEED",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: "OpunMai",
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 0.6,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 177, 206, 246),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(9),
                                              bottomRight: Radius.circular(9),
                                            ),
                                          ),
                                          child: FractionallySizedBox(
                                            widthFactor: 1,
                                            child: Image.asset(
                                              'assets/images/feed_icon.png',
                                              scale: 8,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    color: Color.fromRGBO(237, 237, 237, 1.0),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    color: Color.fromRGBO(117, 117, 119, 1.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
