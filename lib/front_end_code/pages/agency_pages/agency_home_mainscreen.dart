// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:safeconnex/front_end_code/components/agency_components/agency_bottom_navbar.dart';
import 'package:safeconnex/front_end_code/components/agency_components/agency_feed_page.dart';
import 'package:safeconnex/front_end_code/components/agency_components/agency_home_sidemenu.dart';

import 'package:safeconnex/front_end_code/components/home_components/emergency_mini_button.dart';
import 'package:safeconnex/front_end_code/components/home_components/home_bottom_nav_bar.dart';
import 'package:safeconnex/front_end_code/components/home_components/home_side_menu.dart';
import 'package:safeconnex/front_end_code/pages/agency_pages/agency_home_page.dart';
import 'package:safeconnex/front_end_code/pages/home_page.dart';
import 'package:safeconnex/front_end_code/pages/news_page.dart';

import 'package:safeconnex/front_end_code/components/home_components/home_app_bar.dart';

class AgencyMainScreen extends StatefulWidget {
  const AgencyMainScreen({super.key});

  @override
  State<AgencyMainScreen> createState() => _AgencyMainScreenState();
}

class _AgencyMainScreenState extends State<AgencyMainScreen> {
  Set<String> _selected = {'Profile'};

  int _selectedTabIndex = 0;

  _onTabTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  void updateSelected(Set<String> newSelection) {
    setState(() {
      _selected = newSelection;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    double topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 244, 244, 244),
      drawer: AgencySideMenu(),
      body: _selectedTabIndex == 0 ? AgencyHomePage() : AgencyFeedPage(),
      bottomNavigationBar: MediaQuery.viewInsetsOf(context).bottom > 0
          ? null
          : AgencyNavBar(
              selectedIndex: _selectedTabIndex,
              onItemTapped: _onTabTapped,
            ),
    );
  }
}
