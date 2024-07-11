// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_authentication.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_circle_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_location_history.dart';

class LocationHistory extends StatefulWidget {
  const LocationHistory({super.key, required this.userId, required this.userName});

  final String userId;
  final String userName;
  @override
  State<LocationHistory> createState() => _LocationHistoryState();
}

class _LocationHistoryState extends State<LocationHistory> {
  String _currentMemberName = '';
  final ScrollController _membersScrollController = ScrollController();
  double height = 0;
  double width = 0;
  int _currentPointIndex = -1;

  final List<String> _circleMembers2 = [
    'Garry',
    'Alliah',
    'Riri',
    'Tri',
    'Mallows',
    'Imaw',
  ];

  final List<Map<String, dynamic>> _circleMembers = DependencyInjector().locator<SafeConnexCircleDatabase>().circleUsersNames;
  final _locationHistory = DependencyInjector().locator<SafeConnexLocationHistory>().locationHistoryData;

  final List<Map<String, String>> _locationHistory2 = [
    {
      'location': 'At Gym',
      'time': '8:05 am',
      'date': 'June 12, 2024',
    },
    {
      'location': 'At School',
      'time': '7:30 am',
      'date': 'June 14, 2024',
    },
    {
      'location': 'Near Perez Blvd.',
      'time': '5:05 pm',
      'date': 'June 14, 2024',
    },
    {
      'location': 'At Gym',
      'time': '7:05 am',
      'date': 'June 15, 2024',
    },
    {
      'location': 'At Home',
      'time': '10:00 am',
      'date': 'June 15, 2024',
    },
    {
      'location': 'Near WC48+83',
      'time': '6:05 pm',
      'date': 'June 15, 2024',
    },
    {
      'location': 'Near Calasiao-Dagupan Rd.',
      'time': '7:55 pm',
      'date': 'June 15, 2024',
    },
    {
      'location': 'Near Camiling-Bayambang Rd.',
      'time': '8:15 pm',
      'date': 'June 15, 2024',
    },
    {
      'location': 'At Home',
      'time': '8:35 pm',
      'date': 'June 15, 2024',
    },
    {
      'location': 'At Schoolcashxihuhawu',
      'time': '9:24 am',
      'date': 'June 16, 2024',
    },
  ];

  final Map<int, String> _pointNumber = {
    1: 'I',
    2: 'II',
    3: 'III',
    4: 'IV',
    5: 'V',
    6: 'VI',
    7: 'VII',
    8: 'VIII',
    9: 'IX',
    10: 'X',
  };

