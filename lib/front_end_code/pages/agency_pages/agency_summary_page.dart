// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_reports_database.dart';
import 'package:safeconnex/front_end_code/components/agency_components/notiftype_contactrequest_template.dart';
import 'package:safeconnex/front_end_code/components/agency_components/notiftype_soscancel_template.dart';
import 'package:safeconnex/front_end_code/components/agency_components/notiftype_sossent_template.dart';
import 'package:safeconnex/front_end_code/components/agency_components/notiftype_welcome_template.dart';
import 'package:safeconnex/front_end_code/pages/agency_pages/agency_cancelledsos_page.dart';
import 'package:safeconnex/front_end_code/pages/agency_pages/agency_contactrequest_page.dart';
import 'package:safeconnex/front_end_code/pages/agency_pages/agency_sosreports_page.dart';
import 'package:fl_chart/fl_chart.dart';

class AgencySummaryPage extends StatefulWidget {
  const AgencySummaryPage({super.key});

  @override
  State<AgencySummaryPage> createState() => _AgencySummaryPageState();
}

class _AgencySummaryPageState extends State<AgencySummaryPage> {
  final ScrollController scrollController = ScrollController();
  int _currentReportIndex = -1;
  int _currentMonthIndex = 0;
  int _currentYearIndex = 0;
  int? _key;
  int? _key2;

  _collapse() {
    int? newKey;
    do {
      _key = new Random().nextInt(10000);
    } while (newKey == _key);
  }

  final List<String> _monthsReportFilter = [
    'JANUARY',
    'FEBRUARY',
    'MARCH',
    'APRIL',
    'MAY',
    'JUNE',
    'JULY',
    'AUGUST',
    'SEPTEMBER',
    'OCTOBER',
    'NOVEMBER',
    'DECEMBER',
  ];

  final List<String> _yearsReportFilter = [
    '2024',
  ];

