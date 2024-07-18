
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_init.dart';

class SafeConnexLocationHistory{
  DatabaseReference _dbLocationHistoryReference = FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("location_history");

  List<Map<String, dynamic>> locationHistoryData = [];
  String? geocodedStreet;

  Future<void> getGeocode(LatLng location) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(location.latitude, location.longitude);
    geocodedStreet = placemarks[0].street;
  }

  Future<void> deleteHistory(String userId) async {
    DataSnapshot historySnapshot = await _dbLocationHistoryReference.child(userId).get();

    String startingChild = (historySnapshot.children.first.key).toString();
    print("test ${startingChild}");
    print("test ${historySnapshot.children.length}");
    if(historySnapshot.children.length > 10){
      await _dbLocationHistoryReference.child(userId).child(startingChild).remove();
    }
  }

  Future<void> addDataToLocationHistory(String userId, DateTime time, String date) async {
    DataSnapshot historySnapshot = await _dbLocationHistoryReference.child(userId).get();

    if(historySnapshot.exists){
      String numberOfChild = (int.parse(historySnapshot.children.last.key!) + 1).toString();

      if(historySnapshot.child(historySnapshot.children.last.key!).child("location").value == geocodedStreet){
        await _dbLocationHistoryReference.child(userId).child(historySnapshot.children.last.key!).update({
          "time": DateFormat.jm().format(time),
          "date": date,
        });
      }else{
        await _dbLocationHistoryReference.child(userId).child(numberOfChild).set({
          "location": geocodedStreet,
          "time": DateFormat.jm().format(time),
          "date": date,
        });
      }

      deleteHistory(userId);
    }else{
      await _dbLocationHistoryReference.child(userId).child("0").set({
        "location": geocodedStreet,
        "time": DateFormat.jm().format(time),
        "date": date,
      });
    }

  }

  Future<void> getDataFromLocationHistory(String userId) async {
    DataSnapshot historySnapshot = await _dbLocationHistoryReference.child(userId).get();

    if(historySnapshot.exists){
      if(locationHistoryData.isEmpty){
        for(var history in historySnapshot.children)
          locationHistoryData.add({
            "location": history.child("location").value,
            "time": history.child("time").value,
            "date": history.child("date").value,
          });
      }else if(locationHistoryData.isNotEmpty){
        locationHistoryData.clear();
        for(var history in historySnapshot.children)
          locationHistoryData.add({
            "location": history.child("location").value,
            "time": history.child("time").value,
            "date": history.child("date").value,
          });
      }
    }
  }
}