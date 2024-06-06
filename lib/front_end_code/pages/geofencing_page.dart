import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_circle_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_geofence_store.dart';
import 'package:safeconnex/front_end_code/components/location_list.dart';

class GeofencingPage extends StatefulWidget {
  const GeofencingPage({super.key});

  @override
  State<GeofencingPage> createState() => _GeofencingPageState();
}

class _GeofencingPageState extends State<GeofencingPage> {
  List<bool> isSelected = [
    true,
    false
  ];
  int? indexedStackValue = 0;
  double _currentSliderValue = 100;
  double? maxSliderValue = 1000;
  GeofenceDatabase flutterGeofencing = GeofenceDatabase();
  TapPosition? tapPosition;
  LatLng? tapLocation;
  Marker geolocationMarker = Marker(point: LatLng(0, 0), child: Container());
  CircleMarker circleMarker = CircleMarker(point: LatLng(0, 0), radius: 0);
  List<Container> locationList = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final _geofenceKey = GlobalKey<FormState>();
  int? tempIndex;
  List<bool> isValueSelected = [];
  CircleDatabaseHandler circleDatabase = CircleDatabaseHandler();

  addGeolocationMarker(LatLng markerLocation, double sliderValue){
    geolocationMarker = Marker(
        height: 50,
        width: 50,
        rotate: true,
        alignment: Alignment.topCenter,
        point: markerLocation,
        child: Stack(
          children: [
            Positioned(
                child: Icon(Icons.location_pin, size: 55)
            ),
            Positioned(
              top: 10,
              left: 16,
              child: Container(
                width: 23,
                height: 23,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.green
                ),
              ),
            ),
          ],
        )
    );
    circleMarker = CircleMarker(
        color: Colors.blue.shade300.withOpacity(0.5),
        borderColor: Colors.blue.shade500,
        borderStrokeWidth: 2,
        point: markerLocation,
        radius: sliderValue,
        useRadiusInMeter: true
    );
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      flutterGeofencing.getGeofence("Great");
      //circleDatabase.getCircle(uid, circleCode)
    });
  }
  @override
  Widget build(BuildContext context) {
    if(indexedStackValue == 0){
      if(isValueSelected.length != flutterGeofencing.geofenceData.length){
        isValueSelected = List.generate(flutterGeofencing.geofenceData.length, (index) => false);
      }
    }else if(indexedStackValue == 1){
      /*addGeolocationMarker(
        LatLng(
          flutterGeofencing.geofenceToUpdate['latitude'],
          flutterGeofencing.geofenceToUpdate['longitude']),
          flutterGeofencing.geofenceToUpdate['radiusSize']
      );
      nameController.value = flutterGeofencing.geofenceToUpdate['radiusId'];
      addressController.value = flutterGeofencing.geofenceToUpdate['addressLabel'];*/
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade500,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text("Place"),
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 25
        ),
      ),
      bottomSheet: BottomAppBar(
        color: Colors.blueGrey.shade800,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              child: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                color: Colors.white,
                icon: Icon(Icons.cancel_outlined),
                iconSize: 40,
              ),
            ),
            SizedBox(
              width: 80,
            ),
            Container(
              alignment: Alignment.center,
              height: 35,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.green.shade200,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.green.shade400,
                        offset: Offset(0, 4)
                    )
                  ],
                  borderRadius: BorderRadius.circular(20)
              ),
              child: TextButton(
                onPressed: (){
                  //Save Changes
                  if(indexedStackValue == 1){
                    if(_geofenceKey.currentState!.validate()){
                      flutterGeofencing.addGeofence(
                          "Garry",
                          tapLocation!.latitude,
                          tapLocation!.longitude,
                          nameController.text,
                          circleMarker.radius,
                          "Great",
                          addressController.text
                      );
                    }
                    nameController.clear();
                    addressController.clear();
                    indexedStackValue = 0;
                    setState(() {});
                  }
                  if(indexedStackValue == 0){
                    if(tempIndex == null){
                      print("Click a Geofence");
                    }
                    else{
                      //flutterGeofencing.geofenceToUpdate =
                    }
                  }
                },
                child: Text(
                    indexedStackValue == 0 ? "Edit Location" : "Save Changes",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    )
                ),
              ),
            ),
            SizedBox(
              width: 60,
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            width: 320,
            height: 43,
            top:20,
            left: 50,
            child: ToggleButtons(
              children: [
                Container(child: Text("View Location", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,), width: 150, padding: EdgeInsets.all(10),),
                Container(child: Text("Add Location", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,), width: 150, padding: EdgeInsets.all(10),),
              ],
              borderRadius: BorderRadius.circular(40),
              borderColor: Colors.blueGrey.shade800,
              borderWidth: 1.5,
              color: Colors.blueGrey.shade800,
              selectedColor: Colors.white,
              fillColor: Colors.blueGrey.shade800,
              onPressed: (int index){
                setState(() {
                  if(index == 0){
                    isSelected[0] = true;
                    isSelected[1] = false;
                    indexedStackValue = 0;
                  }
                  else if(index == 1){
                    if(index == 1){
                      isSelected[1] = true;
                      isSelected[0] = false;
                      indexedStackValue = 1;
                    }
                  }
                });
              },
              isSelected: isSelected,
            ),
          ),

          IndexedStack(
            index: indexedStackValue,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 100,
                  bottom: 20,
                ),
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index){
                      List<LocationList> _locationList = [];

                      for(var data in flutterGeofencing.geofenceData){
                        _locationList.add(LocationList(text: data['id']));
                      }

                      return ToggleButtons(
                          direction: Axis.vertical,
                          onPressed: (int index){
                            if(tempIndex == null){
                              setState(() {
                                isValueSelected[index] = !isValueSelected[index];
                              });
                            }else{
                              setState(() {
                                isValueSelected[tempIndex!] = false;
                                isValueSelected[index] = true;
                              });
                            }
                            tempIndex = index;
                            flutterGeofencing.geofenceToUpdate = {
                              "id": flutterGeofencing.geofenceData[tempIndex!]['id'].toString(),
                              "latitude": flutterGeofencing.geofenceData[tempIndex!]['latitude'].toString(),
                              "longitude": flutterGeofencing.geofenceData[tempIndex!]['longitude'].toString(),
                              "radiusId": flutterGeofencing.geofenceData[tempIndex!]['radiusId'].toString(),
                              "radiusSize": flutterGeofencing.geofenceData[tempIndex!]['radiusSize'].toString(),
                              "addressLabel": flutterGeofencing.geofenceData[tempIndex!]['addressLabel'].toString(),
                              //"circleName": circ
                            };

                            print(flutterGeofencing.geofenceToUpdate['id']);
                          },
                          borderColor: Colors.white,
                          isSelected: isValueSelected,
                          children: _locationList
                      );
                    }
                ),
              ),

              //Add Location
              SingleChildScrollView(
                reverse: true,
                child: Container(
                  padding: EdgeInsets.only(
                    top: 100,
                    bottom: 20,
                  ),
                  child: Column(
                    children: [
                      Divider(
                        thickness: 7,
                        color: Colors.brown.shade200,
                      ),
                      Container(
                        height: 230,
                        child: FlutterMap(
                          options: MapOptions(
                              initialCenter: LatLng(16.0265, 120.3363),
                              initialZoom: 13.2,
                              onTap: (tapPosition, tapLocation){
                                this.tapLocation = tapLocation;
                                this.tapPosition = tapPosition;
                                _currentSliderValue = 100;
                                addGeolocationMarker(tapLocation, _currentSliderValue);
                              }
                          ),
                          children: [
                            TileLayer(
                              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.safeconnex.app',
                            ),
                            CircleLayer(
                              circles: [
                                circleMarker
                              ],
                            ),
                            MarkerLayer(
                              markers: [
                                geolocationMarker
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 5,
                        color: Colors.brown.shade200,
                      ),
                      Slider(
                        value: _currentSliderValue,
                        max: maxSliderValue!,
                        divisions: maxSliderValue!.round(),
                        label: _currentSliderValue.round().toString(),
                        onChanged: (value){
                          setState(() {
                            _currentSliderValue = value;
                            addGeolocationMarker(tapLocation!, value);
                          });
                        },
                      ),
                      Container(
                        width: 1000,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.brown.shade100,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Location Details",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.brown.shade300
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 300,
                        child: Form(
                          key: _geofenceKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                width: 450,
                                child: Text(
                                  "Label",
                                  style: TextStyle(
                                      fontSize: 23,
                                      color: Colors.blueGrey.shade800,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              TextFormField(
                                  controller: nameController,
                                  onTapOutside: (event){
                                    FocusManager.instance.primaryFocus?.unfocus();
                                  },
                                  validator: (value){
                                    print(value);
                                    if(value!.isEmpty){
                                      return "Please enter a Circle Name";
                                    }
                                    else{
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.bookmark),
                                      iconColor: Colors.blueGrey.shade200,
                                      hintText: "Name",
                                      hintStyle: TextStyle(
                                        color: Colors.blueGrey.shade200,
                                      ),
                                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueGrey.shade800, width: 3))
                                  )
                              ),
                              TextFormField(
                                  controller: addressController,
                                  onTapOutside: (event){
                                    FocusManager.instance.primaryFocus?.unfocus();
                                  },
                                  validator: (value){
                                    print(value);
                                    if(value!.isEmpty){
                                      return "Please enter Address Label";
                                    }
                                    else{
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.house),
                                      iconColor: Colors.blueGrey.shade200,
                                      hintText: "Address",
                                      hintStyle: TextStyle(
                                        color: Colors.blueGrey.shade200,
                                      ),
                                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueGrey.shade800, width: 3))
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
