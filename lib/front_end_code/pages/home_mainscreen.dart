// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:safeconnex/controller/app_manager.dart';

import 'package:safeconnex/front_end_code/components/home_components/emergency_mini_button.dart';
import 'package:safeconnex/front_end_code/components/home_components/home_bottom_nav_bar.dart';
import 'package:safeconnex/front_end_code/components/home_components/home_side_menu.dart';
import 'package:safeconnex/front_end_code/pages/home_page.dart';
import 'package:safeconnex/front_end_code/pages/news_page.dart';

import 'package:safeconnex/front_end_code/components/home_components/home_app_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Set<String> _selected = {'Profile'};

  int _selectedTabIndex = 1;
  int _selectedMenuIndex = 0;

  _onTabTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  void _onMenuTapped(int index) {
    setState(() {
      _selectedMenuIndex = index;
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
      drawer: HomeSideMenu(
        height: height,
        width: width,
        topPadding: topPadding,
      ),
      body: _selectedTabIndex == 0
          ? HomePage(
              height: height,
              width: width,
            )
          : _selectedTabIndex == 1
              ? HomePage(
                  height: height,
                  width: width,
                )
              : NewsPage(),
      bottomNavigationBar: HomeBottomNavBar(
        height: height,
        width: width,
        selectedIndex: _selectedTabIndex,
        onItemTapped: _onTabTapped,
      ),
    );
  }
}
