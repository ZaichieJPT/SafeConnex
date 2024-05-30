

import 'package:firebase_database/firebase_database.dart';

import 'firebase_init.dart';

class GeofenceDatabase{
  DatabaseReference dbGeofenceReference = FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("geofence");
  List<Map<String, dynamic>> geofenceData = [];
  Map<String, dynamic> geofenceToUpdate = {};

  deleteGeofence(String circleName){
    dbGeofenceReference.child(circleName).child(geofenceToUpdate['radiusId']).remove();
    print("Database Removed");
  }

  addGeofence(String id, double latitude, double longitude, String radiusId, double radiusSize, String circleName, String addressLabel){
    final geofence = <String, dynamic> {
      "id": id,
      "latitude": latitude,
      "longitude": longitude,
      "radiusId": radiusId,
      "radiusSize": radiusSize,
      "addressLabel": addressLabel
    };

    deleteGeofence(geofenceToUpdate["circleName"]);
    dbGeofenceReference.child(circleName).child(radiusId).set(geofence);
    print("Data Added on Geofence Collection");
  }

  getGeofence(String circleName){
    dbGeofenceReference.child(circleName).onValue.listen((DatabaseEvent event){
      final snapshot = event.snapshot;
      for(var data in snapshot.children)
      {
        geofenceData.add(<String, dynamic>{
          "id": data.child("id").value,
          "latitude":  data.child("latitude").value,
          "longitude":  data.child("longitude").value,
          "radiusId":  data.child("radiusId").value,
          "radiusSize":  data.child("radiusSize").value,
          "addressLabel":  data.child("addressLabel").value
        });
      }
    });
  }
}