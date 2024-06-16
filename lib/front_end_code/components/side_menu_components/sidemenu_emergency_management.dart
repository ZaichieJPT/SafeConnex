// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/emergency_management/emergency_contacts_page.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/emergency_management/emergency_mgmt_option.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/emergency_management/emergency_safety_agencies.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/emergency_management/emergency_switchmap_dialog.dart';
import 'package:safeconnex/front_end_code/pages/emergency_button_pages/emergency_initialpin_dialog.dart';
import 'package:safeconnex/front_end_code/pages/emergency_button_pages/emergency_pinsetup_page.dart';

class EmergencyManagement extends StatefulWidget {
  final double height;
  final double width;

  const EmergencyManagement({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  State<EmergencyManagement> createState() => _EmergencyManagementState();
}

class _EmergencyManagementState extends State<EmergencyManagement> {
  int _currentEmergencyOptionIndex = 4;

  _onOptionSelected(int index) {
    setState(() {
      _currentEmergencyOptionIndex = index;
      _currentEmergencyOptionIndex == 0
          ? Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SOSPinSetupPage()))
          : _currentEmergencyOptionIndex == 1
              ? Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EmergencyContacts()))
              : _currentEmergencyOptionIndex == 2
                  ? showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SwitchMapDialog();
                      },
                    )
                  : Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SafetyAgencies()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        children: [
          //EMERGENCY MANAGEMENT
          Container(
            height: widget.height * 0.055,
            width: widget.width,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: widget.width * 0.055),
            //color: Colors.white,
            child: FittedBox(
              child: Text(
                'EMERGENCY MANAGEMENT',
                style: TextStyle(
                  fontFamily: 'OpunMai',
                  fontSize: widget.height * 0.019,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 70, 81, 97),
                ),
              ),
            ),
          ),
          //CHANGE PIN OPTION
          EmergencyMgmtOption(
            optionTitle: 'Change PIN',
            optionContent: 'To reset your SOS Cancellation PIN Code.',
            image:
                'assets/images/side_menu/emergency_mgmt/emergencymgmt_changepin_icon.png',
            index: 0,
            selectedIndex: _currentEmergencyOptionIndex,
            onOptionTap: _onOptionSelected,
          ),
          //EMERGENCY CONTACTS
          EmergencyMgmtOption(
            optionTitle: 'Emergency Contacts',
            optionContent: 'Decide who can receive your SOS alerts.',
            image:
                'assets/images/side_menu/emergency_mgmt/emergencymgmt_contacts_icon.png',
            index: 1,
            selectedIndex: _currentEmergencyOptionIndex,
            onOptionTap: _onOptionSelected,
          ),
          //SWITCH MAP LAYER
          EmergencyMgmtOption(
            optionTitle: 'Switch Map Layer',
            optionContent:
                'Switch your map to view safety scores or circle members.',
            image:
                'assets/images/side_menu/emergency_mgmt/emergencymgmt_switchmap_icon.png',
            index: 2,
            selectedIndex: _currentEmergencyOptionIndex,
            onOptionTap: _onOptionSelected,
          ),
          //SAFETY AGENCIES
          EmergencyMgmtOption(
            optionTitle: 'Safety Agencies',
            optionContent:
                'Select safety agencies who can respond to your SOS.',
            image:
                'assets/images/side_menu/emergency_mgmt/emergencymgmt_agencies_icon.png',
            index: 3,
            selectedIndex: _currentEmergencyOptionIndex,
            onOptionTap: _onOptionSelected,
          ),
        ],
      ),
    );
  }
}
