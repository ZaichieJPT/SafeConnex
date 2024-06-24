import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cache/flutter_map_cache.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geofence_service/geofence_service.dart' as geofence;
import 'package:latlong2/latlong.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_auth.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_circle_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_coordinates_store.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_geofence_store.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_profile_storage.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_authentication.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_firestore.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_storage.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class UserMapProvider extends StatefulWidget {
  const UserMapProvider({super.key, this.isButtonPressed});

  final bool? isButtonPressed;

  @override
  State<UserMapProvider> createState() => UserMapProviderState();
}

class UserMapProviderState extends State<UserMapProvider> {
  //String currentAddress = 'My Address';
  final _activityStreamController = StreamController<geofence.Activity>();
  final _geofenceStreamController = StreamController<geofence.Geofence>();
  Map<String, dynamic>? _location = {
    "latitude": 37.44630,
    "longitude": -122.121930
  };

  List<Marker> geolocationMarkers = [];
  List<CircleMarker> circleMarker = [];
  int index = 0;

  SafeConnexGeolocation geolocation = SafeConnexGeolocation();
  final MapController _mapController = MapController();
  List<geofence.Geofence> _geofenceList = [];

  final _geofenceService = geofence.GeofenceService.instance.setup(
      interval: 5000,
      accuracy: 2000,
      loiteringDelayMs: 60000,
      statusChangeDelayMs: 10000,
      useActivityRecognition: true,
      allowMockLocations: false,
      printDevLog: false,
      geofenceRadiusSortType: geofence.GeofenceRadiusSortType.DESC
  );

  Future<void> getGeofenceData() async {
    for(var geofenceData in SafeConnexGeofenceDatabase.geofenceData){
      // there is no place label
      _geofenceList.add(geofence.Geofence(
        id: geofenceData["addressLabel"],
        latitude: geofenceData["latitude"],
        longitude: geofenceData["longitude"],
        radius: [
          geofence.GeofenceRadius(id: geofenceData["radiusId"], length: double.parse(geofenceData["radiusSize"].toString()))
        ]
      ));
      Future.delayed(Duration(milliseconds: 2500), (){
        addCircleMarker(LatLng(double.parse(geofenceData["latitude"].toString()), double.parse(geofenceData["longitude"].toString())), double.parse(geofenceData["radiusSize"].toString()));
      });
    }
  }

  Future<void> _onGeofenceStatusChanged(geofence.Geofence geofencing, geofence.GeofenceRadius geofenceRadius, geofence.GeofenceStatus geofenceStatus, geofence.Location location) async {

    print("geofence: ${geofencing.toJson()}");
    print("geofenceRadius: ${geofenceRadius.toJson()}");
    print("geofenceStatus: ${geofenceStatus.toString()}");
    _geofenceStreamController.sink.add(geofencing);
  }

  void _onActivityChanged(geofence.Activity preActivity, geofence.Activity curActivity){
    print('preActivity: ${preActivity.toJson()}');
    print('preActivity: ${curActivity.toJson()}');
    _activityStreamController.sink.add(curActivity);
  }

  void _onLocationChanged(geofence.Location location){
    Future.delayed(Duration(milliseconds: 400), (){
      setState(() {
        _location = location.toJson();
      });
    });

    print('location: ${location.toJson()}');
  }

  void _onLocationServicesStatusChanged(bool status){
    print('isLocationServicesEnabled: $status');
  }

