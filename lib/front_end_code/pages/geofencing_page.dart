// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safeconnex/front_end_code/components/home_components/error_snackbar.dart';
import 'package:safeconnex/front_end_code/provider/new_map_provider.dart';

class GeofencingPage extends StatefulWidget {
  const GeofencingPage({super.key});

  @override
  State<GeofencingPage> createState() => _GeofencingPageState();
}

class _GeofencingPageState extends State<GeofencingPage> {
  ScrollController placesScrollControl = ScrollController();
  TextEditingController _placeNameController = TextEditingController();
  TextEditingController _locationNameController = TextEditingController();
  final _geofenceTextFieldsKey = GlobalKey<FormState>();

  int _selectedTabIndex = 0;
  int? _selectedPlaceIndex;

  String? placeLabelName;
  String? placeLocationName;
  double _sliderValue = 100.0;

  List<String> places = [
    'At Home',
    'At School',
    'At Luneta Park',
    'Home Sweet Home',
    'SM Mall of Asia',
    'Pangasinan Solid North Bus Terminal',
    'AMA College Pangasinan',
    'Universidad de Dagupan',
    'Bonifacio Global City',
  ];

  saveEditChanges() {
    if (_geofenceTextFieldsKey.currentState!.validate()) {
      print('Edit Changes have been saved!');
    }
  }

  saveNewLocation() {
    if (_geofenceTextFieldsKey.currentState!.validate()) {
      print('New Location has been saved!');
    }
  }

