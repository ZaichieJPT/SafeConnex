import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cache/flutter_map_cache.dart';
import 'package:geofence_service/geofence_service.dart' as geofence;
import 'package:latlong2/latlong.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_database.dart';

class AgencyMapProvider extends StatefulWidget {
  const AgencyMapProvider({super.key});

  @override
  State<AgencyMapProvider> createState() => _AgencyMapProviderState();
}

class _AgencyMapProviderState extends State<AgencyMapProvider> {
  final _activityStreamController = StreamController<geofence.Activity>();
  final _geofenceStreamController = StreamController<geofence.Geofence>();

  List<CircleMarker> circleMarker = [];
  List<geofence.Geofence> _safetyScoreList = [];
  Color riskLevelColor = Colors.green.shade200;
  Color riskLevelBorderColor = Colors.green.shade500;

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
    for(var safetyScoreData in SafeConnexSafetyScoringDatabase.safetyScoreData){
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
        default:
          riskLevelColor = Colors.blue;
          riskLevelBorderColor = Colors.blue.shade500;
      }
      Future.delayed(Duration(milliseconds: 2500), (){
        addCircleMarker(LatLng(double.parse(safetyScoreData["latitude"].toString()), double.parse(safetyScoreData["longitude"].toString())), double.parse(safetyScoreData["radiusSize"].toString()));
      });
    }
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _geofenceService.addGeofenceStatusChangeListener(_onGeofenceStatusChanged);
      _geofenceService.addLocationChangeListener(_onLocationChanged);
      _geofenceService.addActivityChangeListener(_onActivityChanged);
      _geofenceService.addLocationServicesStatusChangeListener(_onLocationServicesStatusChanged);
      _geofenceService.addStreamErrorListener(_onError);
      //_geofenceService.start(_geofenceList).catchError(_onError);
    });
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
        //_location = location.toJson();
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

  Widget _buildMonitor() {
    Future.delayed(Duration(milliseconds: 400), (){
      getSafetyScoreData();
    });
    //geolocationMarkers.clear();
    //_mapController = MapController();
    //index = 0;
    /*Future.delayed(Duration(milliseconds: 400), (){
      geolocation.setCoordinates(_location!['latitude'], _location!['longitude'], SafeConnexAuthentication.currentUser!.uid);
    });

    for(index; index < FlutterFireCoordinates.coordinatesData.length; index++){
      addGeolocationMarker(index);
    }*/

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

              return Scaffold(
                body: Stack(
                  children: [
                    FlutterMap(
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
