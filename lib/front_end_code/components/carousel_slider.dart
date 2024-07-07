// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_circle_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_firestore.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_storage.dart';

class CarouseSliderComponent extends StatefulWidget {
  const CarouseSliderComponent({super.key});

  @override
  State<CarouseSliderComponent> createState() => _CarouseSliderComponentState();
}

class _CarouseSliderComponentState extends State<CarouseSliderComponent> {
  bool _checkIfProfileExist() {
    for (var profile in DependencyInjector().locator<SafeConnexCircleDatabase>().circleDataValue) {
      if (profile["image"] != null) {
        return true;
      }
    }
    return false;
  }

  bool _checkIfGeocodeExist() {
    for (var geocodes in DependencyInjector().locator<SafeConnexGeolocation>().coordinatesData) {
      if (geocodes["geocoded"] != null) {
        return true;
      }
    }
    return false;
  }

  String _getGeocodeValue(String userId) {
    for (var geocodes in DependencyInjector().locator<SafeConnexGeolocation>().coordinatesData) {
      if (geocodes["userId"] == userId) {
        return geocodes["geocoded"];
      }
    }
    return "No Name";
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return CarouselSlider(
      options: CarouselOptions(
        height: height * 0.54,
        viewportFraction: 0.68,
        enlargeCenterPage: true,
        enlargeFactor: 0.55,
        initialPage: 0,
        enableInfiniteScroll: true,
        enlargeStrategy: CenterPageEnlargeStrategy.zoom,
      ),
      items: DependencyInjector().locator<SafeConnexCircleDatabase>().circleDataValue.map((userData) {
        return Builder(
          builder: (BuildContext context) {
            return Stack(
              children: [
                Container(
                  width: width * 0.65,
                  //color: Colors.grey,
                ),
                //MAIN CONTAINER
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: height * 0.44,
                    width: width * 0.65,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(width * 0.1),
                      border: Border.all(
                        color: Colors.lightGreenAccent.shade700,
                        width: width * 0.015,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: height * 0.1),
                          ),
                          //USERNAME
                          Text(
                            "${userData["name"]}",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'OpunMai',
                              fontWeight: FontWeight.w700,
                              fontSize: height * 0.035,
                              color: Color.fromARGB(255, 62, 73, 101),
                            ),
                          ),
                          //USER'S CIRCLE ROLE
                          Text(
                            "${userData["role"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'OpunMai',
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: Color.fromARGB(255, 62, 73, 101),
                            ),
                          ),
                          //SAFETY STATUS
                          Row(
                            children: [
                              Text(
                                'Safety Status: ',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'OpunMai',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 62, 73, 101),
                                ),
                              ),
                              //COLOR CODE
                              Container(
                                height: height * 0.02,
                                width: width * 0.06,
                                decoration: BoxDecoration(
                                  color: Colors.lightGreenAccent.shade700,
                                  borderRadius:
                                  BorderRadius.circular(width * 0.015),
                                  border: Border.all(
                                    color: Color.fromARGB(255, 62, 73, 101),
                                    width: 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //CURRENT LOCATION TEXT
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Current Location: ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'OpunMai',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color.fromARGB(255, 62, 73, 101),
                              ),
                            ),
                          ),
                          //LOCATION CONTAINER
                          Container(
                            alignment: Alignment.center,
                            height: height * 0.03,
                            width: width,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius:
                              BorderRadius.circular(width * 0.015),
                              border: Border.all(
                                color: Color.fromARGB(255, 62, 73, 101),
                                width: 1.5,
                              ),
                            ),
                            child: Text(
                              _getGeocodeValue(userData["id"]),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'OpunMai',
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: Color.fromARGB(255, 62, 73, 101),
                              ),
                            ),
                          ),
                          //EMAIL TEXT
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Email Address: ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'OpunMai',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color.fromARGB(255, 62, 73, 101),
                              ),
                            ),
                          ),
                          //EMAIL CONTAINER
                          Container(
                            alignment: Alignment.center,
                            height: height * 0.03,
                            width: width,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius:
                              BorderRadius.circular(width * 0.015),
                              border: Border.all(
                                color: Color.fromARGB(255, 62, 73, 101),
                                width: 1.5,
                              ),
                            ),
                            child: Text(
                              "${userData["email"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'OpunMai',
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: Color.fromARGB(255, 62, 73, 101),
                              ),
                            ),
                          ),
                          //PHONE NUMBER TEXT
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Phone Number: ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'OpunMai',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color.fromARGB(255, 62, 73, 101),
                              ),
                            ),
                          ),
                          //PHONE NUMBER CONTAINER
                          Container(
                            alignment: Alignment.center,
                            height: height * 0.03,
                            width: width,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius:
                              BorderRadius.circular(width * 0.015),
                              border: Border.all(
                                color: Color.fromARGB(255, 62, 73, 101),
                                width: 1.5,
                              ),
                            ),
                            child: Text(
                              "${userData["phoneNumber"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'OpunMai',
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: Color.fromARGB(255, 62, 73, 101),
                              ),
                            ),
                          ),
                          //VIEW LOCATION HISTORY
                          Padding(
                            padding:
                            EdgeInsets.symmetric(vertical: height * 0.005),
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                'View Location History',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                  Color.fromARGB(255, 62, 73, 101),
                                  decorationThickness: 3,
                                  fontFamily: 'OpunMai',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 62, 73, 101),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: width * 0.2,
                    height: height * 0.19,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: width * 0.015,
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, height * 0.015),
                          blurRadius: width * 0.06,
                          color: Colors.grey.shade400,
                        ),
                      ],
                    ),
                    child: _checkIfProfileExist()
                        ? Image.network(DependencyInjector().locator<SafeConnexProfileStorage>().imageUrl!)
                        : null,
                  ),
                ),
              ],
            );
          },
        );
      }).toList(),
    );
  }
}