  @override
  void dispose() {
    placesScrollControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    void _onTabTapped(int index) {
      setState(() {
        _selectedTabIndex = index;
        if (index == 1) {
          placeLabelName = '';
          placeLocationName = '';
        }
      });
    }

    void _onPlaceTapped(int index) {
      setState(() {
        if (index == _selectedPlaceIndex) {
          _selectedPlaceIndex = null;
        } else {
          _selectedPlaceIndex = index;
        }
      });
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 71, 82, 98),
          leadingWidth: width * 0.15,
          toolbarHeight: height * 0.1,
          title: Text(
            'Places',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'OpunMai',
              fontSize: height * 0.03,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.only(left: height * 0.035),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              radius: 1,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color.fromARGB(255, 232, 220, 206),
                    width: 3,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 182, 176, 163),
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: FittedBox(
                  child: Text(
                    String.fromCharCode(Icons.west.codePoint),
                    style: TextStyle(
                      fontFamily: Icons.west.fontFamily,
                      fontSize: width * 0.055,
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 110, 101, 94),
                      package: Icons.west.fontPackage,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Center(
          child: SizedBox(
            height: height * 0.8,
            child: Column(
              children: [
                //VIEW AND ADD BUTTONS
                Container(
                  height: height * 0.1,
                  width: width * 0.85,
                  padding: EdgeInsets.symmetric(vertical: height * 0.027),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //VIEW PLACES BUTTON
                      Expanded(
                        child: InkWell(
                          onTap: () => _onTabTapped(0),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Container(
                            padding:
                            EdgeInsets.symmetric(vertical: height * 0.005),
                            decoration: BoxDecoration(
                              color: _selectedTabIndex == 0
                                  ? Color.fromARGB(255, 70, 85, 104)
                                  : Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                bottomLeft: Radius.circular(50),
                              ),
                              border: Border.all(
                                width: 2,
                                color: Color.fromARGB(255, 70, 85, 104),
                              ),
                            ),
                            child: FittedBox(
                              child: Text(
                                'view locations',
                                style: TextStyle(
                                  fontFamily: 'OpunMai',
                                  fontWeight: FontWeight.w500,
                                  color: _selectedTabIndex == 0
                                      ? Colors.white
                                      : Color.fromARGB(255, 70, 85, 104),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      //ADD LOCATION BUTTON
                      Expanded(
                        child: InkWell(
                          onTap: () => _onTabTapped(1),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Container(
                            padding:
                            EdgeInsets.symmetric(vertical: height * 0.005),
                            decoration: BoxDecoration(
                              color: _selectedTabIndex == 1
                                  ? Color.fromARGB(255, 70, 85, 104)
                                  : Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              ),
                              border: Border.all(
                                width: 2,
                                color: Color.fromARGB(255, 70, 85, 104),
                              ),
                            ),
                            child: FittedBox(
                              child: Text(
                                'add location',
                                style: TextStyle(
                                  fontFamily: 'OpunMai',
                                  fontWeight: FontWeight.w500,
                                  color: _selectedTabIndex == 1
                                      ? Colors.white
                                      : Color.fromARGB(255, 70, 85, 104),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //SAVED LOCATIONS LIST && ADD LOCATIONS
                Flexible(
                  child: SingleChildScrollView(
                    reverse: true,
                    child: SizedBox(
                      height: height * 0.7,
                      child: Column(
                        children: [
                          //SAVED LOCATIONS LIST
                          if (_selectedTabIndex == 0) ...[
                            Expanded(
                              child: Scrollbar(
                                trackVisibility: true,
                                thickness: 8,
                                radius: Radius.circular(15),
                                child: ListView.builder(
                                  controller: placesScrollControl,
                                  itemCount: places.length,
                                  itemBuilder: ((context, index) {
                                    return InkWell(
                                      onTap: () => _onPlaceTapped(index),
                                      child: Container(
                                        height: height * 0.085,
                                        width: width,
                                        color: _selectedPlaceIndex == index
                                            ? Color.fromARGB(255, 232, 220, 206)
                                            : Colors.transparent,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: width * 0.1,
                                              right: width * 0.06),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              //LOCATION ICON
                                              CircleAvatar(
                                                backgroundColor:
                                                _selectedPlaceIndex == index
                                                    ? Color.fromARGB(
                                                    255, 71, 82, 98)
                                                    : Color.fromARGB(
                                                    255, 232, 220, 206),
                                                radius: width * 0.06,
                                                child: FittedBox(
                                                  child: Image.asset(
                                                    'assets/images/geofence_location_icon.png',
                                                    color:
                                                    _selectedPlaceIndex ==
                                                        index
                                                        ? Color.fromARGB(
                                                        255,
                                                        232,
                                                        220,
                                                        206)
                                                        : Color.fromARGB(
                                                        255,
                                                        71,
                                                        82,
                                                        98),
                                                    width: width * 0.08,
                                                    height: width * 0.085,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: width * 0.05,
                                              ),
                                              //PLACE NAME
                                              Expanded(
                                                child: Text(
                                                  places[index],
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontFamily: 'OpunMai',
                                                    fontSize: height * 0.026,
                                                    color: Color.fromARGB(
                                                        255, 71, 82, 98),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ],

                          //MAP VIEW
                          if (_selectedTabIndex == 1) ...[
                            Container(
                              width: width,
                              height: height * 0.3,
                              decoration: BoxDecoration(
                                color: Colors.blue[100],
                                border: Border.symmetric(
                                  horizontal: BorderSide(
                                    color: Color.fromARGB(255, 173, 162, 153),
                                    width: 6,
                                  ),
                                ),
                              ),
                              //child: NewMapProvider(),
                            ),
                            //SLIDER
                            Container(
                              height: height * 0.1,
                              width: width,
                              padding: EdgeInsets.only(
                                  left: width * 0.02, right: width * 0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: SliderTheme(
                                      data: SliderThemeData(
                                        activeTickMarkColor: Colors.transparent,
                                        trackHeight: height * 0.0065,
                                        thumbShape: RoundSliderThumbShape(
                                          enabledThumbRadius: width * 0.045,
                                        ),
                                      ),
                                      child: Slider(
                                        value: _sliderValue,
                                        onChanged: (value) {
                                          setState(() {
                                            this._sliderValue = value;
                                          });
                                        },
                                        min: 50,
                                        max: 3000,
                                        divisions: 100,
                                        activeColor:
                                        Color.fromARGB(255, 70, 85, 104),
                                        inactiveColor:
                                        Color.fromARGB(255, 70, 85, 104),
                                        thumbColor: Colors.deepPurple[400],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.03,
                                  ),
                                  //RADIUS VALUE
                                  Flexible(
                                    child: Text(
                                      '${_sliderValue.toStringAsFixed(1)} m zone',
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        fontFamily: 'OpunMai',
                                        fontSize: height * 0.013,
                                        color: Color.fromARGB(255, 70, 85, 104),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //LOCATION DETAILS HEADER
                            Container(
                              width: width,
                              height: height * 0.05,
                              color: Color.fromARGB(255, 232, 220, 206),
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: width * 0.05),
                              child: Text(
                                'Location Details',
                                style: TextStyle(
                                  fontFamily: 'OpunMai',
                                  fontSize: height * 0.022,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromARGB(255, 173, 162, 153),
                                ),
                              ),
                            ),
                            //LOCATION LABELS
                            Expanded(
                              child: Form(
                                key: _geofenceTextFieldsKey,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    //LABEL TEXT
                                    Flexible(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        padding:
                                        EdgeInsets.only(left: width * 0.05),
                                        child: Text(
                                          'Label',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: 'OpunMai',
                                            fontWeight: FontWeight.w700,
                                            fontSize: height * 0.022,
                                            color:
                                            Color.fromARGB(255, 71, 82, 98),
                                          ),
                                        ),
                                      ),
                                    ),
                                    //LABEL TEXT FIELD
                                    Flexible(
                                      flex: 4,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.1),
                                        child: TextFormField(
                                          controller: _placeNameController,
                                          validator: (placeName) {
                                            if (placeName!.isEmpty) {
                                              showErrorMessage(
                                                  context,
                                                  'Please enter a place name',
                                                  height,
                                                  width);
                                              return '';
                                            }
                                            return null;
                                          },
                                          cursorColor: Color.fromARGB(
                                              255, 173, 162, 153),
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.bookmark,
                                              size: width * 0.085,
                                              color: Color.fromARGB(
                                                  255, 173, 162, 153),
                                            ),
                                            hintText: 'Name this place',
                                            hintStyle: TextStyle(
                                              fontFamily: 'OpunMai',
                                              fontSize: height * 0.022,
                                              fontWeight: FontWeight.w700,
                                              color: Color.fromARGB(
                                                  255, 173, 162, 153),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 71, 82, 98),
                                                width: 3.5,
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 71, 82, 98),
                                                width: 3.5,
                                              ),
                                            ),
                                          ),
                                          style: TextStyle(
                                            fontFamily: 'OpunMai',
                                            fontWeight: FontWeight.w700,
                                            fontSize: height * 0.022,
                                            color: Color.fromARGB(
                                                255, 173, 162, 153),
                                          ),
                                        ),
                                      ),
                                    ),
                                    //LOCATION LABEL TEXT FIELD
                                    Flexible(
                                      flex: 4,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.1),
                                        child: TextFormField(
                                          controller: _locationNameController,
                                          cursorColor: Color.fromARGB(
                                              255, 173, 162, 153),
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.location_on,
                                              size: width * 0.085,
                                              color: Color.fromARGB(
                                                  255, 173, 162, 153),
                                            ),
                                            hintText: 'Location Name',
                                            hintStyle: TextStyle(
                                              fontFamily: 'OpunMai',
                                              fontSize: height * 0.022,
                                              fontWeight: FontWeight.w700,
                                              color: Color.fromARGB(
                                                  255, 173, 162, 153),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 71, 82, 98),
                                                width: 3.5,
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 71, 82, 98),
                                                width: 3.5,
                                              ),
                                            ),
                                          ),
                                          style: TextStyle(
                                            fontFamily: 'OpunMai',
                                            fontWeight: FontWeight.w700,
                                            fontSize: height * 0.022,
                                            color: Color.fromARGB(
                                                255, 173, 162, 153),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(
                //     bottom: MediaQuery.of(context).viewInsets.bottom,
                //   ),
                // ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: height * 0.1,
          color: Color.fromARGB(255, 71, 82, 98),
          child: Row(
            children: [
              //CANCEL BUTTON
              Expanded(
                child: Container(
                  height: height * 0.1,
                  color: Color.fromARGB(255, 81, 97, 112),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.cancel_outlined),
                    color: Color.fromARGB(255, 227, 230, 229),
                    iconSize: width * 0.125,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                  ),
                ),
              ),
              //EDIT || SAVE LOCATION BUTTON
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                  child: MaterialButton(
                    onPressed: () {
                      if (_selectedTabIndex == 0) {
                        //if place index == null
                        //prevent navigation, show snackbar error

                        //if edit is clicked with place index
                        //pass all the data of that place index
                        //navigate to add location page
                        //display the value of the placeLabelName and placeLocationName as hintexts of textfields (using ternary operator)

                        if (_selectedPlaceIndex == null) {
                          showErrorMessage(context,
                              'Please select a place to edit', height, width);
                        } else {
                          setState(() {
                            _selectedTabIndex = 1;
                            //set placeLabelName to the name of the selected index
                            //set placeLocationName to the the location name of the selected index
                          });
                        }
                      } else {
                        if (placeLabelName == '' && placeLocationName == '') {
                          //get the value of the textfields

                          //add the geofence, label, and location to database
                        } else {
                          //get the value of the texfields
                          //modify the selected place's value in the database
                        }
                      }
                    },
                    elevation: 2,
                    height: height * 0.05,
                    color: const Color.fromARGB(255, 121, 192, 148),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(width * 0.2),
                    ),
                    child: Text(
                      _selectedTabIndex == 0 ? 'edit location' : 'save changes',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'OpunMai',
                        fontSize: height * 0.025,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}