import 'package:firebase_database/firebase_database.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_init.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_authentication.dart';

class SafeConnexGeofenceDatabase{
  DatabaseReference dbGeofenceReference = FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("geofence");

  List<Map<String, dynamic>> geofenceData = [];
  Map<String, dynamic> geofenceToUpdate = {};

  addGeofence(double latitude, double longitude, String radiusId, double radiusSize, String circleCode, String addressLabel){
    final geofence = <String, dynamic> {
      "id": DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.uid,
      "latitude": latitude,
      "longitude": longitude,
      "radiusId": radiusId,
      "radiusSize": radiusSize,
      "addressLabel": addressLabel
    };

    if(geofenceToUpdate.isNotEmpty){
      print(geofenceToUpdate);
      deleteGeofence(circleCode);
    }
    dbGeofenceReference.child(circleCode).child(radiusId).set(geofence);
    print("Data Added on Geofence Collection");
  }

  deleteGeofence(String circleCode){
    dbGeofenceReference.child(circleCode).child(geofenceToUpdate['radiusId']).remove();
    print("Database Removed");
  }

  Future<void> getGeofence(String circleCode) async {
    dbGeofenceReference.child(circleCode).onValue.listen((DatabaseEvent event){
      final snapshot = event.snapshot;
      if(snapshot.exists){
        if(geofenceData.isEmpty){
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
        }else if(geofenceData.isNotEmpty){
          geofenceData.clear();
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
        }
      }
      else{
        print("No Data");
      }
    });
  }
}