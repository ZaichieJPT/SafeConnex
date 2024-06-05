import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

class GeocodeCoordinates{
  static List<String> currentAddress = [];

  geocodeCoordinates(LatLng coordinates) async {
    try{
      List<Placemark> placemarks = await placemarkFromCoordinates(coordinates.latitude, coordinates.longitude);
      Placemark place = placemarks[0];
      currentAddress.add(place.street!);
    }catch(e){
      print(e);
    }
  }
}