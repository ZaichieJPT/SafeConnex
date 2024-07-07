// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_agency_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_authentication.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_circle_database.dart';
import 'package:safeconnex/front_end_code/components/home_components/error_snackbar.dart';

class AgencyFeedProfile extends StatefulWidget {
  const AgencyFeedProfile({
    super.key,
  });

  @override
  State<AgencyFeedProfile> createState() => _AgencyFeedProfileState();
}

class _AgencyFeedProfileState extends State<AgencyFeedProfile> {
  int _currentFeedIndex = 0;
  double _detailsProgress = 0;
  bool _isEditDetailsSelected = false;
  bool _isEditProfileSelected = false;

  final List<TextEditingController> _agencyDataControllers = [];
  final TextEditingController _agencyNameController = TextEditingController();
  final TextEditingController _agencyRoleController = TextEditingController();

  final GlobalKey<FormState> _agencyDataFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _agencyProfileFormKey = GlobalKey<FormState>();

  //SafeConnexAgencyDatabase agencyDatabase = SafeConnexAgencyDatabase();

  List<String> agencyInfo = [
    'location of the agency',
    'mobile number',
    'telephone number',
    'email address of agency',
    'facebook link',
    'agency website',
  ];

  _onTabTapped(int index) {
    setState(() {
      _currentFeedIndex = index;
    });
  }

  _getDetailsProgress(int filled) {
    setState(() {
      _detailsProgress = filled / 6;
      print(_detailsProgress);
    });
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i <= 6; i++) {
      _agencyDataControllers.add(TextEditingController());
    }

