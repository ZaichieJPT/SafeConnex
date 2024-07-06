// ignore_for_file: prefer_const_constructors

import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_authentication.dart';
import 'package:safeconnex/front_end_code/components/home_components/circle_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:safeconnex/front_end_code/pages/agency_pages/agency%20_floodscore_page.dart';
import 'package:safeconnex/front_end_code/pages/agency_pages/agency_notification_page.dart';
import 'package:safeconnex/front_end_code/pages/geofencing_page.dart';

class AgencyAppBar extends StatefulWidget {
  final Function onSafetyScoreSelected;
  const AgencyAppBar({
    super.key,
    required this.onSafetyScoreSelected,
  });

  @override
  State<AgencyAppBar> createState() => _AgencyAppBarState();
}

class _AgencyAppBarState extends State<AgencyAppBar> {
  bool _isSafetyScoreSelected = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                //color: Colors.white,
                color: Colors.transparent,
                height: height * 0.19,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //SETTINGS BUTTON
                            Flexible(
                              child: FractionallySizedBox(
                                widthFactor: 0.9,
                                heightFactor: 0.9,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                    border: Border.all(
                                      width: 0.5,
                                      color: Colors.grey,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 0.5,
                                        offset: Offset(-2, 3),
                                      ),
                                    ],
                                  ),
                                  child: Builder(builder: (context) {
                                    return IconButton(
                                      onPressed: () =>
                                          Scaffold.of(context).openDrawer(),
                                      icon: Image.asset(
                                        'assets/images/home_settings_icon.png',
                                        scale: 3,
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                            //AGENCY TITLE

                            Expanded(
                              flex: 4,
                              child: FractionallySizedBox(
                                widthFactor: 0.93,
                                heightFactor: 0.9,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.02,
                                    vertical: height * 0.005,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                    border: Border.all(
                                      width: 0.5,
                                      color: Colors.grey,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 0.5,
                                        offset: Offset(-2, 3),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '${DependencyInjector().locator<SafeConnexAuthentication>().agencyData["agencyType"]}',
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontFamily: 'OpunMai',
                                      fontSize: width * 0.035,
                                      fontWeight: FontWeight.w700,
                                      color:
                                          const Color.fromARGB(255, 14, 46, 67),
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //CIRCLE LIST EXPANSION TILE PLACEHOLDER
                            Flexible(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AgencyNotificationPage(),
                                    ),
                                  );
                                },
                                child: FractionallySizedBox(
                                  widthFactor: 0.9,
                                  heightFactor: 0.9,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.02),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 0.5,
                                        color: Colors.grey,
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.grey,
                                          spreadRadius: 0.5,
                                          offset: Offset(-2, 3),
                                        ),
                                      ],
                                    ),
                                    child: Image.asset(
                                      'assets/images/agency_app/agency_notification.png',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //SPACE BETWEEN ROWS
                      Flexible(
                        flex: 1,
                        child: FractionallySizedBox(
                          heightFactor: 1,
                          child: Container(
                              //color: Colors.red,
                              ),
                        ),
                      ),
                      //2ND ROW APP BAR
                      Flexible(
                        flex: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //SAFETY SCORING BUTTON
                            Flexible(
                              flex: 1,
                              child: FractionallySizedBox(
                                widthFactor: 0.9,
                                heightFactor: 0.9,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                    border: Border.all(
                                      width: 0.5,
                                      color: Colors.grey,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 0.5,
                                        offset: Offset(-2, 3),
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      widget.onSafetyScoreSelected(true);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AgencyFloodScore(),
                                        ),
                                      );
                                    },
                                    icon: Image.asset(
                                      'assets/images/agency_app/agency_safety_score.png',
                                      scale: 3,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            //PLACEHOLDER
                            Expanded(
                              flex: 5,
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
