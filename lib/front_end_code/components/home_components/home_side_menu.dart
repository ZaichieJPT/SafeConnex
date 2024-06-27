// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/sidemenu_circle_settings.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/sidemenu_profile_settings.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/sidemenu_emergency_management.dart';

class HomeSideMenu extends StatefulWidget {
  final double height;
  final double width;
  final double topPadding;

  const HomeSideMenu({
    super.key,
    required this.height,
    required this.width,
    required this.topPadding,
  });

  @override
  State<HomeSideMenu> createState() => _HomeSideMenuState();
}

class _HomeSideMenuState extends State<HomeSideMenu> {
  int _selectedTabIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: widget.width * 0.9,
      //backgroundColor: Color.fromARGB(255, 241, 241, 241),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(35),
        ),
      ),
      child: Container(
        height: widget.height,
        color: Color.fromARGB(255, 241, 241, 241),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //TOP TAB BAR
            Container(
              height: widget.height * 0.13,
              color: Color.fromARGB(255, 241, 241, 241),
              padding: EdgeInsets.only(top: widget.topPadding),
              child: FractionallySizedBox(
                heightFactor: 1,
                widthFactor: 1,
                child: FractionallySizedBox(
                  heightFactor: 0.4,
                  widthFactor: 0.85,
                  child: Row(
                    children: [
                      //PROFILE BUTTON
                      Expanded(
                        child: InkWell(
                          onTap: () => _onTabTapped(0),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: _selectedTabIndex == 0
                                  ? Color.fromARGB(255, 70, 85, 104)
                                  : Color.fromARGB(255, 241, 241, 241),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                bottomLeft: Radius.circular(50),
                              ),
                              border: Border.all(
                                width: 2,
                                color: Color.fromARGB(255, 70, 85, 104),
                              ),
                            ),
                            child: Image.asset(
                              'assets/images/side_menu/sidemenu_profile_icon.png',
                              color: _selectedTabIndex == 0
                                  ? Color.fromARGB(255, 241, 241, 241)
                                  : Color.fromARGB(255, 70, 85, 104),
                            ),
                          ),
                        ),
                      ),
                      //CIRCLE SETTINGS BUTTON
                      Expanded(
                        child: InkWell(
                          onTap: () => _onTabTapped(1),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: _selectedTabIndex == 1
                                  ? Color.fromARGB(255, 70, 85, 104)
                                  : Color.fromARGB(255, 241, 241, 241),
                              border: Border.symmetric(
                                horizontal: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 70, 85, 104),
                                ),
                              ),
                            ),
                            child: Image.asset(
                              'assets/images/side_menu/sidemenu_circle_icon.png',
                              color: _selectedTabIndex == 1
                                  ? Color.fromARGB(255, 241, 241, 241)
                                  : Color.fromARGB(255, 70, 85, 104),
                            ),
                          ),
                        ),
                      ),
                      //EMERGENCY SETTINGS BUTTON
                      Expanded(
                        child: InkWell(
                          onTap: () => _onTabTapped(2),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: _selectedTabIndex == 2
                                  ? Color.fromARGB(255, 70, 85, 104)
                                  : Color.fromARGB(255, 241, 241, 241),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              ),
                              border: Border.all(
                                width: 2,
                                color: Color.fromARGB(255, 70, 85, 104),
                              ),
                            ),
                            child: Image.asset(
                              'assets/images/side_menu/sidemenu_emergency_icon.png',
                              color: _selectedTabIndex == 2
                                  ? Color.fromARGB(255, 241, 241, 241)
                                  : Color.fromARGB(255, 70, 85, 104),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //PROFILE SETTINGS
            Flexible(
              child: _selectedTabIndex == 0
                  ? ProfileSettings(
                height: widget.height,
                width: widget.width,
              )
                  : _selectedTabIndex == 1
                  ? CircleSettings(
                height: widget.height,
                width: widget.width,
              )
                  : EmergencyManagement(
                height: widget.height,
                width: widget.width,
              ),
            ),
          ],
        ),
      ),
    );
  }
}