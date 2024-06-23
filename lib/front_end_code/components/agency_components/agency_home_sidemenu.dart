// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/sidemenu_circle_settings.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/sidemenu_deleteAccount_dialog.dart';
import 'package:safeconnex/front_end_code/components//side_menu_components/sidemenu_profile_settings.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/sidemenu_feedback_dialog.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/sidemenu_logout_dialog.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/sidemenu_profile_option.dart';

class AgencySideMenu extends StatefulWidget {
  const AgencySideMenu({
    super.key,
  });

  @override
  State<AgencySideMenu> createState() => _AgencySideMenuState();
}

class _AgencySideMenuState extends State<AgencySideMenu> {
  int _selectedMenuIndex = 4;
  double height = 0;
  double width = 0;

  void _onMenuTapped(int index) {
    setState(() {
      _selectedMenuIndex = index;
    });
  }

  void _onShareFeedback() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FeedbackDialog(
          height: height,
          width: width,
        );
      },
    );
  }

  void _onLogout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LogoutDialog(
          height: height,
          width: width,
        );
      },
    );
  }

  void _onDeleteAccount() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteAccountDialog(
          height: height,
          width: width,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.sizeOf(context).height;
    width = MediaQuery.sizeOf(context).width;

    return Drawer(
      width: width * 0.9,
      //backgroundColor: Color.fromARGB(255, 241, 241, 241),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(35),
        ),
      ),
      child: Container(
        height: height,
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
          mainAxisSize: MainAxisSize.min,
          children: [
            //MORE ACCT SETTINGS
            Flexible(
              child: Row(
                children: const [
                  Flexible(
                    child: FractionallySizedBox(
                      widthFactor: 0.2,
                    ),
                  ),
                  Center(
                    child: Text(
                      'More Account Settings:',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'OpunMai',
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 120, 120, 120),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Container(
                width: width,
                height: height,
                color: Colors.white,
                child: FractionallySizedBox(
                  widthFactor: 0.7,
                  heightFactor: 0.45,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                        const Color.fromARGB(50, 0, 0, 0),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 123, 123, 123),
                      ),
                    ),
                    child: FittedBox(
                      child: Text(
                        'Change to User Access',
                        style: TextStyle(
                          fontFamily: 'OpunMai',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          letterSpacing: -0.05,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            //SHARE YOUR FEEDBACK
            Flexible(
              flex: 1,
              child: ProfileOption(
                optionText: 'Share your Feedback',
                image: 'assets/images/side_menu/sidemenu_feedback_icon.png',
                index: 1,
                selectedMenuIndex: _selectedMenuIndex,
                onMenuTapped: _onMenuTapped,
                onTap: _onShareFeedback,
              ),
            ),
            //LOGOUT
            Flexible(
              flex: 1,
              child: ProfileOption(
                optionText: 'Log Out your Account',
                image: 'assets/images/side_menu/sidemenu_logout_icon.png',
                index: 2,
                selectedMenuIndex: _selectedMenuIndex,
                onMenuTapped: _onMenuTapped,
                onTap: _onLogout,
              ),
            ),
            //DELETE ACCOUNT
            Flexible(
              flex: 1,
              child: ProfileOption(
                optionText: 'Delete Account',
                image: 'assets/images/side_menu/sidemenu_delete_icon.png',
                index: 3,
                selectedMenuIndex: _selectedMenuIndex,
                onMenuTapped: _onMenuTapped,
                onTap: _onDeleteAccount,
              ),
            ),
            Expanded(
              flex: 6,
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}