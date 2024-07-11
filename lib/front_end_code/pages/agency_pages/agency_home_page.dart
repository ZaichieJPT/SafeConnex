// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_agency_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_authentication.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_news_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_notification_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_reports_database.dart';
import 'package:safeconnex/front_end_code/components/agency_components/agency_home_appbar.dart';
import 'package:safeconnex/front_end_code/components/home_components/emergency_mini_button.dart';
import 'package:safeconnex/front_end_code/components/home_components/home_app_bar.dart';
import 'package:safeconnex/front_end_code/provider/agency_map_provider.dart';

class AgencyHomePage extends StatefulWidget {
  final Function onSafetyScoreSelected;
  const AgencyHomePage({
    super.key,
    required this.onSafetyScoreSelected,
  });

  @override
  State<AgencyHomePage> createState() => _AgencyHomePageState();
}

class _AgencyHomePageState extends State<AgencyHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DependencyInjector().locator<SafeConnexNotificationDatabase>().getNotificationsFromDatabase(DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.uid);
    DependencyInjector().locator<SafeConnexNewsDatabase>().listenOnTheNews();
    DependencyInjector().locator<SafeConnexAgencyDatabase>().getMyAgencyData();
    DependencyInjector().locator<SafeConnexReportsDatabase>().getReportCounts();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Stack(
      children: [
        //SCROLLABLE BODY
        AgencyMapProvider(),

        //APP BAR
        AgencyAppBar(
          onSafetyScoreSelected: widget.onSafetyScoreSelected,
        ),
      ],
    );
  }
}
