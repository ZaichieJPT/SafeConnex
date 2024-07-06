import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_circle_database.dart';

class SafeConnexGeolocation{
  final dbReference = FirebaseFirestore.instance;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _listener;
  static List<Map<String, dynamic>> coordinatesData = [];
  String? geocodedStreet;
  SafeConnexCircleDatabase circleDatabase = SafeConnexCircleDatabase();

  SafeConnexGeolocation(){
    dbReference.settings = const Settings(
        persistenceEnabled: true
    );
  }

  void setCoordinates(double latitude, double longitude, String currentUser){
    final coordinates = <String, double>{
      "latitude": latitude,
      "longitude": longitude,
    };

    dbReference.collection("geoCoordinates").doc(currentUser).set(coordinates, SetOptions(merge: true)).onError((error, stackTrace) => print("Failed to add data to firestore"));
  }

  void getCoordinates() async {
    final snapshot = dbReference.collection("geoCoordinates");
    snapshot.snapshots(includeMetadataChanges: true).listen(
        (event){
        circleDatabase.getCircleDataForLocation(DependencyInjector().locator<SafeConnexCircleDatabase>().currentCircleCode!).whenComplete(() async {
          if(coordinatesData.isEmpty){
            for (var docs in event.docs){
              for (var index in DependencyInjector().locator<SafeConnexCircleDatabase>().locationCircleData){
                if(index["id"] == docs.id){
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
              for (var index in DependencyInjector().locator<SafeConnexCircleDatabase>().locationCircleData){
                if(index["id"] == docs.id){
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