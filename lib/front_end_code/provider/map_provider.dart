import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapProvider extends StatefulWidget {
  const MapProvider({super.key});

  @override
  State<MapProvider> createState() => _MapProviderState();
}

class _MapProviderState extends State<MapProvider> {

  final _mapController = MapController(
      initMapWithUserPosition: const UserTrackingOption(enableTracking: true)
  );

  var markerMap = <String, String>{};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)  {
      _mapController.listenerMapSingleTapping.addListener(() async {
        // Adds new market when tapped
        var position = _mapController.listenerMapSingleTapping.value;
        if(position != null){}
        await _mapController.addMarker(position!, markerIcon: const MarkerIcon(
            icon: Icon(Icons.pin_drop, color: Colors.blue, size: 48,)
        ));
        var key = '${position.latitude} ${position.longitude}';
        markerMap[key] = markerMap.length.toString();
      });
    });
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: OSMFlutter(
          controller: _mapController,
          mapIsLoading: const Center(
              child: CircularProgressIndicator()
          ),
          osmOption: OSMOption(
            userTrackingOption: const UserTrackingOption(enableTracking: true),
            zoomOption: const ZoomOption(
              initZoom: 12,
              minZoomLevel: 4,
              maxZoomLevel: 14,
              stepZoom: 1.0,
            ),
            userLocationMarker: UserLocationMaker(
              personMarker: const MarkerIcon(
                  icon: Icon(Icons.personal_injury, color: Colors.black, size: 48,)
              ),
              directionArrowMarker: const MarkerIcon(
                  icon: Icon(Icons.location_on, color: Colors.black, size: 48,)
              ),
            ),
            roadConfiguration: const RoadOption(roadColor: Colors.blueGrey),
          ),
          onMapIsReady: (isReady) async {
            if(isReady){
              await Future.delayed(const Duration(seconds: 1), () async {
                await _mapController.currentLocation();
              });
            }
          },
          onGeoPointClicked: (geoPoint){
            var key = '${geoPoint.latitude} ${geoPoint.longitude}';
            // When user clicked geopoint
            showModalBottomSheet(context: context, builder: (context){
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Position ${markerMap[key]}',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue
                            ),
                          ),
                          const Divider(thickness: 1,),
                          Text(key),
                        ],
                      )),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.clear),
                      )
                    ],
                  ),
                ),
              );
            });
          },
        )
    );
  }
}