    _agencyDataControllers[0].text = DependencyInjector().locator<SafeConnexAgencyDatabase>().agencyData["agencyLocation"]!;
    _agencyDataControllers[1].text = DependencyInjector().locator<SafeConnexAgencyDatabase>().agencyData["agencyPhoneNumber"]!;
    _agencyDataControllers[2].text = DependencyInjector().locator<SafeConnexAgencyDatabase>().agencyData["agencyTelephoneNumber"]!;
    _agencyDataControllers[3].text = DependencyInjector().locator<SafeConnexAgencyDatabase>().agencyData["agencyEmailAddress"]!;
    _agencyDataControllers[4].text = DependencyInjector().locator<SafeConnexAgencyDatabase>().agencyData["facebookLink"]!;
    _agencyDataControllers[5].text = DependencyInjector().locator<SafeConnexAgencyDatabase>().agencyData["agencyWebsite"]!;
    int filled = 0;
    for (int i = 0; i < _agencyDataControllers.length; i++) {
      if (_agencyDataControllers[i].text.isNotEmpty) {
        filled += 1;
      }
    }
    _getDetailsProgress(filled);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return SingleChildScrollView(
      reverse: true,
      child: SizedBox(
        height: height * 0.81,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                height: height * 0.31,
                width: width,
                color: Color.fromARGB(255, 70, 86, 101),
                padding: EdgeInsets.only(
                  bottom: height * 0.035,
                  top: height * 0.01,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //CARD CONTAINER
                    Container(
                      width: width * 0.85,
                      height: height * 0.12,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 241, 241, 241),
                        borderRadius: BorderRadius.circular(width * 0.05),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 205, 204, 204),
                            offset: Offset(0, 7),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(left: width * 0.015),
                              child: DependencyInjector().locator<SafeConnexAuthentication>().authAgencyData["agencyType"] == "Natural Disaster and Accident\nResponder" ? Image.asset(
                                'assets/images/change_to_agency/agency_3_icon.png',
                                width: width * 0.2,
                              ) : DependencyInjector().locator<SafeConnexAuthentication>().authAgencyData["agencyType"] == "Fire Incident Responder" ? Image.asset(
                                  'assets/images/change_to_agency/agency_0_icon.png',
                                width: width * 0.2,
                              ) : DependencyInjector().locator<SafeConnexAuthentication>().authAgencyData["agencyType"] == "Crime Incident Responder" ? Image.asset(
                                  'assets/images/change_to_agency/agency_1_icon.png',
                                width: width * 0.2,
                              ) : DependencyInjector().locator<SafeConnexAuthentication>().authAgencyData["agencyType"] == "Medical Emergency Responder" ? Image.asset(
                                  'assets/images/change_to_agency/agency_2_icon.png',
                                width: width * 0.2,
                              ) : Container()
                            )
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          Expanded(
                            flex: 5,
                            child: Form(
                              key: _agencyProfileFormKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //AGENCY TITLE
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.symmetric(
                                        vertical: height * 0.005),
                                    child: _isEditProfileSelected
                                        ? TextFormField(
                                            controller: _agencyNameController,
                                            cursorColor: Colors.red,
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: height * 0.0175,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.red,
                                            ),
                                            decoration: InputDecoration(
                                              isCollapsed: true,
                                              isDense: true,
                                              hintText: 'Agency Name',
                                              hintStyle: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: height * 0.0175,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.red,
                                              ),
                                              errorStyle:
                                                  TextStyle(fontSize: 0),
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              errorBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.red,
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            validator: (agencyName) {
                                              if (agencyName
                                                  .toString()
                                                  .isEmpty) {
                                                showErrorMessage(
                                                  context,
                                                  'Please provide the name of your agency.',
                                                  height,
                                                  width,
                                                );
                                                return '';
                                              }
                                              return null;
                                            },
                                          )
                                        : Text(
                                            _agencyNameController.text.isEmpty
                                                ? DependencyInjector().locator<SafeConnexAuthentication>().authAgencyData["agencyName"]!
                                                : _agencyNameController.text,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: height * 0.0175,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromARGB(
                                                  255, 51, 64, 73),
                                            ),
                                          ),
                                  ),
                                  //USER NAME
                                  Container(
                                    width: width,
                                    //color: Colors.grey,
                                    padding:
                                        EdgeInsets.only(bottom: height * 0.005),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Image.asset(
                                            'assets/images/agency_app/agency_staff_icon.png',
                                            width: width * 0.035,
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.03,
                                        ),
                                        Expanded(
                                          flex: 6,
                                          child: SizedBox(
                                            child: Text(
                                              DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.displayName!,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: height * 0.0135,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromARGB(
                                                    255, 51, 64, 73),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //USER AGENCY ROLE
                                  Container(
                                    width: width,
                                    //color: Colors.grey,
                                    padding:
                                        EdgeInsets.only(bottom: height * 0.005),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Image.asset(
                                            'assets/images/agency_app/agency_role_icon.png',
                                            width: width * 0.045,
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.02,
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Container(
                                            //color: Colors.amber,
                                            child: _isEditProfileSelected
                                                ? TextFormField(
                                                    controller:
                                                        _agencyRoleController,
                                                    cursorColor: Colors.red,
                                                    style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      fontSize: height * 0.0135,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.red,
                                                    ),
                                                    decoration: InputDecoration(
                                                      isCollapsed: true,
                                                      isDense: true,
                                                      hintText: 'Role',
                                                      hintStyle: TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize:
                                                            height * 0.0135,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.red,
                                                      ),
                                                      errorStyle: TextStyle(
                                                          fontSize: 0),
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.red,
                                                          width: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Text(
                                              DependencyInjector().locator<SafeConnexAgencyDatabase>().agencyData["agencyRole"]!,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      fontSize: height * 0.0135,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromARGB(
                                                          255, 51, 64, 73),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                if (_isEditProfileSelected) {
                                  if (_agencyProfileFormKey.currentState!
                                      .validate()) {
                                    DependencyInjector().locator<SafeConnexAgencyDatabase>().updateAgencyMain(_agencyNameController.text, _agencyRoleController.text);
                                    setState(() {
                                      _isEditProfileSelected =
                                          !_isEditProfileSelected;
                                    });
                                  }
                                } else {
                                  setState(() {
                                    _isEditProfileSelected =
                                        !_isEditProfileSelected;
                                  });
                                }
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.grey.shade600,
                                radius: width * 0.033,
                                child: Image.asset(
                                  _isEditProfileSelected
                                      ? 'assets/images/agency_app/agency_save_button.png'
                                      : 'assets/images/agency_app/agency_edit_button.png',
                                  width: width * 0.035,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //PROGRESS INDICATOR
                    Container(
                      height: height * 0.08,
                      width: width * 0.85,
                      //color: Colors.grey,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  //PROGRESS LINE
                                  LinearPercentIndicator(
                                    alignment: MainAxisAlignment.start,
                                    animation: true,
                                    animateFromLastPercent: true,
                                    width: width * 0.8,
                                    backgroundColor:
                                        Color.fromARGB(255, 51, 64, 73),
                                    barRadius: Radius.circular(width * 0.025),
                                    lineHeight: height * 0.015,
                                    padding:
                                        EdgeInsets.only(right: width * 0.015),
                                    percent: _detailsProgress,
                                    progressColor: Colors.amber,
                                  ),
                                  //PROGRESS IMAGE
                                  Image.asset(
                                    'assets/images/agency_app/agency_profile_progress.png',
                                    width: width * 0.12,
                                  ),
                                ],
                              ),
                            ),
                            //INFO TEXT
                            Expanded(
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/agency_app/agency_info_icon.png',
                                    width: width * 0.04,
                                    color: Color.fromARGB(255, 125, 136, 153),
                                  ),
                                  Text(
                                    ' Fill out all the asked details to fill this up!',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: height * 0.013,
                                      color: const Color.fromARGB(
                                          255, 201, 214, 223),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    width: width * 0.7,
                    height: height * 0.04,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 51, 64, 73),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(width * 0.04),
                        topRight: Radius.circular(width * 0.04),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: SizedBox(),
                        ),
                        //ALL DETAILS FILLED OUT
                        Expanded(
                          flex: 3,
                          child: Text(
                            'All Details Filled Out',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: height * 0.0185,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        //EDIT / SAVE BUTTON
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _isEditDetailsSelected = !_isEditDetailsSelected;
                                int filled = 0;
                                for (int i = 0; i < _agencyDataControllers.length; i++) {
                                  if (_agencyDataControllers[i].text.isNotEmpty) {
                                    filled += 1;
                                  }
                                  print('i: ${_agencyDataControllers[i].text}');
                                }
                                _getDetailsProgress(filled);
                                // Not changing
                                if(_isEditDetailsSelected == false){
                                  print("Before" + _agencyDataControllers[3].text);
                                  print(_agencyDataControllers[0].text);
                                  Future.delayed(Duration(milliseconds: 400), (){
                                    print("After" + _agencyDataControllers[3].text);
                                    DependencyInjector().locator<SafeConnexAgencyDatabase>().updateAgencyData(_agencyDataControllers[0].text, _agencyDataControllers[1].text, _agencyDataControllers[2].text, _agencyDataControllers[3].text, _agencyDataControllers[4].text, _agencyDataControllers[5].text).whenComplete((){print(true);});
                                  });
                                }
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: width * 0.033,
                              child: Image.asset(
                                _isEditDetailsSelected
                                    ? 'assets/images/agency_app/agency_save_button.png'
                                    : 'assets/images/agency_app/agency_edit_button.png',
                                width: width * 0.035,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //SETTINGS GRID VIEW
                  Container(
                    height: height * 0.5,
                    color: Color.fromARGB(255, 51, 64, 73),
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.025,
                      vertical: height * 0.02,
                    ),
                    child: Form(
                      key: _agencyDataFormKey,
                      child: GridView.builder(
                        itemCount: 6,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 1.5),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.03,
                              vertical: height * 0.01,
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.03),
                              decoration: BoxDecoration(
                                color:
                                    _agencyDataControllers[index].text.isEmpty
                                        ? Color.fromARGB(255, 61, 77, 92)
                                        : Color.fromARGB(255, 238, 230, 195),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 42, 57, 69),
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    'assets/images/agency_app/agency_feed_$index.png',
                                    width: width * 0.125,
                                    color: _agencyDataControllers[index]
                                            .text
                                            .isEmpty
                                        ? Colors.white
                                        : Color.fromARGB(255, 168, 131, 104),
                                  ),
                                  _isEditDetailsSelected
                                      ? TextFormField(
                                          textAlign: TextAlign.center,
                                          controller:
                                              _agencyDataControllers[index],
                                          cursorColor:
                                              _agencyDataControllers[index]
                                                      .text
                                                      .isEmpty
                                                  ? Colors.grey.shade200
                                                  : Color.fromARGB(
                                                      255, 51, 64, 73),
                                          decoration: InputDecoration(
                                            isDense: true,
                                            hintText: agencyInfo[index],
                                            hintStyle: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: width * 0.025,
                                              color:
                                                  _agencyDataControllers[index]
                                                          .text
                                                          .isEmpty
                                                      ? Colors.grey.shade200
                                                      : Color.fromARGB(
                                                          255, 51, 64, 73),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: _agencyDataControllers[
                                                            index]
                                                        .text
                                                        .isEmpty
                                                    ? Colors.grey.shade200
                                                    : Color.fromARGB(
                                                        255, 51, 64, 73),
                                                width: 1,
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: _agencyDataControllers[
                                                            index]
                                                        .text
                                                        .isEmpty
                                                    ? Colors.grey.shade200
                                                    : Color.fromARGB(
                                                        255, 51, 64, 73),
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: width * 0.025,
                                            fontWeight: FontWeight.w500,
                                            color: _agencyDataControllers[index]
                                                    .text
                                                    .isEmpty
                                                ? Colors.grey.shade200
                                                : Color.fromARGB(
                                                    255, 51, 64, 73),
                                          ),
                                        )
                                      : Text(
                                          _agencyDataControllers[index]
                                                  .text
                                                  .isEmpty
                                              ? agencyInfo[index]
                                              : _agencyDataControllers[index]
                                                  .text,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: width * 0.025,
                                            fontWeight: FontWeight.w500,
                                            color: _agencyDataControllers[index]
                                                    .text
                                                    .isEmpty
                                                ? Colors.grey.shade200
                                                : Color.fromARGB(
                                                    255, 51, 64, 73),
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor:
                                                _agencyDataControllers[index]
                                                        .text
                                                        .isEmpty
                                                    ? Colors.grey.shade200
                                                    : Color.fromARGB(
                                                        255, 51, 64, 73),
                                            decorationThickness: 1.5,
                                            height: 1,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.viewInsetsOf(context).bottom),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
