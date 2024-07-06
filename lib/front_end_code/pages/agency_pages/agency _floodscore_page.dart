// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cache/flutter_map_cache.dart';
import 'package:latlong2/latlong.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_circle_database.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_firestore.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_geofence_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_scoring_database.dart';

class AgencyFloodScore extends StatefulWidget {
  const AgencyFloodScore({super.key});

  @override
  State<AgencyFloodScore> createState() => _AgencyFloodScoreState();
}

class _AgencyFloodScoreState extends State<AgencyFloodScore> {
  ScrollController placesScrollControl = ScrollController();
  //SafeConnexSafetyScoringDatabase safetyScoringDatabase = SafeConnexSafetyScoringDatabase();

  double _sliderValue = 100.0;
  int _currentRiskIndex = -1;
  int _currentScoringIndex = 0;
  String? riskInfo = 'Flood Risk';
  String? riskLevel;

  Color markerColor = Colors.blue;
  Color borderColor = Colors.blue.shade500;

  Marker? geolocationMarker = Marker(point: LatLng(0, 0), child: Container());
  CircleMarker? circleMarker = CircleMarker(point: LatLng(0, 0), radius: 0);
  LatLng? tapLocation;

  _onRiskLevelTapped(int index) {
    setState(() {
      if (_currentRiskIndex == index) {
        _currentRiskIndex = -1;
      } else {
        _currentRiskIndex = index;
      }
    });
  }

