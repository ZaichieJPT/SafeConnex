// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_authentication.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_circle_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_geofence_database.dart';
import 'package:safeconnex/front_end_code/components/home_components/circle_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:safeconnex/front_end_code/pages/circle_pages/circle_page.dart';
import 'package:safeconnex/front_end_code/pages/geofencing_page.dart';

class HomeAppBar extends StatefulWidget {
  final double height;
  final double width;
  final ScrollController scrollController;
  const HomeAppBar({
    super.key,
    required this.height,
    required this.scrollController,
    required this.width,
  });

  @override
  State<HomeAppBar> createState() => HomeAppBarState();
}

class HomeAppBarState extends State<HomeAppBar> {
  //SafeConnexCircleDatabase circleDatabase = SafeConnexCircleDatabase();
  //SafeConnexGeofenceDatabase geofenceDatabase = SafeConnexGeofenceDatabase();
  late GlobalKey expansionTileKey = GlobalKey();


  bool isExpanded = false;

  int currentCircleIndex = 0;
  int circleCount = 0;

  int? _key;

  _collapse() {
    int? newKey;
    do {
      _key = new Random().nextInt(10000);
    } while (newKey == _key);
  }

  void updateState(){
    //circle list
    print("updateStateAppBar");
    setState(() {
      DependencyInjector().locator<SafeConnexCircleDatabase>().getCircleList(DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.uid);
      if(currentCircleIndex > 0){
        currentCircleIndex = 0;
        DependencyInjector().locator<SafeConnexCircleDatabase>().getCircleData(DependencyInjector().locator<SafeConnexCircleDatabase>().circleList[currentCircleIndex]["circle_code"]);
        DependencyInjector().locator<SafeConnexCircleDatabase>().currentCircleCode = DependencyInjector().locator<SafeConnexCircleDatabase>().circleList[currentCircleIndex]["circle_code"];

      }else if(currentCircleIndex == 0 || DependencyInjector().locator<SafeConnexCircleDatabase>().circleDataList.length > 1){
        currentCircleIndex = 1;
        DependencyInjector().locator<SafeConnexCircleDatabase>().getCircleData(DependencyInjector().locator<SafeConnexCircleDatabase>().circleList[currentCircleIndex]["circle_code"]);
        DependencyInjector().locator<SafeConnexCircleDatabase>().currentCircleCode = DependencyInjector().locator<SafeConnexCircleDatabase>().circleList[currentCircleIndex]["circle_code"];

      }
      print(DependencyInjector().locator<SafeConnexCircleDatabase>().circleList.length);
    });
  }

  @override
  Widget build(BuildContext context) {

    setState(() {
      DependencyInjector().locator<SafeConnexCircleDatabase>().getCircleList(DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.uid);
    });

    ExpansionTileController _expansionController = ExpansionTileController();
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                //color: Colors.white,
                color: Colors.transparent,
                height: widget.height * 0.19,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //SETTINGS BUTTON
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
                                        offset: Offset(-3, 4),
                                      ),
                                    ],
                                  ),
                                  child: Builder(builder: (context) {
                                    return IconButton(
                                      onPressed: () =>
                                          Scaffold.of(context).openDrawer(),
                                      icon: Image.asset(
                                        'assets/images/home_settings_icon.png',
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                            //ADD CIRCLE BUTTON
                            //SizedBox(),
                            Flexible(
                              flex: 1,
                              child: InkWell(
                                highlightColor: Colors.grey,
                                borderRadius: BorderRadius.circular(250),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CirclePage()));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.grey, width: 0.5),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 0.6,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: FractionallySizedBox(
                                    //widthFactor: 0.7,
                                    heightFactor: 0.7,
                                    child: Image.asset(
                                      'assets/images/home_add_icon.png',
                                      scale: widget.width * 0.015,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //CIRCLE LIST EXPANSION TILE PLACEHOLDER
                            Expanded(
                              flex: 4,
                              child: Container(),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //ADD PLACES BUTTON
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
                                        offset: Offset(-3, 4),
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      DependencyInjector().locator<SafeConnexGeofenceDatabase>().getGeofence(DependencyInjector().locator<SafeConnexCircleDatabase>().currentCircleCode!);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  GeofencingPage()));
                                    },
                                    icon: Image.asset(
                                      'assets/images/home_location_icon.png',
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
                    //CIRCLE LIST CONTAINER
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          border: Border.all(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 0.5,
                              offset: Offset(3, 7),
                            ),
                          ],
                        ),
                        //CIRCLE LIST DROPDOWN LIST
                        child: ExpansionTile(
                          key: new Key(_key.toString()),
                          initiallyExpanded: false,

                          iconColor: const Color.fromARGB(255, 62, 73, 101),
                          collapsedIconColor:
                          const Color.fromARGB(255, 62, 73, 101),
                          title: Text(
                            DependencyInjector().locator<SafeConnexCircleDatabase>().circleList.isEmpty
                                ? "No Circle"
                                : DependencyInjector().locator<SafeConnexCircleDatabase>()
                                .circleList[currentCircleIndex]
                            ["circle_name"],
                            textScaler: TextScaler.linear(0.9),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'OpunMai',
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: const Color.fromARGB(255, 62, 73, 101),
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          //OTHER CIRCLES OF THE USER
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Container(
                                constraints: BoxConstraints(
                                  maxHeight: widget.height * 0.2,
                                ),
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    return Scrollbar(
                                      thickness: 8,
                                      radius: Radius.circular(15),
                                      child: ListView.builder(
                                        controller: widget.scrollController,
                                        shrinkWrap: true,
                                        physics: const ClampingScrollPhysics(),
                                        itemCount: DependencyInjector().locator<SafeConnexCircleDatabase>().circleList.length,
                                        itemBuilder: (context, index) {
                                          return CircleListTile(
                                            title: DependencyInjector().locator<SafeConnexCircleDatabase>()
                                                .circleList[index]["circle_name"],
                                            onTap: () {
                                              print(DependencyInjector().locator<SafeConnexCircleDatabase>().circleList.length);
                                              setState(() {
                                                _collapse();
                                                if (currentCircleIndex != index) {
                                                  // Check if different circle is tapped
                                                  currentCircleIndex = index;
                                                  DependencyInjector().locator<SafeConnexCircleDatabase>().getCircleData(DependencyInjector().locator<SafeConnexCircleDatabase>().circleList[index]["circle_code"]);
                                                  DependencyInjector().locator<SafeConnexCircleDatabase>().currentCircleCode = DependencyInjector().locator<SafeConnexCircleDatabase>().circleList[index]["circle_code"];
                                                }
                                              });
                                            },
                                          );
                                        }
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