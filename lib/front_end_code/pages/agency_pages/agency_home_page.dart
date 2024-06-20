// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:safeconnex/front_end_code/components/agency_components/agency_home_appbar.dart';
import 'package:safeconnex/front_end_code/components/home_components/emergency_mini_button.dart';
import 'package:safeconnex/front_end_code/components/home_components/home_app_bar.dart';
import 'package:safeconnex/front_end_code/provider/agency_map_provider.dart';
import 'package:safeconnex/front_end_code/provider/user_map_provider.dart';

class AgencyHomePage extends StatefulWidget {
  const AgencyHomePage({
    super.key,
  });

  @override
  State<AgencyHomePage> createState() => _AgencyHomePageState();
}

class _AgencyHomePageState extends State<AgencyHomePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Stack(
      children: [
        //SCROLLABLE BODY
        //AgencyMapProvider();

        /*Container(
          color: Colors.blue[700],
          child: SingleChildScrollView(
            child: Center(
              child: Text(
                'Hello Word!' * 1000,
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'OpunMai',
                ),
              ),
            ),
          ),
        ),*/

        //APP BAR
        AgencyAppBar(),
      ],
    );
  }
}
