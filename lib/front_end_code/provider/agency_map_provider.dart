import 'dart:async';

import 'package:flutter_map_polywidget/flutter_map_polywidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cache/flutter_map_cache.dart';
import 'package:geofence_service/geofence_service.dart' as geofence;
import 'package:latlong2/latlong.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:popover/popover.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_circle_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_scoring_database.dart';
import 'package:safeconnex/front_end_code/pages/agency_pages/agency%20_floodscore_page.dart';
import 'package:safeconnex/front_end_code/pages/agency_pages/agency_popup.dart';

class AgencyMapProvider extends StatefulWidget {
  const AgencyMapProvider({super.key});

  @override
  State<AgencyMapProvider> createState() => _AgencyMapProviderState();
}

class _AgencyMapProviderState extends State<AgencyMapProvider> {
  final _activityStreamController = StreamController<geofence.Activity>();
  final _geofenceStreamController = StreamController<geofence.Geofence>();

  List<CircleMarker> circleMarker = [];
  List<PolyWidget> polyMarker = [];
  List<geofence.Geofence> _safetyScoreList = [];
  Color riskLevelColor = Colors.green.shade200;
  Color riskLevelBorderColor = Colors.green.shade500;

  LatLng? tapLocation;

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
        case "None":
          riskLevelColor = Colors.green;
          riskLevelBorderColor = Colors.green.shade500;
          break;
      }
      addCircleMarker(LatLng(double.parse(safetyScoreData["latitude"].toString()), double.parse(safetyScoreData["longitude"].toString())), double.parse(safetyScoreData["radiusSize"].toString()));
      addPolyMarker(LatLng(double.parse(safetyScoreData["latitude"].toString()), double.parse(safetyScoreData["longitude"].toString())), double.parse(safetyScoreData["radiusSize"].toString()), safetyScoreData["locationName"], safetyScoreData["riskInfo"], safetyScoreData["riskLevel"], safetyScoreData["radiusId"].toString());
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

  addPolyMarker(LatLng markerLocation, double radiusSize, String locationName, String riskInfo, String riskLevel, String safetyScoreId){
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    polyMarker.add(PolyWidget(
        center: markerLocation,
        widthInMeters: radiusSize.toInt(),
        heightInMeters:radiusSize.toInt(),
        child: SafetyScorePopup(
          width: width,
          height: height,
          locationName: locationName,
          riskInfo: riskInfo,
          riskLevel: riskLevel,
          longitude: markerLocation.longitude,
          latitude: markerLocation.latitude,
          radiusSize: radiusSize,
          safetyScoreId: safetyScoreId,
        )
    ));
    print("Poly Widget Active");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _geofenceService.addGeofenceStatusChangeListener(_onGeofenceStatusChanged);
      _geofenceService.addActivityChangeListener(_onActivityChanged);
      _geofenceService.addLocationServicesStatusChangeListener(_onLocationServicesStatusChanged);
      _geofenceService.addStreamErrorListener(_onError);
      _geofenceService.start(_safetyScoreList).catchError(_onError);
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

    //geolocationMarkers.clear();
    //_mapController = MapController();
    //index = 0;
    circleMarker.clear();
    getSafetyScoreData();

    /*for(index; index < FlutterFireCoordinates.coordinatesData.length; index++){
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
              final geofencingContent = snapshot.data?.toJson() != null ? snapshot.data!.toJson() : {};

              return Scaffold(
                body: Stack(
                  children: [
                    FlutterMap(
                      options: MapOptions(
                          initialCenter: LatLng(16.0265, 120.3363),
                          initialZoom: 13.2,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.safeconnex.app',
                          tileProvider: CachedTileProvider(
                            store: MemCacheStore(),
                          ),
                        ),
                        PolyWidgetLayer(
                            polyWidgets: polyMarker
                        ),
                        CircleLayer(
                          circles: circleMarker
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