  _onReportTapped(int index) {
    setState(() {
      _currentReportIndex = index;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => _currentReportIndex == 0
              ? AgencySOSReports()
              : _currentReportIndex == 1
                  ? AgencyCancelledPage()
                  : AgencyContactRequestPage(),
        ),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DependencyInjector().locator<SafeConnexReportsDatabase>().getSortedNotification();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 66, 79, 88),
        automaticallyImplyLeading: false,
        toolbarHeight: height * 0.08,
        title: Padding(
          padding: EdgeInsets.only(left: width * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/agency_app/agency_reports_icon.png',
                    color: Colors.amber.shade300,
                    width: width * 0.09,
                  ),
                  SizedBox(
                    width: width * 0.025,
                  ),
                  Text(
                    'Report Summary',
                    style: TextStyle(
                      fontFamily: 'OpunMai',
                      fontSize: height * 0.02,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              //BACK TO NOTIF BUTTON
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                //REPORTS BUTTON
                child: Container(
                  height: width * 0.1,
                  width: width * 0.11,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.015),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(width * 0.02),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(-3, 3),
                        color: Colors.grey.shade600,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/images/agency_app/agency_notification.png',
                    color: Color.fromARGB(255, 66, 79, 88),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            //CHART CONTAINER
            Expanded(
              child: Stack(
                children: [
                  Column(
                    children: [
                      //DROPDOWN PLACEHOLDER
                      Container(
                        height: height * 0.085,
                        //color: Colors.yellow,
                      ),
                      Expanded(
                        child: Container(
                          //color: Colors.blue,
                          padding: EdgeInsets.only(
                            left: width * 0.03,
                            right: width * 0.05,
                            top: height * 0.04,
                            bottom: height * 0.02,
                          ),
                          child: BarChart(
                            BarChartData(
                              maxY: 50,
                              gridData: FlGridData(
                                show: false,
                              ),
                              borderData: FlBorderData(
                                border: Border(
                                  left: BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                  bottom: BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                ),
                              ),
                              alignment: BarChartAlignment.center,
                              groupsSpace: width * 0.08,
                              titlesData: FlTitlesData(
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    reservedSize: width * 0.09,
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          right: width * 0.015,
                                          //left: width * 0.015,
                                        ),
                                        child: Text(
                                          value.floor().toString(),
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontFamily: 'OpunMai',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 11,
                                            letterSpacing: 0.05,
                                            color: Color.fromARGB(
                                                255, 40, 72, 113),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      String _title = '';
                                      switch (value.toInt()) {
                                        case 0:
                                          _title = 'SOS REPORTS';
                                          break;
                                        case 1:
                                          _title = 'CANCELLED SOS';
                                          break;
                                        case 2:
                                          _title = 'CONTACT REQUESTS';
                                          break;
                                      }
                                      return Padding(
                                        padding: EdgeInsets.only(top: 5),
                                        child: Text(
                                          _title,
                                          style: TextStyle(
                                            fontFamily: 'OpunMai',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 10,
                                            letterSpacing: 0.05,
                                            color: value == 0
                                                ? Color.fromARGB(
                                                    255, 110, 169, 134)
                                                : value == 1
                                                    ? Color.fromARGB(
                                                        255, 242, 146, 58)
                                                    : Color.fromARGB(
                                                        255, 150, 117, 184),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              //BAR CHART DATA
                              barGroups: [
                                BarChartGroupData(
                                  x: 0,
                                  barRods: [
                                    BarChartRodData(
                                      toY: double.parse(DependencyInjector().locator<SafeConnexReportsDatabase>().sosCount!.toString()),
                                      width: width * 0.2,
                                      borderRadius: BorderRadius.zero,
                                      color: const Color.fromARGB(
                                          255, 110, 169, 134),
                                    ),
                                  ],
                                ),
                                BarChartGroupData(
                                  x: 1,
                                  barRods: [
                                    BarChartRodData(
                                      toY: double.parse(DependencyInjector().locator<SafeConnexReportsDatabase>().canceledSOSCount!.toString()),
                                      width: width * 0.2,
                                      borderRadius: BorderRadius.zero,
                                      color: const Color.fromARGB(
                                          255, 242, 146, 58),
                                    ),
                                  ],
                                ),
                                BarChartGroupData(
                                  x: 2,
                                  barRods: [
                                    BarChartRodData(
                                      toY: double.parse(DependencyInjector().locator<SafeConnexReportsDatabase>().contactInfoCount!.toString()),
                                      width: width * 0.2,
                                      borderRadius: BorderRadius.zero,
                                      color: const Color.fromARGB(
                                          255, 150, 117, 184),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //MONTHS DROPDOWN
                  Positioned(
                    top: height * 0.015,
                    left: width * 0.1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(),
                      child: Container(
                        width: width * 0.38,
                        constraints: BoxConstraints(maxHeight: height * 0.2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(width * 0.02),
                          border: Border.all(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 3),
                              color: Colors.grey.shade600,
                            ),
                          ],
                        ),
                        //MONTHS DROPDOWN LIST
                        child: ExpansionTile(
                          visualDensity: VisualDensity.compact,
                          key: Key(_key.toString()),
                          initiallyExpanded: false,
                          dense: true,
                          childrenPadding: EdgeInsets.zero,
                          iconColor: const Color.fromARGB(255, 62, 73, 101),
                          collapsedIconColor:
                              const Color.fromARGB(255, 62, 73, 101),
                          trailing: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          title: Text(
                            _monthsReportFilter[_currentMonthIndex],
                            textScaler: TextScaler.linear(0.9),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'OpunMai',
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: const Color.fromARGB(255, 62, 73, 101),
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          tilePadding: EdgeInsets.zero,
                          //MONTH LIST
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Container(
                                constraints: BoxConstraints(
                                  maxHeight: height * 0.13,
                                ),
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    return Scrollbar(
                                      thickness: 5,
                                      radius: Radius.circular(15),
                                      child: ListView.builder(
                                        controller: scrollController,
                                        shrinkWrap: true,
                                        physics: const ClampingScrollPhysics(),
                                        itemCount: _monthsReportFilter.length,
                                        itemBuilder: (context, index) =>
                                            InkWell(
                                          onTap: () {
                                            setState(() {
                                              _collapse();
                                              if (_currentMonthIndex != index) {
                                                _currentMonthIndex = index;
                                              }
                                            });
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: height * 0.004,
                                              horizontal: width * 0.03,
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: height * 0.003,
                                              ),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 123, 123, 123),
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                              ),
                                              child: Text(
                                                _monthsReportFilter[index],
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontFamily: 'OpunMai',
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //YEAR DROPDOWN
                  Positioned(
                    top: height * 0.015,
                    right: width * 0.1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(),
                      child: Container(
                        width: width * 0.37,
                        constraints: BoxConstraints(maxHeight: height * 0.2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(width * 0.02),
                          border: Border.all(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 3),
                              color: Colors.grey.shade600,
                            ),
                          ],
                        ),
                        //YEAR LIST
                        child: ExpansionTile(
                          visualDensity: VisualDensity.compact,
                          key: Key(_key2.toString()),
                          initiallyExpanded: false,
                          dense: true,
                          childrenPadding: EdgeInsets.zero,
                          iconColor: const Color.fromARGB(255, 62, 73, 101),
                          collapsedIconColor:
                              const Color.fromARGB(255, 62, 73, 101),
                          trailing: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),

                          title: Text(
                            _yearsReportFilter[_currentYearIndex],
                            textScaler: TextScaler.linear(0.9),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'OpunMai',
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: const Color.fromARGB(255, 62, 73, 101),
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          tilePadding: EdgeInsets.zero,
                          //YEAR LIST
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Container(
                                constraints: BoxConstraints(
                                  maxHeight: height * 0.12,
                                ),
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    return Scrollbar(
                                      thickness: 5,
                                      radius: Radius.circular(15),
                                      child: ListView.builder(
                                        controller: scrollController,
                                        shrinkWrap: true,
                                        physics: const ClampingScrollPhysics(),
                                        itemCount: _yearsReportFilter.length,
                                        itemBuilder: (context, index) =>
                                            InkWell(
                                          onTap: () {
                                            setState(() {
                                              _collapse();
                                              if (_currentYearIndex != index) {
                                                _currentYearIndex = index;
                                              }
                                            });
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: height * 0.003,
                                              horizontal: width * 0.03,
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: height * 0.002,
                                              ),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 123, 123, 123),
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                              ),
                                              child: Text(
                                                _yearsReportFilter[index],
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontFamily: 'OpunMai',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
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
            ),
            //LIST OF REPORTS
            Container(
              height: height * 0.055,
              width: width,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: width * 0.08),
              color: Colors.grey.shade400,
              child: Text(
                'LIST OF REPORTS',
                style: TextStyle(
                  fontFamily: 'OpunMai',
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: width,
                child: Column(
                  children: [
                    //SOS REPORTS
                    InkWell(
                      onTap: () => _onReportTapped(0),
                      child: Container(
                        height: height * 0.1,
                        width: width,
                        color: _currentReportIndex == 0
                            ? Colors.grey.shade300
                            : Colors.transparent,
                        child: Row(
                          children: [
                            //LOGO
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.05),
                              child: Container(
                                width: width * 0.13,
                                height: width * 0.13,
                                padding: EdgeInsets.only(
                                  left: width * 0.025,
                                  right: width * 0.025,
                                  bottom: 5,
                                ),
                                decoration: BoxDecoration(
                                  gradient: RadialGradient(
                                    colors: const [
                                      Color.fromARGB(255, 238, 29, 35),
                                      Color.fromARGB(255, 155, 34, 34),
                                    ],
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  'assets/images/side_menu/emergency_mgmt/contacts_main_icon.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            //TEXT
                            FittedBox(
                              child: Text(
                                'SOS REPORTS',
                                style: TextStyle(
                                  fontFamily: 'OpunMai',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                  color: const Color.fromARGB(255, 70, 81, 97),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //CANCELLED REPORTS
                    InkWell(
                      onTap: () => _onReportTapped(1),
                      child: Container(
                        height: height * 0.1,
                        width: width,
                        color: _currentReportIndex == 1
                            ? Colors.grey.shade300
                            : Colors.transparent,
                        child: Row(
                          children: [
                            //LOGO
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.05),
                              child: Container(
                                width: width * 0.13,
                                height: width * 0.13,
                                padding: EdgeInsets.only(
                                  left: width * 0.025,
                                  right: width * 0.025,
                                  bottom: 5,
                                ),
                                decoration: BoxDecoration(
                                  gradient: RadialGradient(
                                    colors: [
                                      Colors.white,
                                      Colors.grey.shade500,
                                    ],
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  'assets/images/side_menu/emergency_mgmt/contacts_main_icon.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            //TEXT
                            FittedBox(
                              child: Text(
                                'CANCELLED SOS',
                                style: TextStyle(
                                  fontFamily: 'OpunMai',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                  color: const Color.fromARGB(255, 70, 81, 97),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //CONTACT REQUEST
                    InkWell(
                      onTap: () => _onReportTapped(2),
                      child: Container(
                        height: height * 0.1,
                        width: width,
                        color: _currentReportIndex == 2
                            ? Colors.grey.shade300
                            : Colors.transparent,
                        child: Row(
                          children: [
                            //LOGO
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.05),
                              child: Container(
                                width: width * 0.13,
                                height: width * 0.13,
                                child: Image.asset(
                                  'assets/images/agency_app/notif_contactrequest_icon.png',
                                  width: width * 0.11,
                                ),
                              ),
                            ),
                            //TEXT
                            Expanded(
                              child: Text(
                                'CONTACT INFORMATION REQUEST',
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontFamily: 'OpunMai',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                  color: const Color.fromARGB(255, 70, 81, 97),
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
          ],
        ),
      ),
    );
  }

  Widget buildNotificationItem(int notifType, String fullName, String firstName,
      String age, String date) {
    switch (notifType) {
      case 1:
        return SOSNotifTemplate(
          fullName: fullName,
          firstName: firstName,
          age: age,
          date: date,
        );
      case 2:
        return SOSCancelNotifTemplate(
          fullName: fullName,
          firstName: firstName,
          age: age,
          date: date,
        );
      case 3:
        return ContactInfoRequestTemplate(
          firstName: firstName,
        );
      case 4:
        return WelcomeTemplate();
      default:
        return Text('Unknown Notification Type'); // Handle unexpected types
    }
  }
}
