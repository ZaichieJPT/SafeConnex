// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_database.dart';
import 'package:safeconnex/front_end_code/components/carousel_slider.dart';

class AgencyNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function onItemTapped;

  const AgencyNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  State<AgencyNavBar> createState() => _AgencyNavBarState();
}

class _AgencyNavBarState extends State<AgencyNavBar> {
  showCircleCards(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CarouseSliderComponent();
        });
  }

  SafeConnexAgencyDatabase agencyDatabase = SafeConnexAgencyDatabase();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Stack(
      children: [
        SizedBox(
          height: height * 0.12,
          child: Container(
            height: height * 0.12,
            width: width,
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

                      //HOME TAB
                      Expanded(
                        child: Material(
                          color: widget.selectedIndex == 0
                              ? Color.fromRGBO(237, 237, 237, 1.0)
                              : Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              widget.onItemTapped(0);
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: FractionallySizedBox(
                              heightFactor: 1,
                              widthFactor: 1,
                              child: FractionallySizedBox(
                                heightFactor: 0.70,
                                widthFactor: 0.42,
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
                          color: widget.selectedIndex == 1
                              ? Color.fromRGBO(237, 237, 237, 1.0)
                              : Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                widget.onItemTapped(1);
                              });
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: FractionallySizedBox(
                              heightFactor: 1,
                              widthFactor: 1,
                              child: FractionallySizedBox(
                                heightFactor: 0.70,
                                widthFactor: 0.42,
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
