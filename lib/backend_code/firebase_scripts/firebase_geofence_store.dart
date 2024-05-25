import 'package:cloud_firestore/cloud_firestore.dart';

class FlutterFireGeofence{
  final dbReference = FirebaseFirestore.instance;

  addGeofence(String id, double latitude, double longitude, String radiusId, double radiusSize, String circleName){
    final geofence = <String, dynamic> {
      "id": id,
      "latitude": latitude,
      "longitude": longitude,
      "radiusId": radiusId,
      "radiusSize": radiusSize,
    };

    dbReference.collection("geofence").doc(circleName).set(geofence).onError((error, stackTrace) => print("Error on Geofence"));
    print("Data Added on Geofence Collection");
  }

  getGeofence(String circleName){
    dbReference.collection("geofence").doc(circleName).snapshots(includeMetadataChanges: true).listen(
        (event) {
          //do something with event.data()
          print(event.data()!['latitude']);
        }
    );
  }
}