  @override
  void dispose() {
    _membersScrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    DependencyInjector().locator<SafeConnexLocationHistory>().getDataFromLocationHistory(widget.userId);
    _currentMemberName = widget.userName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    var _points = [
      Offset(width * 0.21, height * 0.038),
      Offset(width * 0.57, height * 0.039),
      Offset(width * 0.66, height * 0.17),
      Offset(width * 0.305, height * 0.17),
      Offset(width * 0.1, height * 0.28),
      Offset(width * 0.47, height * 0.32),
      Offset(width * 0.74, height * 0.39),
      Offset(width * 0.525, height * 0.48),
      Offset(width * 0.18, height * 0.48),
      Offset(width * 0.13, height * 0.6),
    ];

    List<Map<String, dynamic>> _textPositions = [
      {
        'offset': Offset(width * 0.12, height * 0.095),
        'alignment': Alignment.centerRight,
        'textalign': TextAlign.right,
      },
      {
        'offset': Offset(width * 0.25, height * 0.23),
        'alignment': Alignment.centerLeft,
        'textalign': TextAlign.left,
      },
      {
        'offset': Offset(width * 0.12, height * 0.39),
        'alignment': Alignment.centerRight,
        'textalign': TextAlign.right,
      },
      {
        'offset': Offset(width * 0.25, height * 0.54),
        'alignment': Alignment.centerLeft,
        'textalign': TextAlign.left,
      },
    ];

    final _currentTextPosition = !_currentPointIndex.isNegative
        ? _textPositions[(_currentPointIndex / 3).floor()]
        : _textPositions[0];

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 70, 86, 101),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 70, 86, 101),
        leadingWidth: width * 0.15,
        toolbarHeight: height * 0.075,
        actions: [
          //MEMBERS BUTTON
          Padding(
            padding: EdgeInsets.only(
              right: width * 0.05,
              top: height * 0.018,
              bottom: height * 0.018,
            ),
            child: InkWell(
              onTap: () {
                //Navigator.pop(context);
              },
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Container(
                alignment: Alignment.center,
                width: width * 0.087,
                //padding: EdgeInsets.symmetric(horizontal: width * 0.013),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width * 0.035),
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
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/history_members_icon.png',
                    ),
                    scale: width * 0.007,
                  ),
                ),
                child: PopupMenuButton<String>(
                  iconSize: width * 0.087,
                  iconColor: Colors.transparent,
                  onSelected: (value) {
                    DependencyInjector().locator<SafeConnexLocationHistory>().locationHistoryData.clear();
                    DependencyInjector().locator<SafeConnexLocationHistory>().getDataFromLocationHistory(value);

                    setState(() {});
                  },
                  onCanceled: () {
                    setState(() {
                      // _isMoreClicked[index] = !_isMoreClicked[index];
                    });
                  },
                  onOpened: () {
                    setState(() {
                      // _isMoreClicked[index] = !_isMoreClicked[index];
                    });
                  },
                  position: PopupMenuPosition.under,
                  color: Colors.white,
                  surfaceTintColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(width * 0.03),
                    side: BorderSide(
                      color: Color.fromARGB(255, 114, 112, 106),
                      width: 2,
                    ),
                  ),
                  constraints: BoxConstraints(
                    maxWidth: width * 0.35,
                  ),
                  itemBuilder: (context) => [
                    //CIRCLE MEMBERS DROPDOWN LIST
                    PopupMenuItem<String>(
                      child: ConstrainedBox(
                        //height: height * 0.5,
                        constraints: BoxConstraints(
                          maxHeight: height * 0.2,
                          //maxWidth: width * 0.225,
                        ),
                        child: Scrollbar(
                          controller: _membersScrollController,
                          radius: Radius.circular(2),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                for (var member in _circleMembers)
                                  PopupMenuItem<String>(
                                    padding: EdgeInsets.symmetric(
                                      vertical: height * 0.007,
                                    ),
                                    height: 0,
                                    value: member["id"],
                                    onTap: () {
                                      setState(() {
                                        _currentMemberName = member["name"];
                                      });
                                    },
                                    child: Center(
                                      child: Container(
                                        width: width * 0.25,
                                        height: height * 0.035,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 182, 176, 163),
                                          borderRadius: BorderRadius.circular(
                                              width * 0.012),
                                        ),
                                        child: Text(
                                          member["name"],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: 'OpunMai',
                                            fontSize: width * 0.035,
                                            color:
                                                Color.fromARGB(255, 82, 80, 76),
                                          ),
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
                  ],
                ),
              ),
            ),
          ),
        ],
        title: Text(
          'Location History',
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'OpunMai',
            fontSize: height * 0.027,
            fontWeight: FontWeight.w400,
            color: Colors.white,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        //BACK BUTTON
        leading: Padding(
          padding: EdgeInsets.only(
            left: width * 0.065,
            top: height * 0.018,
            bottom: height * 0.018,
          ),
          child: InkWell(
            onTap: () {
              DependencyInjector().locator<SafeConnexLocationHistory>().locationHistoryData.clear();
              Navigator.pop(context);
            },
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(width * 0.035),
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
      body: Stack(
        alignment: Alignment.center,
        children: [
          //BACKGROUND
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(
              top: height * 0.025,
              bottom: height * 0.01,
              left: width * 0.04,
              right: width * 0.04,
            ),
            child: Image.asset(
              'assets/images/location_history_bg.png',
              width: width,
              fit: BoxFit.fill,
            ),
          ),
          //BANNER CONTAINER
          Positioned(
            top: 0,
            child: Container(
              height: height * 0.085,
              width: width * 0.75,
              decoration: BoxDecoration(
                //color: Color.fromARGB(143, 158, 158, 158),
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/location_history_banner.png',
                  ),
                  scale: width * 0.007,
                  fit: BoxFit.fill,
                  alignment: Alignment.center,
                ),
              ),
              //NAME CONTAINER
              child: Padding(
                padding: EdgeInsets.only(bottom: height * 0.02),
                child: Container(
                  height: height * 0.01,
                  width: width,
                  alignment: Alignment.center,
                  //color: const Color.fromARGB(112, 33, 149, 243),
                  child: FittedBox(
                    child: Text(
                      _currentMemberName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'OpunMai',
                        fontSize: 25,
                        color: Color.fromARGB(255, 82, 80, 76),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          //BANNER & NAME CONTAINER
          Positioned(
            top: height * 0.085,
            child: Container(
              height: height,
              width: width,
              //color: const Color.fromARGB(89, 244, 67, 54),
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: height * 0.215,
                  left: width * 0.07,
                  right: width * 0.07,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    //PATH BACKGROUND
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.04,
                        bottom: height * 0.08,
                        left: width * 0.01,
                        right: width * 0.02,
                      ),
                      child: Container(
                        width: width,
                        decoration: BoxDecoration(
                            //color: const Color.fromARGB(108, 244, 67, 54),
                            ),
                        child: Image.asset(
                          'assets/images/history_path_bg.png',
                          width: width * 0.2,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    //LOCATION POINTS TEMPLATE
                    for (int i = 0; i < 10; i++) ...[
                      Positioned(
                        top: _points[i].dy,
                        left: _points[i].dx,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (_currentPointIndex == i) {
                                _currentPointIndex = -1;
                              } else {
                                _currentPointIndex = i;
                              }
                            });
                          },
                          child: Container(
                            height: height * 0.05,
                            width: height * 0.05,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: _currentPointIndex == i
                                  ? Colors.white
                                  : Color.fromARGB(255, 239, 227, 213),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color.fromARGB(255, 114, 112, 106),
                                width: 1.5,
                              ),
                            ),
                            child: FittedBox(
                              child: Text(
                                _pointNumber[i + 1]!,
                                style: TextStyle(
                                  fontFamily: 'Merriweather',
                                  fontWeight: FontWeight.w700,
                                  fontSize: height * 0.025,
                                  color: Color.fromARGB(255, 114, 112, 106),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      !_currentPointIndex.isNegative
                          ?
                          //TEXT POSITIONS
                          Visibility(
                              visible: _currentPointIndex == i,
                              child: Positioned(
                                top: _currentTextPosition['offset'].dy,
                                left: _currentTextPosition['offset'].dx,
                                child: Container(
                                  height: height * 0.07,
                                  width: width * 0.57,
                                  alignment: _currentTextPosition['alignment'],
                                  //color: Colors.white,
                                  child: Column(
                                    children: [
                                      //LOCATION INFO
                                      Flexible(
                                        flex: 2,
                                        child: Container(
                                          alignment:
                                              _currentTextPosition['alignment'],
                                          //color: Colors.white,
                                          child: Tooltip(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      width * 0.015),
                                              border: Border.all(
                                                color: Color.fromARGB(
                                                    255, 114, 112, 106),
                                                width: 2,
                                              ),
                                            ),
                                            textAlign: TextAlign.center,
                                            textStyle: TextStyle(
                                              fontFamily: 'Merriweather',
                                              fontWeight: FontWeight.w900,
                                              fontSize: 12,
                                              color: Color.fromARGB(
                                                  255, 82, 80, 76),
                                            ),
                                            preferBelow: false,
                                            message:
                                            _locationHistory.length > _currentPointIndex ? '${_locationHistory[_currentPointIndex]['location']!}' : "No History",
                                            child: FittedBox(
                                              child: Text(
                                                _locationHistory.length > _currentPointIndex ? '${_locationHistory[_currentPointIndex]['location']!}' : "No History",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontFamily: 'Merriweather',
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 82, 80, 76),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      //TIME AND DATE
                                      Flexible(
                                        flex: 3,
                                        child: Container(
                                          alignment:
                                              _currentTextPosition['alignment'],
                                          child: FittedBox(
                                            child: Text(
                                              _locationHistory.length > _currentPointIndex ? '${_locationHistory[_currentPointIndex]['time']!}\n${_locationHistory[_currentPointIndex]['date']!}' : "No History",
                                              textAlign: _currentTextPosition[
                                                  'textalign'],
                                              style: TextStyle(
                                                fontFamily: 'Merriweather',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: Color.fromARGB(
                                                    255, 82, 80, 76),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container()
                    ],

                    //CURRENT LOCATION CIRCLE
                    Positioned(
                      top: height * 0.66,
                      child: Container(
                        height: height * 0.065,
                        width: height * 0.065,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color.fromARGB(255, 118, 18, 18),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                    //CURRENT LOCATION PIN
                    Positioned(
                      bottom: height * 0.07,
                      child: Container(
                        height: width * 0.2,
                        width: width * 0.13,
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(
                          left: width * 0.015,
                          right: width * 0.015,
                          top: width * 0.033,
                        ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/history_pin_icon.png',
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: Image.asset(
                          'assets/images/male_profile.png',
                        ),
                      ),
                    ),
                    //CURRENT LOCATION
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: height * 0.06,
                        width: width * 0.65,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.01,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Color.fromARGB(255, 82, 80, 80),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: Tooltip(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(width * 0.015),
                                  border: Border.all(
                                    color: Color.fromARGB(255, 114, 112, 106),
                                    width: 1.5,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                                textStyle: TextStyle(
                                  fontFamily: 'Merriweather',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 82, 80, 76),
                                ),
                                preferBelow: false,
                                message: 'At Home',
                                child: FittedBox(
                                  child: Text(
                                    'At Home',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Merriweather',
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                      shadows: const [
                                        Shadow(
                                          color:
                                              Color.fromARGB(100, 82, 80, 80),
                                          blurRadius: 7,
                                        ),
                                      ],
                                      color: Color.fromARGB(255, 82, 80, 80),
                                      letterSpacing: 0.6,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //CURRENT LOCATION DATE AND TIME
                            Flexible(
                              child: FittedBox(
                                child: Text(
                                  'Since 1:00 pm, June 16, 2024',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Merriweather',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11.5,
                                    shadows: const [
                                      Shadow(
                                        color: Color.fromARGB(100, 82, 80, 80),
                                        blurRadius: 7,
                                      ),
                                    ],
                                    color: Color.fromARGB(255, 82, 80, 80),
                                    letterSpacing: 0.6,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
