import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cache/flutter_map_cache.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geofence_service/geofence_service.dart' as geofence;
import 'package:latlong2/latlong.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_authentication.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_circle_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_firestore.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_geofence_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_location_history.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_scoring_database.dart';
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

  //SafeConnexGeolocation geolocation = SafeConnexGeolocation();
  final MapController _mapController = MapController();
  List<geofence.Geofence> _geofenceList = [];

  List<geofence.Geofence> _safetyScoreList = [];
  Color riskLevelColor = Colors.green.shade200;
  Color riskLevelBorderColor = Colors.green.shade500;

  static Timer _locationHistoryTimer = Timer.periodic(Duration(minutes: 15), (timer){
    DependencyInjector().locator<SafeConnexLocationHistory>().addDataToLocationHistory(
        DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.uid,
        DateTime.now(),
        "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}");
  });

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

  Future<void> getSafetyScoreData() async {
    for(var safetyScoreData in DependencyInjector().locator<SafeConnexSafetyScoringDatabase>().safetyScoreData){
      _safetyScoreList.add(geofence.Geofence(
          id: safetyScoreData["locationName"],
          latitude: safetyScoreData["latitude"],
          longitude: safetyScoreData["longitude"],
          radius: [
            geofence.GeofenceRadius(id: safetyScoreData["radiusId"], length: double.parse(safetyScoreData["radiusSize"].toString()))
          ]
      ));
      switch(safetyScoreData["riskLevel"]){
        case "Low":
          riskLevelColor = Colors.yellow;
          riskLevelBorderColor = Colors.yellow.shade500;
          break;
        case "Moderate":
          riskLevelColor = Colors.orange;
          riskLevelBorderColor = Colors.orange.shade500;
          break;
        case "High":
          riskLevelColor = Colors.red;
          riskLevelBorderColor = Colors.red.shade500;
          break;
      }
      Future.delayed(Duration(milliseconds: 2500), (){
        addCircleMarker(LatLng(double.parse(safetyScoreData["latitude"].toString()), double.parse(safetyScoreData["longitude"].toString())), double.parse(safetyScoreData["radiusSize"].toString()));
      });
    }
  }

  Future<void>  getGeofenceData() async {
    for(var geofenceData in DependencyInjector().locator<SafeConnexGeofenceDatabase>().geofenceData){
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
      DependencyInjector().locator<SafeConnexLocationHistory>().getGeocode(LatLng(_location!["latitude"], _location!["longitude"]));
      DependencyInjector().locator<SafeConnexGeolocation>().setCoordinates(_location!['latitude'], _location!['longitude'], DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.uid);
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
    DependencyInjector().locator<SafeConnexGeolocation>().getCoordinates();
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
    _geofenceService.clearAllListeners();
    super.dispose();
  }

  addCircleMarker(LatLng markerLocation, double radiusSize){
    circleMarker.add(CircleMarker(
        color: riskLevelColor.withOpacity(0.2),
        borderColor: riskLevelBorderColor,
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
        point: LatLng(DependencyInjector().locator<SafeConnexGeolocation>().coordinatesData[index]['latitude'], DependencyInjector().locator<SafeConnexGeolocation>().coordinatesData[index]['longitude']),
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
                child: DependencyInjector().locator<SafeConnexGeolocation>().coordinatesData[index]['image'] != null ? Image.network(DependencyInjector().locator<SafeConnexCircleDatabase>().circleDataValue[index]["image"]) : Container(color:Colors.white),
              ),
            )
          ],
        )
    ));
    print("Geocoded: ${DependencyInjector().locator<SafeConnexGeolocation>().coordinatesData[index]["geocoded"]}");
    setState(() {});
  }

  getLocation(){
    setState(() {
      _mapController.move(LatLng(_location!['latitude'], _location!['longitude']), 14.2);
      //print("InClass" + SafeConnexGeolocation.coordinatesData[1]['userId']);
      //print(SafeConnexGeolocation.coordinatesData[1]["location"]);
    });
  }

  // This is the Build method
  Widget _buildMonitor() {
    geolocationMarkers.clear();
    index = 0;

    Future.delayed(Duration(milliseconds: 550), (){
      if(DependencyInjector().locator<SafeConnexSafetyScoringDatabase>().isMapSwitched == true){
        circleMarker.clear();
        getGeofenceData();
      }else if(DependencyInjector().locator<SafeConnexSafetyScoringDatabase>().isMapSwitched == false){
        circleMarker.clear();
        getSafetyScoreData();
      }
    });

    for(index; index < DependencyInjector().locator<SafeConnexGeolocation>().coordinatesData.length; index++){
      addGeolocationMarker(index);
    }

    _locationHistoryTimer;

    /*Timer.periodic(Duration(minutes: 1), (timer){
      print(timer);
      DependencyInjector().locator<SafeConnexLocationHistory>().addDataToLocationHistory(
          DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.uid,
          LatLng(_location!["latitude"], _location!["longitude"]),
          "${DateTime.now().hour}:${DateTime.now().minute}",
          "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}");
    });*/
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
                        initialZoom: 13.2
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
                        ),
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