  _onScoringTypeTapped(int index) {
    setState(() {
      _currentScoringIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    void addGeolocationMarker(LatLng markerLocation, double sliderValue){
      geolocationMarker = Marker(
          height: 50,
          width: 50,
          rotate: true,
          alignment: Alignment.topCenter,
          point: markerLocation,
          child: Stack(
            children: [
              Positioned(
                  child: Icon(Icons.location_pin, size: 55)
              ),
              Positioned(
                top: 10,
                left: 16,
                child: Container(
                  width: 23,
                  height: 23,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.green
                  ),
                ),
              ),
            ],
          )
      );
      circleMarker = CircleMarker(
          color: markerColor.withOpacity(0.5),
          borderColor: borderColor,
          borderStrokeWidth: 2,
          point: markerLocation,
          radius: sliderValue,
          useRadiusInMeter: true
      );
      setState(() {});
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 71, 82, 98),
          leadingWidth: width * 0.15,
          toolbarHeight: height * 0.08,
          title: Text(
            'Safety Scoring',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'OpunMai',
              fontSize: 19,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              letterSpacing: 1,
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.only(left: height * 0.035),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              radius: 1,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color.fromARGB(255, 232, 220, 206),
                    width: 3,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 182, 176, 163),
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: FittedBox(
                  child: Text(
                    String.fromCharCode(Icons.west.codePoint),
                    style: TextStyle(
                      fontFamily: Icons.west.fontFamily,
                      fontSize: width * 0.055,
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 110, 101, 94),
                      package: Icons.west.fontPackage,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Center(
          child: SizedBox(
            height: height * 0.85,
            child: Column(
              children: [
                Flexible(
                  child: SingleChildScrollView(
                    reverse: true,
                    child: SizedBox(
                      height: height * 0.85,
                      child: Column(
                        children: [
                          //MAP VIEW

                          Container(
                            width: width,
                            height: height * 0.47,
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              border: Border.symmetric(
                                horizontal: BorderSide(
                                  color: Color.fromARGB(255, 173, 162, 153),
                                  width: 6,
                                ),
                              ),
                            ),
                            child: FlutterMap(
                              options: MapOptions(
                                initialCenter: LatLng(16.0265, 120.3363),
                                initialZoom: 13.2,
                                onTap: (_, tapLocation){
                                  this.tapLocation = tapLocation;
                                  _sliderValue = 100;
                                  DependencyInjector().locator<SafeConnexSafetyScoringDatabase>().getGeocode(tapLocation).whenComplete((){
                                    addGeolocationMarker(tapLocation, _sliderValue);
                                  });
                                },
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  userAgentPackageName: 'com.safeconnex.app',
                                  tileProvider: CachedTileProvider(
                                    store: MemCacheStore(),
                                  ),
                                ),
                                CircleLayer(
                                  circles: [
                                    circleMarker!
                                  ],
                                ),
                                MarkerLayer(
                                  markers: [
                                    geolocationMarker!
                                  ],
                                ),
                              ],
                            ),
                          ),
                          //SLIDER
                          Container(
                            height: height * 0.08,
                            width: width,
                            padding: EdgeInsets.only(
                                left: width * 0.02, right: width * 0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: SliderTheme(
                                    data: SliderThemeData(
                                      activeTickMarkColor: Colors.transparent,
                                      trackHeight: height * 0.0065,
                                      thumbShape: RoundSliderThumbShape(
                                        enabledThumbRadius: width * 0.04,
                                      ),
                                    ),
                                    child: Slider(
                                      value: _sliderValue,
                                      onChanged: (value) {
                                        setState(() {
                                          _sliderValue = value;
                                          addGeolocationMarker(tapLocation!, value);
                                        });
                                      },
                                      min: 50,
                                      max: 3000,
                                      divisions: 100,
                                      activeColor:
                                      Color.fromARGB(255, 70, 85, 104),
                                      inactiveColor:
                                      Color.fromARGB(255, 70, 85, 104),
                                      thumbColor: Colors.deepPurple[400],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.03,
                                ),
                                //RADIUS VALUE
                                Flexible(
                                  child: Text(
                                    '${_sliderValue.toStringAsFixed(1)} m zone',
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontFamily: 'OpunMai',
                                      fontSize: height * 0.013,
                                      color: Color.fromARGB(255, 70, 85, 104),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //LOCATION DETAILS HEADER
                          Container(
                            width: width,
                            height: height * 0.05,
                            color: Color.fromARGB(255, 232, 220, 206),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: (){
                                      riskInfo = "Flood Risk";
                                      _onScoringTypeTapped(0);
                                    },
                                    child: Container(
                                      height: height * 0.05,
                                      width: width,
                                      alignment: Alignment.center,
                                      decoration: _currentScoringIndex == 0
                                          ? BoxDecoration(
                                        color: Color.fromARGB(
                                            255, 121, 192, 148),
                                        borderRadius:
                                        BorderRadius.circular(
                                            width * 0.02),
                                        boxShadow: const [
                                          BoxShadow(
                                            offset: Offset(0, 3),
                                            color: Color.fromARGB(
                                                255, 110, 169, 134),
                                          ),
                                        ],
                                      )
                                          : null,
                                      child: Text(
                                        'Flood Risk Level',
                                        style: TextStyle(
                                          fontFamily: 'OpunMai',
                                          fontSize: height * 0.02,
                                          fontWeight: FontWeight.w700,
                                          color: _currentScoringIndex == 0
                                              ? Color.fromARGB(255, 71, 82, 98)
                                              : Color.fromARGB(
                                              255, 173, 162, 153),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      riskInfo = "Accident Risk";
                                      _onScoringTypeTapped(1);
                                    },
                                    child: Container(
                                      height: height,
                                      width: width,
                                      alignment: Alignment.center,
                                      decoration: _currentScoringIndex == 1
                                          ? BoxDecoration(
                                        color: Color.fromARGB(
                                            255, 121, 192, 148),
                                        borderRadius:
                                        BorderRadius.circular(
                                            width * 0.02),
                                        boxShadow: const [
                                          BoxShadow(
                                            offset: Offset(0, 3),
                                            color: Color.fromARGB(
                                                255, 110, 169, 134),
                                          ),
                                        ],
                                      )
                                          : null,
                                      child: Text(
                                        'Accident Risk Level',
                                        style: TextStyle(
                                          fontFamily: 'OpunMai',
                                          fontSize: height * 0.02,
                                          fontWeight: FontWeight.w700,
                                          color: _currentScoringIndex == 1
                                              ? Color.fromARGB(255, 71, 82, 98)
                                              : Color.fromARGB(
                                              255, 173, 162, 153),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //SAFETY SCORE LABEL
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //LABEL TEXT
                                Flexible(
                                  flex: 2,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    padding:
                                    EdgeInsets.only(left: width * 0.05),
                                    child: FittedBox(
                                      child: Text(
                                        'Risk Level',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'OpunMai',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                          color:
                                          Color.fromARGB(255, 71, 82, 98),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                //LABEL TEXT FIELD
                                Flexible(
                                  flex: 4,
                                  child: Row(
                                    children: [
                                      //LOW STATUS
                                      Flexible(
                                        child: InkWell(
                                          onTap: () {
                                            markerColor = Colors.yellow;
                                            borderColor = Colors.yellow.shade500;
                                            riskLevel = "Low";
                                            _onRiskLevelTapped(0);
                                          },
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          child: Container(
                                            color: _currentRiskIndex == 0
                                                ? Colors.grey.shade300
                                                : Colors.transparent,
                                            child: Column(
                                              children: [
                                                //COLORED TILES
                                                Flexible(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsets.symmetric(
                                                      vertical: height * 0.005,
                                                      horizontal: width * 0.05,
                                                    ),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .yellowAccent
                                                            .shade200,
                                                        border: Border.all(
                                                          color: Color.fromARGB(
                                                              255, 71, 82, 98),
                                                        ),
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            width *
                                                                0.01),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                //LOW
                                                Flexible(
                                                  child: FittedBox(
                                                    child: Text(
                                                      'Low',
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontFamily: 'OpunMai',
                                                        fontWeight:
                                                        FontWeight.w700,
                                                        fontSize: 18,
                                                        color: Color.fromARGB(
                                                            255, 71, 82, 98),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      //MODERATE STATUS
                                      Flexible(
                                        child: InkWell(
                                          onTap: () {
                                            markerColor = Colors.orange;
                                            borderColor = Colors.orange.shade500;
                                            riskLevel = "Moderate";
                                            _onRiskLevelTapped(1);
                                          },
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          child: Container(
                                            color: _currentRiskIndex == 1
                                                ? Colors.grey.shade300
                                                : Colors.transparent,
                                            child: Column(
                                              children: [
                                                //COLORED TILES
                                                Flexible(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsets.symmetric(
                                                      vertical: height * 0.005,
                                                      horizontal: width * 0.05,
                                                    ),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .orange.shade400,
                                                        border: Border.all(
                                                          color: Color.fromARGB(
                                                              255, 71, 82, 98),
                                                        ),
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            width *
                                                                0.01),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                //MODERATE
                                                Flexible(
                                                  child: FittedBox(
                                                    child: Text(
                                                      'Moderate',
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontFamily: 'OpunMai',
                                                        fontWeight:
                                                        FontWeight.w700,
                                                        fontSize: 18,
                                                        color: Color.fromARGB(
                                                            255, 71, 82, 98),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      //HIGH STATUS
                                      Flexible(
                                        child: InkWell(
                                          onTap: () {
                                            markerColor = Colors.red;
                                            borderColor = Colors.red.shade500;
                                            riskLevel = "High";
                                            _onRiskLevelTapped(2);
                                          },
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          child: Container(
                                            color: _currentRiskIndex == 2
                                                ? Colors.grey.shade300
                                                : Colors.transparent,
                                            child: Column(
                                              children: [
                                                //COLORED TILES
                                                Flexible(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsets.symmetric(
                                                      vertical: height * 0.005,
                                                      horizontal: width * 0.05,
                                                    ),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                        Colors.red.shade700,
                                                        border: Border.all(
                                                          color: Color.fromARGB(
                                                              255, 71, 82, 98),
                                                        ),
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            width *
                                                                0.01),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                //HIGH
                                                Flexible(
                                                  child: FittedBox(
                                                    child: Text(
                                                      'High',
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontFamily: 'OpunMai',
                                                        fontWeight:
                                                        FontWeight.w700,
                                                        fontSize: 18,
                                                        color: Color.fromARGB(
                                                            255, 71, 82, 98),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //LOCATION LABEL TEXT FIELD
                                Flexible(
                                  flex: 4,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.1),
                                    child: Container(
                                      width: width,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color:
                                            Color.fromARGB(255, 71, 82, 98),
                                            width: 3.5,
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: width * 0.01,
                                          bottom: 5,
                                        ),
                                        child: Text(
                                          DependencyInjector().locator<SafeConnexSafetyScoringDatabase>().geocodedStreet != null ? DependencyInjector().locator<SafeConnexSafetyScoringDatabase>().geocodedStreet! : "No Location Data",
                                          style: TextStyle(
                                            fontFamily: 'OpunMai',
                                            fontSize: height * 0.022,
                                            fontWeight: FontWeight.w700,
                                            color: Color.fromARGB(
                                                255, 173, 162, 153),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(
                //     bottom: MediaQuery.of(context).viewInsets.bottom,
                //   ),
                // ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: height * 0.08,
          color: Color.fromARGB(255, 71, 82, 98),
          child: Row(
            children: [
              //CANCEL BUTTON
              Expanded(
                child: Container(
                  height: height * 0.08,
                  color: Color.fromARGB(255, 81, 97, 112),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.cancel_outlined),
                    color: Color.fromARGB(255, 227, 230, 229),
                    iconSize: width * 0.125,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                  ),
                ),
              ),
              //EDIT || SAVE LOCATION BUTTON
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        DependencyInjector().locator<SafeConnexSafetyScoringDatabase>().addSafetyScore(tapLocation!.latitude, tapLocation!.longitude, _sliderValue, riskLevel!, riskInfo!);
                        Navigator.pop(context);
                      });
                    },
                    elevation: 2,
                    height: height * 0.045,
                    color: const Color.fromARGB(255, 121, 192, 148),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(width * 0.2),
                    ),
                    child: Text(
                      'save',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'OpunMai',
                        fontSize: height * 0.025,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}