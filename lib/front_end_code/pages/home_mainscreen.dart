// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:safeconnex/front_end_code/components/carousel_slider.dart';

import 'package:safeconnex/front_end_code/components/home_components/emergency_mini_button.dart';
import 'package:safeconnex/front_end_code/components/home_components/home_bottom_nav_bar.dart';
import 'package:safeconnex/front_end_code/components/home_components/home_side_menu.dart';
import 'package:safeconnex/front_end_code/components/home_profile_card.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/sidemenu_feedback_dialog.dart';
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
  bool _isOverlayDisplayed = true;

  GlobalKey<HomePageState> homePageKey = GlobalKey<HomePageState>(); // key to the homepage

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

  void displayCircleCard() {
    setState(() {
      _isOverlayDisplayed = true;
    });
  }

  dismissOverlay() {
    setState(() {
      _isOverlayDisplayed = !_isOverlayDisplayed;
      _selectedTabIndex = 1;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void updateHomePage(){
    homePageKey.currentState!.updateAppBarState();
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
        circleListCallback: updateHomePage,
      ),
      body: _selectedTabIndex == 0 || _selectedTabIndex == 1
          ? Stack(
        alignment: Alignment.center,
        children: [
          HomePage(
            key: homePageKey,
            height: height,
            width: width,
          ),
          if (_selectedMenuIndex == 0 &&
              _isOverlayDisplayed &&
              _selectedTabIndex != 1) ...[
            Opacity(
              opacity: 0.4,
              child: ModalBarrier(
                dismissible: true,
                onDismiss: dismissOverlay,
                color: Colors.black,
              ),
            ),
            //SLIDER
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  bottom: height * 0.15,
                  child: Container(
                    height: height * 0.53,
                    width: width,
                    alignment: Alignment.bottomCenter,
                    //color: Colors.lightBlue,
                    child: CarouseSliderComponent(),
                  ),
                ),
              ],
            ),
          ],
        ],
      )
          : _selectedTabIndex == 2
          ? NewsPage()
          : null,
      bottomNavigationBar: HomeBottomNavBar(
        height: height,
        width: width,
        selectedIndex: _selectedTabIndex,
        onItemTapped: _onTabTapped,
        displayCard: displayCircleCard,
      ),
    );
  }
}