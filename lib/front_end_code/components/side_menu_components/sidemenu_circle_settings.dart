// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_authentication.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_circle_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_scoring_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_storage.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/circle_settings/circlesettings_leavecircle_dialog.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/circle_settings/circlesettings_info_carousel.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:safeconnex/front_end_code/pages/circle_pages/circle_editname_page.dart';
import 'package:safeconnex/front_end_code/pages/circle_pages/circle_viewcode_page.dart';

class CircleSettings extends StatefulWidget {
  final double height;
  final double width;

  const CircleSettings({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  State<CircleSettings> createState() => _CircleSettingsState();
}

class _CircleSettingsState extends State<CircleSettings> {
  TextEditingController _roleController = TextEditingController();
  int _currentCircleIndex = 0;
  int _viewEditIndex = 3;
  int _memberIndex = 11;
  String memberName = '';
  String memberId = '';
  bool _locationStatus = false;
  bool _isMyRoleTapped = false;
  //SafeConnexCircleDatabase circleDatabase = SafeConnexCircleDatabase();

  final List<Map<String, dynamic>> circleDataList = [
    {
      'circleName': 'Office',
      'names': ['John', 'Joshua'],
    },
    {
      'circleName': 'Friends',
      'names': ['Ross', 'Chandler', 'Joey', 'Rachel', 'Phoebe', 'Monica'],
    },
    {
      'circleName': 'Family',
      'names': ['Garry', 'Alliah'],
    },
  ];

  void _previousCircle() {
    if (_currentCircleIndex > 0) {
      setState(() {
        _currentCircleIndex--;
        _memberIndex = 11;
      });
    }
  }

  void _nextCircle() {
    if (_currentCircleIndex < DependencyInjector().locator<SafeConnexCircleDatabase>().circleDataList.length - 1 ) {
      setState(() {
        _currentCircleIndex++;
        _memberIndex = 11;
      });
    }
  }

  void updateState(){
    setState(() {

    });
  }

  @override
  void initState() {
    _roleController.text = 'Circle Creator';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final currentCircleData = circleDataList[_currentCircleIndex];
    final currentCircleData = DependencyInjector().locator<SafeConnexCircleDatabase>().circleDataList[_currentCircleIndex];
    DependencyInjector().locator<SafeConnexCircleDatabase>().currentCircleCode = currentCircleData["circleCode"];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //PREVIOUS / CIRCLE NAME / NEXT BUTTON
              Padding(
                padding: EdgeInsets.fromLTRB(
                  widget.width * 0.02,
                  widget.height * 0.01,
                  widget.width * 0.02,
                  0,
                  //widget.height * 0.01,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //PREVIOUS BUTTON
                    Flexible(
                      child: IconButton(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.zero,
                        onPressed: _currentCircleIndex == 0
                            ? () {
                          setState(() {
                            _currentCircleIndex = DependencyInjector().locator<SafeConnexCircleDatabase>().circleDataList.length - 1;
                          });
                        }
                            : _previousCircle,
                        icon: Text(
                          String.fromCharCode(Icons.arrow_back_ios.codePoint),
                          style: TextStyle(
                            color: Color.fromARGB(255, 70, 85, 104),
                            fontFamily: Icons.arrow_back_ios.fontFamily,
                            fontWeight: FontWeight.w900,
                            fontSize: widget.height * 0.035,
                          ),
                        ),
                      ),
                    ),
                    //CIRCLE NAME
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: widget.width * 0.02),
                        child: Text(
                          currentCircleData['circleName'],
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'OpunMai',
                            fontSize: widget.height * 0.03,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 70, 85, 104),
                          ),
                        ),
                      ),
                    ),
                    //NEXT BUTTON
                    Flexible(
                      child: IconButton(
                        alignment: Alignment.center,
                        padding: EdgeInsets.zero,
                        onPressed: _currentCircleIndex == DependencyInjector().locator<SafeConnexCircleDatabase>().circleDataList.length - 1
                            ? () {
                          setState(() {
                            _currentCircleIndex = 0;
                          });
                        }
                            : _nextCircle,
                        iconSize: widget.height * 0.035,
                        icon: Text(
                          String.fromCharCode(Icons.arrow_forward_ios.codePoint),
                          style: TextStyle(
                            color: Color.fromARGB(255, 70, 85, 104),
                            fontFamily: Icons.arrow_forward_ios.fontFamily,
                            fontWeight: FontWeight.w900,
                            fontSize: widget.height * 0.035,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //VIEW AND EDIT BUTTON
              Flexible(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(bottom: widget.height * 0.005),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //VIEW BUTTON
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewCircleCode()));
                          setState(() {
                            if (_viewEditIndex == 0) {
                              _viewEditIndex = 3;
                            } else {
                              _viewEditIndex = 0;
                            }
                          });
                        },
                        child: Container(
                          height: widget.height * 0.032,
                          width: widget.width * 0.27,
                          alignment: Alignment.center,
                          padding:
                          EdgeInsets.symmetric(horizontal: widget.width * 0.01),
                          decoration: BoxDecoration(
                            color: _viewEditIndex == 0
                                ? Color.fromARGB(255, 70, 85, 104)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                              width: 2,
                              color: Color.fromARGB(255, 70, 85, 104),
                            ),
                          ),
                          child: FittedBox(
                            child: Text(
                              'view circle code',
                              style: TextStyle(
                                fontWeight: _viewEditIndex == 0
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: _viewEditIndex == 0
                                    ? Colors.white
                                    : Color.fromARGB(255, 70, 85, 104),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //SPACER
                      SizedBox(
                        width: widget.width * 0.05,
                      ),
                      //EDIT BUTTON
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditCircleName()));
                          setState(() {
                            if (_viewEditIndex == 1) {
                              _viewEditIndex = 3;
                            } else {
                              _viewEditIndex = 1;
                            }
                          });
                        },
                        child: Container(
                          height: widget.height * 0.032,
                          width: widget.width * 0.27,
                          alignment: Alignment.center,
                          padding:
                          EdgeInsets.symmetric(horizontal: widget.width * 0.01),
                          decoration: BoxDecoration(
                            color: _viewEditIndex == 1
                                ? Color.fromARGB(255, 70, 85, 104)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                              width: 2,
                              color: Color.fromARGB(255, 70, 85, 104),
                            ),
                          ),
                          child: FittedBox(
                            child: Text(
                              'edit circle name',
                              style: TextStyle(
                                fontWeight: _viewEditIndex == 1
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: _viewEditIndex == 1
                                    ? Colors.white
                                    : Color.fromARGB(255, 70, 85, 104),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //CIRCLE MEMBERS TITLE
              Flexible(
                flex: 3,
                child: Container(
                  height: widget.height * 0.05,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: widget.width * 0.05),
                  //color: Colors.blue,
                  child: FittedBox(
                    child: Text(
                      'Circle Members:',
                      style: TextStyle(
                        fontFamily: 'OpunMai',
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 120, 120, 120),
                        fontSize: widget.height * 0.022,
                      ),
                    ),
                  ),
                ),
              ),
              //GRIDVIEW CIRCLE MEMBERS
              Flexible(
                flex: 9,
                child: SizedBox(
                  /*
                  height: currentCircleData['names'].length > 5
                      ? widget.height * 0.20
                      : (widget.height * 0.20) / 2,
                  */
                  height: widget.height * 0.20,
                  width: widget.width * 0.77,
                  //color: Colors.black,
                  child: LayoutBuilder(builder: (context, constraints) {
                    double innerHeight = constraints.maxHeight;
                    double innerWidth = constraints.maxWidth;

                    return GridView.builder(
                      itemCount: currentCircleData['names'].length,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        childAspectRatio: 0.9,
                      ),
                      //CIRCLE MEMBER TILE
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              if (_memberIndex == index) {
                                _memberIndex = 11;
                                memberName = '';
                              } else {
                                _memberIndex = index;
                                memberName = currentCircleData['names'][index];
                                // Call a code that updates the current clicked ID
                                memberId = currentCircleData['userIds'][index];
                                print(memberId);
                                print(memberName);
                              }
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              //horizontal: 5,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: _memberIndex == index
                                  ? Colors.white
                                  : Colors.grey[300],
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //PROFILES IMAGES
                                Flexible(
                                  flex: 2,
                                  child: CircleAvatar(
                                    radius: innerWidth * 0.07,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: innerWidth * 0.06,
                                      backgroundColor:
                                      const Color.fromARGB(255, 128, 95, 166),
                                      foregroundColor: Colors.white,
                                      child: DependencyInjector().locator<SafeConnexProfileStorage>()
                                          .imageUrl !=
                                          null
                                          ? Image.network(
                                          DependencyInjector().locator<SafeConnexProfileStorage>()
                                              .imageUrl!)
                                          : Container(color: Colors.white),
                                    ),
                                  ),
                                ),
                                //MEMBERS
                                Flexible(
                                  child: Container(
                                    //color: Colors.blue,
                                    width: innerWidth * 0.15,
                                    height: innerHeight * 0.4,
                                    alignment: Alignment.center,
                                    child: Text(
                                      currentCircleData['names'][index],
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Color.fromARGB(255, 70, 85, 104),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ),
              //REMOVE MEMBER BUTTON
              Flexible(
                flex: 2,
                child: DependencyInjector().locator<SafeConnexCircleDatabase>().currentRole == "Circle Creator" && memberId != DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.uid ? ElevatedButton(
                  onPressed: () {
                    //TOAST THAT WILL DISPLAY THAT THE MEMBER HAS BEEN REMOVED
                    if (memberName != '') {
                      showToast(
                        '$memberName has been removed\nfrom the circle.',
                        textStyle: TextStyle(
                          fontFamily: 'OpunMai',
                          fontWeight: FontWeight.w600,
                          fontSize: widget.height * 0.015,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        context: context,
                        backgroundColor: Color.fromARGB(200, 239, 83, 80),
                        position: StyledToastPosition.center,
                        borderRadius: BorderRadius.circular(10),
                        duration: Duration(milliseconds: 4000),
                        animation: StyledToastAnimation.fade,
                        reverseAnimation: StyledToastAnimation.fade,
                        fullWidth: true,
                      );
                      DependencyInjector().locator<SafeConnexCircleDatabase>().removeFromCircle(memberId, currentCircleData["circleCode"]);
                      setState(() {
                        //circleDatabase.listCircleDataForSettings(SafeConnexAuthentication.currentUser!.uid);
                        _memberIndex = 11;
                        memberName = '';
                      });
                    }
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 104, 168, 132),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 119, 194, 152),
                    ),
                  ),
                  child: FittedBox(
                    child: Text(
                      'Remove Circle Member',
                      style: TextStyle(
                        fontFamily: 'OpunMai',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        letterSpacing: -0.05,
                      ),
                    ),
                  ),
                ) : Container(),
              ),
              //SETTINGS INFO CAROUSEL
              Expanded(
                flex: 8,
                child: Container(
                  height: widget.height * 0.18,
                  //color: Colors.white,
                  child: InfoCarousel(
                    height: widget.height,
                    width: widget.width,
                  ),
                ),
              ),
              //MY ROLE / EDIT BUTTON
              Flexible(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: widget.width * 0.33,
                      height: widget.height * 0.05,
                      //color: Colors.white,
                      child: Text(
                        'My Role',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'OpunMai',
                          fontWeight: FontWeight.w700,
                          fontSize: widget.height * 0.023,
                          color: Color.fromARGB(255, 120, 120, 120),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      width: widget.width * 0.33,
                      height: widget.height * 0.045,
                      //color: Colors.white,
                      child: IconButton(
                        padding: EdgeInsets.symmetric(
                            vertical: widget.width * 0.01, horizontal: 0),
                        tooltip: 'Edit Role',
                        onPressed: () {
                          setState(() {
                            _isMyRoleTapped = !_isMyRoleTapped;
                          });
                        },
                        icon: Image.asset(
                          _isMyRoleTapped
                              ? 'assets/images/side_menu/sidemenu_check_icon.png'
                              : 'assets/images/side_menu/sidemenu_edit_icon.png',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //CIRCLE CREATOR LABEL
              Expanded(
                flex: 2,
                child: Container(
                  height: widget.height * 0.045,
                  width: widget.width * 0.75,
                  alignment: Alignment.center,
                  padding:
                  EdgeInsets.symmetric(horizontal: widget.width * 0.01),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                      width: 2,
                      color: Color.fromARGB(255, 195, 193, 193),
                    ),
                  ),
                  child: TextFormField(
                    controller: _roleController,
                    textAlign: TextAlign.center,
                    cursorColor: Color.fromARGB(255, 70, 85, 104),
                    readOnly: !_isMyRoleTapped,
                    style: TextStyle(
                      fontFamily: 'OpunMai',
                      fontWeight: FontWeight.w700,
                      fontSize: widget.height * 0.018,
                      color: Color.fromARGB(255, 70, 85, 104),
                    ),
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
              //LOCATION STATUS / TOGGLE BUTTON
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: widget.width * 0.08),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 2,
                        //LOCATION STATUS
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: widget.height * 0.05,
                          //color: Colors.white,
                          child: Text(
                            'Location Status',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'OpunMai',
                              fontWeight: FontWeight.w700,
                              fontSize: widget.height * 0.0235,
                              color: Color.fromARGB(255, 120, 120, 120),
                            ),
                          ),
                        ),
                      ),
                      //TOGGLE BUTTON
                      Flexible(
                        child: Container(
                          alignment: Alignment.centerRight,
                          width: widget.width * 0.35,
                          height: widget.height * 0.03,
                          child: AnimatedToggleSwitch.size(
                            current: _locationStatus,
                            values: const [false, true],
                            iconOpacity: 1,
                            indicatorSize: Size.fromWidth(widget.width * 0.15),
                            borderWidth: 2.0,
                            iconAnimationType: AnimationType.onHover,
                            selectedIconScale: 1.0,
                            customIconBuilder: (context, local, global) =>
                                FittedBox(
                                  child: Text(
                                    local.value ? 'on' : 'off',
                                    style: TextStyle(
                                      fontFamily: 'OpunMai',
                                      fontWeight: FontWeight.w600,
                                      color: Color.lerp(
                                        Color.fromARGB(255, 70, 85, 104),
                                        Colors.white,
                                        local.animationValue,
                                      ),
                                    ),
                                  ),
                                ),
                            style: ToggleStyle(
                              indicatorColor: Color.fromARGB(255, 70, 85, 104),
                              borderRadius:
                              BorderRadius.circular(widget.width * 0.02),
                              borderColor: Color.fromARGB(255, 70, 85, 104),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _locationStatus = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //LEAVE CIRCLE
              Expanded(
                flex: 3,
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return LeaveDialog(
                          height: widget.height,
                          width: widget.width,
                          circleName: currentCircleData['circleName'],
                          circleCode: currentCircleData['circleCode'],
                          callback: updateState,
                        );
                      },
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: widget.width,
                    color: Color.fromARGB(255, 70, 85, 104),
                    child: Text(
                      'Leave this Circle',
                      style: TextStyle(
                        fontFamily: 'OpunMai',
                        fontWeight: FontWeight.bold,
                        fontSize: widget.width * 0.05,
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
