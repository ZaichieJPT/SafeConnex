
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_circle_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_profile_storage.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_auth.dart';

import '../../backend_code/firebase_scripts/firebase_coordinates_store.dart';

class CarouseSliderComponent extends StatefulWidget {
  const CarouseSliderComponent({super.key});


  @override
  State<CarouseSliderComponent> createState() => _CarouseSliderComponentState();
}

class _CarouseSliderComponentState extends State<CarouseSliderComponent> {
  FirebaseAuthHandler authHandler = FirebaseAuthHandler();
  CircleDatabaseHandler circleDatabase = CircleDatabaseHandler();

  bool _checkIfProfileExist(){
    for(var profile in CircleDatabaseHandler.circleDataValue){
      if(profile["image"] != null){
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CarouselSlider(
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height,
          enlargeCenterPage: true,
          enlargeFactor: 0.43,
          viewportFraction: 0.6,
          //aspectRatio: 0.1
        ),
        items: CircleDatabaseHandler.circleDataValue.map((userData){
          return Builder(
            builder: (BuildContext context){
              return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Positioned(
                          height: 380,
                          width: 250,
                          top: 230,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.lightGreenAccent.shade700,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          )
                      ),
                      Positioned(
                        height: 363,
                        width: 230,
                        left: 8.5,
                        top: 238,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 145,
                        left: 42,
                        width: 160,
                        height: 160,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 60,
                                  offset: Offset(0, 9)
                              )
                            ],
                          ),
                          child: _checkIfProfileExist() ? Image.network(FirebaseProfileStorage.imageUrl!) : Container(color:Colors.white),
                        ),
                      ),
                      Positioned(
                        top:340,
                        left: 8,
                        width: 230,
                        child: Column(
                          children: [
                            Material(
                              type: MaterialType.transparency,
                              child: Text(
                                "${userData["name"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.blueGrey.shade800,
                                    fontSize: 23,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                            Material(
                              type: MaterialType.transparency,
                              child: Text(
                                "${userData["role"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.blueGrey.shade800,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top:410,
                        width: 230,
                        left: 12,
                        child: Material(
                          type: MaterialType.transparency,
                          child: Text(
                            "Safety Status:",
                            style: TextStyle(
                              color: Colors.blueGrey.shade800,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top:430,
                        left: 12,
                        width: 230,
                        child: Material(
                          type: MaterialType.transparency,
                          child: Text(
                            "Current Location:",
                            style: TextStyle(
                              color: Colors.blueGrey.shade800,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 15,
                        top: 450,
                        child: Container(
                          height: 22,
                          width: 212,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.blueGrey.shade800,
                                width: 2
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Material(
                              child: Text(
                                "Wala Muna",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.blueGrey.shade800,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600
                                ),
                              )),
                        ),
                      ),
                      Positioned(
                        top:475,
                        width: 230,
                        left: 12,
                        child: Material(
                          type: MaterialType.transparency,
                          child: Text(
                            "Email Account:",
                            style: TextStyle(
                              color: Colors.blueGrey.shade800,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 495,
                        left: 15,
                        child: Container(
                          height: 22,
                          width: 212,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.blueGrey.shade800,
                                width: 2
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Material(
                              child: Text(
                                "${userData["email"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.blueGrey.shade800,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600
                                ),
                              )),
                        ),
                      ),
                      Positioned(
                        top:520,
                        left: 12,
                        child: Material(
                          type: MaterialType.transparency,
                          child: Text(
                            "Phone Number:",
                            style: TextStyle(
                              color: Colors.blueGrey.shade800,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 540,
                        left: 15,
                        child: Container(
                          height: 22,
                          width: 212,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.blueGrey.shade800,
                                width: 2
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Material(
                              child: Text(
                                "${userData["phoneNumber"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.blueGrey.shade800,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600
                                ),
                              )
                          ),
                        ),
                      ),
                      Positioned(
                        top: 560,
                        width: 230,
                        left: 11,
                        child: TextButton(
                          onPressed: (){},
                          child: Text(
                            "View Location History",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.blueGrey.shade800
                            ),
                          ),
                        ),
                      )
                    ],
                  )
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
