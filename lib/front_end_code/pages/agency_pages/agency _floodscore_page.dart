// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safeconnex/front_end_code/provider/agency_map_provider.dart';

class AgencyFloodScore extends StatefulWidget {
  const AgencyFloodScore({super.key});

  @override
  State<AgencyFloodScore> createState() => _AgencyFloodScoreState();
}

class _AgencyFloodScoreState extends State<AgencyFloodScore> {
  ScrollController placesScrollControl = ScrollController();

  double _sliderValue = 100.0;
  int _currentRiskIndex = -1;

  _onRiskLevelTapped(int index) {
    setState(() {
      if (_currentRiskIndex == index) {
        _currentRiskIndex = -1;
      } else {
        _currentRiskIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 71, 82, 98),
          leadingWidth: width * 0.15,
          toolbarHeight: height * 0.1,
          title: Text(
            'Safety Scoring',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'OpunMai',
              fontSize: height * 0.03,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              letterSpacing: 1,
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.only(left: height * 0.035),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              radius: 1,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color.fromARGB(255, 232, 220, 206),
                    width: 3,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 182, 176, 163),
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: FittedBox(
                  child: Text(
                    String.fromCharCode(Icons.west.codePoint),
                    style: TextStyle(
                      fontFamily: Icons.west.fontFamily,
                      fontSize: width * 0.055,
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 110, 101, 94),
                      package: Icons.west.fontPackage,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Center(
          child: SizedBox(
            height: height * 0.8,
            child: Column(
              children: [
                Flexible(
                  child: SingleChildScrollView(
                    reverse: true,
                    child: SizedBox(
                      height: height * 0.8,
                      child: Column(
                        children: [
                          //MAP VIEW

                          Container(
                            width: width,
                            height: height * 0.4,
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              border: Border.symmetric(
                                horizontal: BorderSide(
                                  color: Color.fromARGB(255, 173, 162, 153),
                                  width: 6,
                                ),
                              ),
                            ),
                            //child: NewMapProvider(),
                          ),
                          //SLIDER
                          Container(
                            height: height * 0.1,
                            width: width,
                            padding: EdgeInsets.only(
                                left: width * 0.02, right: width * 0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: SliderTheme(
                                    data: SliderThemeData(
                                      activeTickMarkColor: Colors.transparent,
                                      trackHeight: height * 0.0065,
                                      thumbShape: RoundSliderThumbShape(
                                        enabledThumbRadius: width * 0.045,
                                      ),
                                    ),
                                    child: Slider(
                                      value: _sliderValue,
                                      onChanged: (value) {
                                        setState(() {
                                          this._sliderValue = value;
                                        });
                                      },
                                      min: 50,
                                      max: 3000,
                                      divisions: 100,
                                      activeColor:
                                          Color.fromARGB(255, 70, 85, 104),
                                      inactiveColor:
                                          Color.fromARGB(255, 70, 85, 104),
                                      thumbColor: Colors.deepPurple[400],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.03,
                                ),
                                //RADIUS VALUE
                                Flexible(
                                  child: Text(
                                    '${_sliderValue.toStringAsFixed(1)} m zone',
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontFamily: 'OpunMai',
                                      fontSize: height * 0.013,
                                      color: Color.fromARGB(255, 70, 85, 104),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //LOCATION DETAILS HEADER
                          Container(
                            width: width,
                            height: height * 0.05,
                            color: Color.fromARGB(255, 232, 220, 206),
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: width * 0.05),
                            child: Text(
                              'Flood Risk Level',
                              style: TextStyle(
                                fontFamily: 'OpunMai',
                                fontSize: height * 0.022,
                                fontWeight: FontWeight.w700,
                                color: Color.fromARGB(255, 173, 162, 153),
                              ),
                            ),
                          ),
                          //LOCATION LABELS
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //LABEL TEXT
                                Flexible(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    padding:
                                        EdgeInsets.only(left: width * 0.05),
                                    child: FittedBox(
                                      child: Text(
                                        'Risk Level',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'OpunMai',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                          color:
                                              Color.fromARGB(255, 71, 82, 98),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                //LABEL TEXT FIELD
                                Flexible(
                                  flex: 3,
                                  child: Row(
                                    children: [
                                      //LOW STATUS
                                      Flexible(
                                        child: InkWell(
                                          onTap: () {
                                            _onRiskLevelTapped(0);
                                          },
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          child: Container(
                                            color: _currentRiskIndex == 0
                                                ? Colors.grey.shade300
                                                : Colors.transparent,
                                            child: Column(
                                              children: [
                                                //COLORED TILES
                                                Flexible(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      vertical: height * 0.005,
                                                      horizontal: width * 0.05,
                                                    ),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .yellowAccent
                                                            .shade200,
                                                        border: Border.all(
                                                          color: Color.fromARGB(
                                                              255, 71, 82, 98),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    width *
                                                                        0.01),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                //LOW
                                                Flexible(
                                                  child: FittedBox(
                                                    child: Text(
                                                      'Low',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontFamily: 'OpunMai',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 18,
                                                        color: Color.fromARGB(
                                                            255, 71, 82, 98),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      //MODERATE STATUS
                                      Flexible(
                                        child: InkWell(
                                          onTap: () {
                                            _onRiskLevelTapped(1);
                                          },
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          child: Container(
                                            color: _currentRiskIndex == 1
                                                ? Colors.grey.shade300
                                                : Colors.transparent,
                                            child: Column(
                                              children: [
                                                //COLORED TILES
                                                Flexible(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      vertical: height * 0.005,
                                                      horizontal: width * 0.05,
                                                    ),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .orange.shade400,
                                                        border: Border.all(
                                                          color: Color.fromARGB(
                                                              255, 71, 82, 98),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    width *
                                                                        0.01),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                //MODERATE
                                                Flexible(
                                                  child: FittedBox(
                                                    child: Text(
                                                      'Moderate',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontFamily: 'OpunMai',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 18,
                                                        color: Color.fromARGB(
                                                            255, 71, 82, 98),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      //HIGH STATUS
                                      Flexible(
                                        child: InkWell(
                                          onTap: () {
                                            _onRiskLevelTapped(2);
                                          },
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          child: Container(
                                            color: _currentRiskIndex == 2
                                                ? Colors.grey.shade300
                                                : Colors.transparent,
                                            child: Column(
                                              children: [
                                                //COLORED TILES
                                                Flexible(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      vertical: height * 0.005,
                                                      horizontal: width * 0.05,
                                                    ),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.red.shade700,
                                                        border: Border.all(
                                                          color: Color.fromARGB(
                                                              255, 71, 82, 98),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    width *
                                                                        0.01),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                //HIGH
                                                Flexible(
                                                  child: FittedBox(
                                                    child: Text(
                                                      'High',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontFamily: 'OpunMai',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 18,
                                                        color: Color.fromARGB(
                                                            255, 71, 82, 98),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //LOCATION LABEL TEXT FIELD
                                Flexible(
                                  flex: 4,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.1),
                                    child: Container(
                                      width: width,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color:
                                                Color.fromARGB(255, 71, 82, 98),
                                            width: 3.5,
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: width * 0.01,
                                          bottom: 5,
                                        ),
                                        child: Text(
                                          'Location Name',
                                          style: TextStyle(
                                            fontFamily: 'OpunMai',
                                            fontSize: height * 0.022,
                                            fontWeight: FontWeight.w700,
                                            color: Color.fromARGB(
                                                255, 173, 162, 153),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(
                //     bottom: MediaQuery.of(context).viewInsets.bottom,
                //   ),
                // ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: height * 0.1,
          color: Color.fromARGB(255, 71, 82, 98),
          child: Row(
            children: [
              //CANCEL BUTTON
              Expanded(
                child: Container(
                  height: height * 0.1,
                  color: Color.fromARGB(255, 81, 97, 112),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.cancel_outlined),
                    color: Color.fromARGB(255, 227, 230, 229),
                    iconSize: width * 0.125,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                  ),
                ),
              ),
              //EDIT || SAVE LOCATION BUTTON
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                  child: MaterialButton(
                    onPressed: () {},
                    elevation: 2,
                    height: height * 0.05,
                    color: const Color.fromARGB(255, 121, 192, 148),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(width * 0.2),
                    ),
                    child: Text(
                      'save',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'OpunMai',
                        fontSize: height * 0.025,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