  void _onError(error){
    final errorCode = geofence.getErrorCodesFromError(error);
    if (errorCode == null){
      print("Undefined error: $error");
      return;
    }

    print("ErrorCode: $errorCode");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    geolocation.getCoordinates();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _geofenceService.addGeofenceStatusChangeListener(_onGeofenceStatusChanged);
      _geofenceService.addLocationChangeListener(_onLocationChanged);
      _geofenceService.addActivityChangeListener(_onActivityChanged);
      _geofenceService.addLocationServicesStatusChangeListener(_onLocationServicesStatusChanged);
      _geofenceService.addStreamErrorListener(_onError);
      _geofenceService.start(_geofenceList).catchError(_onError);
    });


  }

  @override
  Widget build(BuildContext context) {
    return geofence.WillStartForegroundTask(
      onWillStart: () async {
        return _geofenceService.isRunningService;
      },
      androidNotificationOptions: geofence.AndroidNotificationOptions(
        channelId: 'geofence_service_notification_channel',
        channelName: 'Geofence Service Notification',
        channelDescription: 'This notification appears when geofence service is running',
        channelImportance: geofence.NotificationChannelImportance.LOW,
        priority: geofence.NotificationPriority.LOW,
        isSticky: false,
      ),
      iosNotificationOptions: const geofence.IOSNotificationOptions(),
      foregroundTaskOptions: const geofence.ForegroundTaskOptions(),
      notificationTitle: "Geofence Service is running",
      notificationText: 'Tap to return to the app',
      child: Scaffold(
          body: _buildMonitor()
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _activityStreamController.close();
    _geofenceStreamController.close();
    super.dispose();
  }

  bool _checkIfProfileExist(){
    for(var profile in SafeConnexCircleDatabase.circleDataValue){
      if(profile["image"] != null){
        return true;
      }
    }
    return false;
  }

  addCircleMarker(LatLng markerLocation, double radiusSize){
    circleMarker.add(CircleMarker(
        color: Colors.blue.shade300.withOpacity(0.2),
        borderColor: Colors.blue.shade500,
        borderStrokeWidth: 2,
        point: markerLocation,
        radius: radiusSize,
        useRadiusInMeter: true
    ));
  }

  addGeolocationMarker(int index){
    geolocationMarkers.add(Marker(
        height: 50,
        width: 50,
        rotate: true,
        alignment: Alignment.topCenter,
        point: LatLng(SafeConnexGeolocation.coordinatesData[index]['latitude'], SafeConnexGeolocation.coordinatesData[index]['longitude']),
        child: Stack(
          children: [
            Positioned(
                child: Icon(Icons.location_pin, size: 55, color: Colors.blue,)
            ),
            Positioned(
              top: 10,
              left: 16,
              child: Container(
                width: 23,
                height: 23,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                ),
                child: _checkIfProfileExist() ? Image.network(SafeConnexProfileStorage.imageUrl!) : Container(color:Colors.white),
              ),
            )
          ],
        )
    ));
    print("Geocoded: ${SafeConnexGeolocation.coordinatesData[index]["geocoded"]}");
    setState(() {});
  }

  getLocation(){
    setState(() {
      _mapController.move(LatLng(_location!['latitude'], _location!['longitude']), 14.2);
      //print("InClass" + SafeConnexGeolocation.coordinatesData[1]['userId']);
      //print(SafeConnexGeolocation.coordinatesData[1]["location"]);
    });
  }

  Widget _buildMonitor() {
    geolocationMarkers.clear();
    index = 0;

    Future.delayed(Duration(milliseconds: 400), (){
      circleMarker.clear();
      geolocation.setCoordinates(_location!['latitude'], _location!['longitude'], SafeConnexAuthentication.currentUser!.uid);
      getGeofenceData();
    });

    for(index; index < SafeConnexGeolocation.coordinatesData.length; index++){
      addGeolocationMarker(index);
    }

    return StreamBuilder<geofence.Activity>(
        stream: _activityStreamController.stream,
        builder: (context, snapshot) {
          final activityUpdatedDateTime = DateTime.now();
          final activityContent = snapshot.data?.toJson().toString() ?? '';

          return StreamBuilder<geofence.Geofence>(
            stream: _geofenceStreamController.stream,
            builder: (context, snapshot) {
              final geofencingUpdatedDateTime = DateTime.now();
              final geofencingContent = snapshot.data?.toJson().toString() ?? '';

              print("Activity: $activityContent");
              print("Geofence: $geofencingContent");
              return Scaffold(
                body: Stack(
                  children: [
                    FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        initialCenter: LatLng(16.0265, 120.3363),
                        initialZoom: 13.2,
                        onMapReady: (){
                          print("ready");
                        }
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.safeconnex.app',
                          tileProvider: CachedTileProvider(
                            store: MemCacheStore(),
                          ),
                        ),
                        MarkerLayer(
                            markers: geolocationMarkers
                        ),
                        CircleLayer(
                          circles: circleMarker,
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }
    );
  }
}