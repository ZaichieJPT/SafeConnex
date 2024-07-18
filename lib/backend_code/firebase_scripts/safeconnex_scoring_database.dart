import 'package:firebase_database/firebase_database.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_init.dart';

class SafeConnexSafetyScoringDatabase{
  DatabaseReference _dbSafetyScoreReference = FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("safety_score");

  List<Map<String, dynamic>> safetyScoreData = [];
  Map<String, dynamic> safetyScoreToUpdate = {};
  String? geocodedStreet;
  bool? isMapSwitched = true;

  Future<void> getGeocode(LatLng location) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(location.latitude, location.longitude);
    geocodedStreet = placemarks[0].street;
  }

  Future<void> addSafetyScore(double latitude, double longitude, double radiusSize, String riskLevel, String riskInfo) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

    final newSafetyScoreId = _dbSafetyScoreReference.push().key;

    final safetyScore = <String, dynamic> {
      "latitude": latitude,
      "longitude": longitude,
      "radiusId": newSafetyScoreId,
      "radiusSize": radiusSize,
      "locationName": placemarks[0].street,
      "riskInfo" : riskInfo,
      "riskLevel": riskLevel
    };

    if(safetyScoreToUpdate.isNotEmpty){
      print(safetyScoreToUpdate);
      deleteSafetyScore();
    }
    _dbSafetyScoreReference.child(newSafetyScoreId!).update(safetyScore);
    print("Data Added on SafetyScore Collection");
  }

  Future<void> editSafetyScore(String safetyScoreId, double latitude, double longitude, double radiusSize, String riskLevel, String riskInfo) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

    final safetyScore = <String, dynamic> {
      "latitude": latitude,
      "longitude": longitude,
      "radiusId": safetyScoreId,
      "radiusSize": radiusSize,
      "locationName": placemarks[0].street,
      "riskInfo" : riskInfo,
      "riskLevel": riskLevel
    };

    _dbSafetyScoreReference.child(safetyScoreId).update(safetyScore);
    print("Data Added on SafetyScore Collection");
  }

  deleteSafetyScore(){
    _dbSafetyScoreReference.child(safetyScoreToUpdate['radiusId']).remove();
    print("Database Removed");
  }

  Future<void> getSafetyScore() async {
    _dbSafetyScoreReference.onValue.listen((DatabaseEvent event){
      final snapshot = event.snapshot;
      print(snapshot.value);
      if(snapshot.exists){
        if(safetyScoreData.isEmpty){
          for(var data in snapshot.children)
          {
            safetyScoreData.add(<String, dynamic>{
              "latitude":  data.child("latitude").value,
              "longitude":  data.child("longitude").value,
              "radiusId":  data.child("radiusId").value,
              "radiusSize":  data.child("radiusSize").value,
              "locationName": data.child("locationName").value,
              "riskInfo": data.child("riskInfo").value,
              "riskLevel": data.child("riskLevel").value
            });
          }
        }else if(safetyScoreData.isNotEmpty){
          safetyScoreData.clear();
          for(var data in snapshot.children)
          {
            safetyScoreData.add(<String, dynamic>{
              "latitude":  data.child("latitude").value,
              "longitude":  data.child("longitude").value,
              "radiusId":  data.child("radiusId").value,
              "radiusSize":  data.child("radiusSize").value,
              "locationName": data.child("locationName").value,
              "riskInfo": data.child("riskInfo").value,
              "riskLevel": data.child("riskLevel").value
            });
          }
        }
      }
      else{
        print("No Data");
      }
    });
  }
}