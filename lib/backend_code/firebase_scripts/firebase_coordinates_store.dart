import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:safeconnex/backend_code/geocode_coordinates.dart';

class FlutterFireCoordinates {
  final dbReference = FirebaseFirestore.instance;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _listener;
  List<Map<String, dynamic>> coordinatesData = [];
  GeocodeCoordinates geocoded = GeocodeCoordinates();

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

  getCoordinates(){
    final snapshot = dbReference.collection("geoCoordinates");
    _listener = snapshot.snapshots(includeMetadataChanges: true).listen(
      (event) {
        //coordinatesData.add({"markerCount": event.docs.length});
        if(coordinatesData.isEmpty){
          for (var docs in event.docs){
            coordinatesData.add(
                {
                  "userId": docs.id,
                  "latitude": docs.data()["latitude"],
                  "longitude": docs.data()["longitude"],
                }
            );
          }
        }
        else if(coordinatesData.isNotEmpty) {
          coordinatesData.clear();
          for (var docs in event.docs) {
            coordinatesData.add(
                {
                  "userId": docs.id,
                  "latitude": docs.data()["latitude"],
                  "longitude": docs.data()["longitude"],
                }
            );
          }
        }
      },
       onError: (error) => print(error),
    );
  }
}