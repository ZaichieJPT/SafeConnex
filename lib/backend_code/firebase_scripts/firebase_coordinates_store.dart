import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_circle_database.dart';

class FlutterFireCoordinates {
  final dbReference = FirebaseFirestore.instance;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _listener;
  static List<Map<String, dynamic>> coordinatesData = [];
  String? geocodedStreet;
  CircleDatabaseHandler circleDatabase = CircleDatabaseHandler();

  FlutterFireCoordinates(){
    dbReference.settings = const Settings(
        persistenceEnabled: true
    );
  }

  addCoordinates(double latitude, double longitude, String currentUser){
    final coordinates = <String, double>{
      "latitude": latitude,
      "longitude": longitude,
    };

    dbReference.collection("geoCoordinates").doc(currentUser).set(coordinates, SetOptions(merge: true)).onError((error, stackTrace) => print("Failed to add data to firestore"));
    print("Data Added to Firestore");
  }

  getCoordinates() {
    final snapshot = dbReference.collection("geoCoordinates");
    _listener = snapshot.snapshots(includeMetadataChanges: true).listen(
      (event){
        int index = 0;
        circleDatabase.getCircleDataForLocation(CircleDatabaseHandler.currentCircleCode!).whenComplete(() async {
          if(coordinatesData.isEmpty){
            for (var docs in event.docs){
              for (var indx in CircleDatabaseHandler.locationCircleData){
                if(indx["id"] == docs.id){
                  List<Placemark> placemarks = await placemarkFromCoordinates(docs.data()["latitude"], docs.data()["longitude"]);
                  coordinatesData.add(
                      {
                        "userId": docs.id,
                        "latitude": docs.data()["latitude"],
                        "longitude": docs.data()["longitude"],
                        "geocoded": placemarks[0].street
                      }
                  );
                }
              }
            }

            print(coordinatesData.length);
          }
          else if(coordinatesData.isNotEmpty) {
            coordinatesData.clear();
            for (var docs in event.docs) {
              for (var indx in CircleDatabaseHandler.locationCircleData){
                if(indx["id"] == docs.id){
                  List<Placemark> placemarks = await placemarkFromCoordinates(docs.data()["latitude"], docs.data()["longitude"]);
                  coordinatesData.add(
                      {
                        "userId": docs.id,
                        "latitude": docs.data()["latitude"],
                        "longitude": docs.data()["longitude"],
                        "geocoded": placemarks[0].street
                      }
                  );
                }
              }
            }
          }
        });
      },
       onError: (error) => print(error),
    );
  }
}