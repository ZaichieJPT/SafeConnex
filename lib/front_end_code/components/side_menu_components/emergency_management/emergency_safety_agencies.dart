// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/emergency_management/emergency_contacts_options.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/emergency_management/safetyagency_contacts_template.dart';

class SafetyAgencies extends StatefulWidget {
  const SafetyAgencies({super.key});

  @override
  State<SafetyAgencies> createState() => _SafetyAgenciesState();
}

class _SafetyAgenciesState extends State<SafetyAgencies> {
  //CAROUSEL CONTROLLERS
  CarouselController _fireContactController = CarouselController();
  CarouselController _crimeContactController = CarouselController();
  CarouselController _medicalContactController = CarouselController();
  CarouselController _naturalContactController = CarouselController();

  var dragGesturePosition = Offset.zero;
  bool _showMagnifier = false;

  //CONTACT INDEX
  int _currentFireAgencyIndex = 0;
  int _currentCrimeAgencyIndex = 0;
  int _currentMedicalAgencyIndex = 0;
  int _currentNaturalAgencyIndex = 0;

  //ADD AND EDIT BUTTON FLAGS
  bool _isFireAddContactPressed = false;
  bool _isFireEditContactPressed = false;

  bool _isCrimeAddContactPressed = false;
  bool _isCrimeEditContactPressed = false;

  bool _isMedicalAddContactPressed = false;
  bool _isMedicalEditContactPressed = false;

  bool _isNaturalAddContactPressed = false;
  bool _isNaturalEditContactPressed = false;

  //SELECTED CONTACT FLAGS CONTAINER PER CONTACT TYPE
  List<bool> isSelectedFireAgency = [];
  List<bool> isSelectedCrimeAgency = [];
  List<bool> isSelectedMedicalAgency = [];
  List<bool> isSelectedNaturalAgency = [];

  final List<Map<String, dynamic>> fireAgencyContacts = [
    {
      'agencyName': 'Bureau of Fire Protection',
      'location': 'Brgy. Herrero-Perez, Dagupan City, Pangasinan',
      'mobile': '09123456789',
      'telephone': '075-213-2345',
      'email': 'bfpdagupan@gmail.com',
      'fb': 'https://www.facebook.com/bfpdagupan/',
      'website': 'www.bfp.com',
    },
    {
      'agencyName': 'Dagupan Panda Fire Volunteer Brigade',
      'location': 'AB West, Brgy. Tambac, Dagupan City, Pangasinan',
      'mobile': '09098765432',
      'telephone': '075-124-4531',
      'email': 'pandabrigade@gmail.com',
      'fb': 'https://www.facebook.com/pandafirebrigade/',
      'website': 'www.pandafirebrigade.com',
    },
  ];

  final List<Map<String, dynamic>> crimeAgencyContacts = [
    {
      'agencyName': 'Philippine National Police',
      'location': 'AB West, Brgy. Pantal, Dagupan City, Pangasinan',
      'mobile': '09786478934',
      'telephone': '075-123-0987',
      'email': 'pnpdagupan@gmail.com',
      'fb': 'https://www.facebook.com/pnpdagupan/',
      'website': 'www.pnp.com',
    },
    {
      'agencyName': 'Philippine National Police - Mayombo',
      'location': 'Mayombo Distric, Dagupan City, Pangasinan',
      'mobile': '09784627846',
      'telephone': '075-895-0000',
      'email': 'pnpmayombo@gmail.com',
      'fb': 'https://www.facebook.com/mayombopnp/',
      'website': 'www.mayombopnp.com',
    },
  ];

  final List<Map<String, dynamic>> medicalAgencyContacts = [
    {
      'agencyName': 'CDRRMO',
      'location': 'AB West, Brgy. Pantal, Dagupan City, Pangasinan',
      'mobile': '09786478934',
      'telephone': '075-123-0987',
      'email': 'cdr@gmail.com',
      'fb': 'https://www.facebook.com/pnpdagupan/',
      'website': 'www.pnp.com',
    },
    {
      'agencyName': 'City Disaster',
      'location': 'Mayombo Distric, Dagupan City, Pangasinan',
      'mobile': '09784627846',
      'telephone': '075-895-0000',
      'email': 'cdrrmo@gmail.com',
      'fb': 'https://www.facebook.com/mayombopnp/',
      'website': 'www.mayombopnp.com',
    },
  ];
  final List<Map<String, dynamic>> naturalAgencyContacts = [
    {
      'agencyName': 'CDRRMO - natural',
      'location': 'AB West, Brgy. Pantal, Dagupan City, Pangasinan',
      'mobile': '09786478934',
      'telephone': '075-123-0987',
      'email': 'cdr@gmail.com',
      'fb': 'https://www.facebook.com/pnpdagupan/',
      'website': 'www.pnp.com',
    },
    {
      'agencyName': 'City Disaster - natural',
      'location': 'Pantal, Dagupan City, Pangasinan',
      'mobile': '09784627846',
      'telephone': '075-895-0000',
      'email': 'cdrrmo@gmail.com',
      'fb': 'https://www.facebook.com/mayombopnp/',
      'website': 'www.mayombopnp.com',
    },
  ];
  //FIRE EMERGENCY CONTACTS
  //USED TO PASS THE DATA FROM THE TEXTFORMFIELDS TO THE MAIN SAFETY AGENCY PAGE (THIS PAGE)
  _passFireContactData(
    String name,
    String location,
    String mobile,
    String telephone,
    String email,
    String fb,
    String web,
  ) {
    setState(() {
      fireAgencyContacts.add({
        'agencyName': name,
        'location': location,
        'mobile': mobile,
        'telephone': telephone,
        'email': email,
        'fb': fb,
        'website': web,
      });
      isSelectedFireAgency.add(false);
    });
  }

  _editFireContactData(
    String name,
    String location,
    String mobile,
    String telephone,
    String email,
    String fb,
    String web,
  ) {
    setState(() {
      final editFireAgencyData = {
        'agencyName': name,
        'location': location,
        'mobile': mobile,
        'telephone': telephone,
        'email': email,
        'fb': fb,
        'website': web,
      };
      fireAgencyContacts[_currentFireAgencyIndex] = editFireAgencyData;
      print(fireAgencyContacts);
    });
  }

  //DELETE CONTACT DATA BASED ON THE INDEX
  _deleteFireContactData(int index) {
    setState(() {
      isSelectedFireAgency.removeAt(index);
      fireAgencyContacts.removeAt(index);
      print('AGENCY COUNT: ${fireAgencyContacts.length}');
    });
  }

  //USED TO CHECK IF ADD BUTTON IS TAPPED
  _onFireAddContactTapped(bool isPressed) {
    setState(() {
      _isFireAddContactPressed = isPressed;
    });
  }

  //USED TO CHECK IF ADD BUTTON IS TAPPED
  _onFireEditContactTapped(bool isPressed) {
    setState(() {
      _isFireEditContactPressed = isPressed;
    });
  }

  //USED FOR CHANGING THE DISPLAYED DATA ON CAROUSEL
  _onFireContactChange(int index) {
    setState(() {
      _currentFireAgencyIndex = index;
    });
  }

  //USED TO CHECK IF CONTACT IS SELECTED
  _onFireContactTapped(bool isSelected) {
    setState(() {
      isSelectedFireAgency[_currentFireAgencyIndex] = isSelected;
    });
  }

  //CRIME EMERGENCY CONTACTS
  //USED TO PASS THE DATA FROM THE TEXTFORMFIELDS TO THE MAIN SAFETY AGENCY PAGE (THIS PAGE)
  _passCrimeContactData(
    String name,
    String location,
    String mobile,
    String telephone,
    String email,
    String fb,
    String web,
  ) {
    setState(() {
      crimeAgencyContacts.add({
        'agencyName': name,
        'location': location,
        'mobile': mobile,
        'telephone': telephone,
        'email': email,
        'fb': fb,
        'website': web,
      });
      isSelectedCrimeAgency.add(false);
    });
  }

  _editCrimeContactData(
    String name,
    String location,
    String mobile,
    String telephone,
    String email,
    String fb,
    String web,
  ) {
    setState(() {
      final editCrimeAgencyData = {
        'agencyName': name,
        'location': location,
        'mobile': mobile,
        'telephone': telephone,
        'email': email,
        'fb': fb,
        'website': web,
      };
      crimeAgencyContacts[_currentCrimeAgencyIndex] = editCrimeAgencyData;
    });
  }

  //DELETE CONTACT DATA BASED ON THE INDEX
  _deleteCrimeContactData(int index) {
    setState(() {
      isSelectedCrimeAgency.removeAt(index);
      crimeAgencyContacts.removeAt(index);
    });
  }

  //USED TO CHECK IF ADD BUTTON IS TAPPED
  _onCrimeAddContactTapped(bool isPressed) {
    setState(() {
      _isCrimeAddContactPressed = isPressed;
    });
  }

  //USED TO CHECK IF ADD BUTTON IS TAPPED
  _onCrimeEditContactTapped(bool isPressed) {
    setState(() {
      _isCrimeEditContactPressed = isPressed;
    });
  }

  //USED FOR CHANGING THE DISPLAYED DATA ON CAROUSEL
  _onCrimeContactChange(int index) {
    setState(() {
      _currentCrimeAgencyIndex = index;
    });
  }

  //USED TO CHECK IF CONTACT IS SELECTED
  _onCrimeContactTapped(bool isSelected) {
    setState(() {
      isSelectedCrimeAgency[_currentCrimeAgencyIndex] = isSelected;
    });
  }

  //MEDICAL EMERGENCY
  //CRIME EMERGENCY CONTACTS
  //USED TO PASS THE DATA FROM THE TEXTFORMFIELDS TO THE MAIN SAFETY AGENCY PAGE (THIS PAGE)
  _passMedicalContactData(
    String name,
    String location,
    String mobile,
    String telephone,
    String email,
    String fb,
    String web,
  ) {
    setState(() {
      medicalAgencyContacts.add({
        'agencyName': name,
        'location': location,
        'mobile': mobile,
        'telephone': telephone,
        'email': email,
        'fb': fb,
        'website': web,
      });
      isSelectedMedicalAgency.add(false);
    });
  }

  _editMedicalContactData(
    String name,
    String location,
    String mobile,
    String telephone,
    String email,
    String fb,
    String web,
  ) {
    setState(() {
      final editMedicalAgencyData = {
        'agencyName': name,
        'location': location,
        'mobile': mobile,
        'telephone': telephone,
        'email': email,
        'fb': fb,
        'website': web,
      };
      medicalAgencyContacts[_currentMedicalAgencyIndex] = editMedicalAgencyData;
    });
  }

  //DELETE CONTACT DATA BASED ON THE INDEX
  _deleteMedicalContactData(int index) {
    setState(() {
      isSelectedMedicalAgency.removeAt(index);
      medicalAgencyContacts.removeAt(index);
    });
  }

  //USED TO CHECK IF ADD BUTTON IS TAPPED
  _onMedicalAddContactTapped(bool isPressed) {
    setState(() {
      _isMedicalAddContactPressed = isPressed;
    });
  }

  //USED TO CHECK IF ADD BUTTON IS TAPPED
  _onMedicalEditContactTapped(bool isPressed) {
    setState(() {
      _isMedicalEditContactPressed = isPressed;
    });
  }

  //USED FOR CHANGING THE DISPLAYED DATA ON CAROUSEL
  _onMedicalContactChange(int index) {
    setState(() {
      _currentMedicalAgencyIndex = index;
    });
  }

  //USED TO CHECK IF CONTACT IS SELECTED
  _onMedicalContactTapped(bool isSelected) {
    setState(() {
      isSelectedMedicalAgency[_currentMedicalAgencyIndex] = isSelected;
    });
  }

  //NATURAL EMERGENCY CONTACTS
  //USED TO PASS THE DATA FROM THE TEXTFORMFIELDS TO THE MAIN SAFETY AGENCY PAGE (THIS PAGE)
  _passNaturalContactData(
    String name,
    String location,
    String mobile,
    String telephone,
    String email,
    String fb,
    String web,
  ) {
    setState(() {
      naturalAgencyContacts.add({
        'agencyName': name,
        'location': location,
        'mobile': mobile,
        'telephone': telephone,
        'email': email,
        'fb': fb,
        'website': web,
      });
      isSelectedNaturalAgency.add(false);
    });
  }

  _editNaturalContactData(
    String name,
    String location,
    String mobile,
    String telephone,
    String email,
    String fb,
    String web,
  ) {
    setState(() {
      final editNaturalAgencyData = {
        'agencyName': name,
        'location': location,
        'mobile': mobile,
        'telephone': telephone,
        'email': email,
        'fb': fb,
        'website': web,
      };
      naturalAgencyContacts[_currentNaturalAgencyIndex] = editNaturalAgencyData;
    });
  }

  //DELETE CONTACT DATA BASED ON THE INDEX
  _deleteNaturalContactData(int index) {
    setState(() {
      isSelectedNaturalAgency.removeAt(index);
      naturalAgencyContacts.removeAt(index);
    });
  }

  //USED TO CHECK IF ADD BUTTON IS TAPPED
  _onNaturalAddContactTapped(bool isPressed) {
    setState(() {
      _isNaturalAddContactPressed = isPressed;
    });
  }

  //USED TO CHECK IF ADD BUTTON IS TAPPED
  _onNaturalEditContactTapped(bool isPressed) {
    setState(() {
      _isNaturalEditContactPressed = isPressed;
    });
  }

  //USED FOR CHANGING THE DISPLAYED DATA ON CAROUSEL
  _onNaturalContactChange(int index) {
    setState(() {
      _currentNaturalAgencyIndex = index;
    });
  }

  //USED TO CHECK IF CONTACT IS SELECTED
  _onNaturalContactTapped(bool isSelected) {
    setState(() {
      isSelectedNaturalAgency[_currentNaturalAgencyIndex] = isSelected;
    });
  }

  @override
  void initState() {
    isSelectedFireAgency =
        List.generate(fireAgencyContacts.length, (index) => false);
    isSelectedCrimeAgency =
        List.generate(crimeAgencyContacts.length, (index) => false);
    isSelectedMedicalAgency =
        List.generate(medicalAgencyContacts.length, (index) => false);
    isSelectedNaturalAgency =
        List.generate(naturalAgencyContacts.length, (index) => false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    final currentFireAgencyData = fireAgencyContacts.isNotEmpty
        ? fireAgencyContacts[_currentFireAgencyIndex]
        : {};

    final currentCrimeAgencyData = crimeAgencyContacts.isNotEmpty
        ? crimeAgencyContacts[_currentCrimeAgencyIndex]
        : {};

    final currentMedicalAgencyData = medicalAgencyContacts.isNotEmpty
        ? medicalAgencyContacts[_currentMedicalAgencyIndex]
        : {};

    final currentNaturalAgencyData = naturalAgencyContacts.isNotEmpty
        ? naturalAgencyContacts[_currentNaturalAgencyIndex]
        : {};

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 14, 46, 67),
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            child: SizedBox(
              height: height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //BANNER
                  Container(
                    height: height * 0.05,
                    color: Colors.white,
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //BACK BUTTON
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              String.fromCharCode(Icons.chevron_left.codePoint),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: Icons.chevron_left.fontFamily,
                                fontSize: height * 0.04,
                                fontWeight: FontWeight.w900,
                                color: const Color.fromARGB(255, 14, 46, 67),
                                package: Icons.chevron_left.fontPackage,
                              ),
                            ),
                          ),
                        ),
                        //SAFETY AGENCIES TITLE
                        Expanded(
                          flex: 4,
                          child: SizedBox(
                            width: width,
                            //color: Colors.black,
                            child: Text(
                              'SAFETY AGENCIES',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'OpunMai',
                                fontSize: height * 0.0245,
                                fontWeight: FontWeight.w700,
                                color: const Color.fromARGB(255, 14, 46, 67),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: width,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      //SUBTITLE
                      Container(
                        padding: EdgeInsets.only(top: height * 0.01),
                        alignment: Alignment.center,
                        child: Text(
                          'General Emergency SOS',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'OpunMai',
                            fontSize: height * 0.021,
                            fontWeight: FontWeight.w700,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      //DESCRIPTION
                      Container(
                        //color: Colors.lightGreen,
                        height: height * 0.075,
                        alignment: Alignment.center,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.05),
                          child: RichText(
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                            text: TextSpan(
                              text:
                                  'In case of a general emergency, all the safety agencies you\'ve',
                              style: TextStyle(
                                fontFamily: 'OpunMai',
                                fontSize: height * 0.013,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                height: 1.2,
                              ),
                              children: const [
                                TextSpan(
                                  text: ' SELECTED ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'in the categories below will receive your SOS alert. If you prefer not to notify them, you can adjust your preferences in the Emergency Contacts settings.',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      //BORDER
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.0005, bottom: height * 0.001),
                        child: Image.asset(
                          'assets/images/side_menu/emergency_mgmt/emergency_safetyagency_border.png',
                        ),
                      ),
                    ],
                  ),

                  //EMERGENCY CONTACT LIST
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: height * 0.75,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //FIRE EMERGENCY
                                Expanded(
                                  child: ContactsTemplate(
                                    agencyTypeHeading: 'Fire Emergency',
                                    agencyHeadingFontColor: Colors.yellow,
                                    agencyContactController:
                                        _fireContactController,
                                    agencyCount: fireAgencyContacts.length,
                                    agencyName:
                                        currentFireAgencyData['agencyName'] ??
                                            '',
                                    agencyLocation:
                                        currentFireAgencyData['location'] ?? '',
                                    agencyMobile:
                                        currentFireAgencyData['mobile'] ?? '',
                                    agencyTelephone:
                                        currentFireAgencyData['telephone'] ??
                                            '',
                                    agencyEmail:
                                        currentFireAgencyData['email'] ?? '',
                                    agencyFB: currentFireAgencyData['fb'] ?? '',
                                    agencyWebsite:
                                        currentFireAgencyData['website'] ?? '',
                                    onPageChanged: _onFireContactChange,
                                    onAgencySelected: _onFireContactTapped,
                                    isAddContactPressed:
                                        _isFireAddContactPressed,
                                    onAddContactPressed:
                                        _onFireAddContactTapped,
                                    isEditContactPressed:
                                        _isFireEditContactPressed,
                                    onEditContactPressed:
                                        _onFireEditContactTapped,
                                    isContactTapped:
                                        isSelectedFireAgency.isEmpty
                                            ? false
                                            : isSelectedFireAgency[
                                                _currentFireAgencyIndex],
                                    passAgencyContactData: _passFireContactData,
                                    deleteAgencyContactData:
                                        _deleteFireContactData,
                                    editAgencyContactData: _editFireContactData,
                                    agencyContactsList: fireAgencyContacts,
                                  ),
                                ),
                                //CRIME EMERGENCY
                                Expanded(
                                  child: ContactsTemplate(
                                    agencyTypeHeading:
                                        'Crime and Safety Incident',
                                    agencyHeadingFontColor:
                                        Colors.grey.shade200,
                                    agencyContactController:
                                        _crimeContactController,
                                    agencyCount: crimeAgencyContacts.length,
                                    agencyName:
                                        currentCrimeAgencyData['agencyName'] ??
                                            '',
                                    agencyLocation:
                                        currentCrimeAgencyData['location'] ??
                                            '',
                                    agencyMobile:
                                        currentCrimeAgencyData['mobile'] ?? '',
                                    agencyTelephone:
                                        currentCrimeAgencyData['telephone'] ??
                                            '',
                                    agencyEmail:
                                        currentCrimeAgencyData['email'] ?? '',
                                    agencyFB:
                                        currentCrimeAgencyData['fb'] ?? '',
                                    agencyWebsite:
                                        currentCrimeAgencyData['website'] ?? '',
                                    onPageChanged: _onCrimeContactChange,
                                    onAgencySelected: _onCrimeContactTapped,
                                    isAddContactPressed:
                                        _isCrimeAddContactPressed,
                                    onAddContactPressed:
                                        _onCrimeAddContactTapped,
                                    isEditContactPressed:
                                        _isCrimeEditContactPressed,
                                    onEditContactPressed:
                                        _onCrimeEditContactTapped,
                                    isContactTapped:
                                        isSelectedCrimeAgency.isEmpty
                                            ? false
                                            : isSelectedCrimeAgency[
                                                _currentCrimeAgencyIndex],
                                    passAgencyContactData:
                                        _passCrimeContactData,
                                    deleteAgencyContactData:
                                        _deleteCrimeContactData,
                                    editAgencyContactData:
                                        _editCrimeContactData,
                                    agencyContactsList: crimeAgencyContacts,
                                  ),
                                ),
                                //MEDICAL EMERGENCY
                                Expanded(
                                  child: ContactsTemplate(
                                    agencyTypeHeading: 'Medical Emergency',
                                    agencyHeadingFontColor:
                                        Colors.cyan.shade300,
                                    agencyContactController:
                                        _medicalContactController,
                                    agencyCount: medicalAgencyContacts.length,
                                    agencyName: currentMedicalAgencyData[
                                            'agencyName'] ??
                                        '',
                                    agencyLocation:
                                        currentMedicalAgencyData['location'] ??
                                            '',
                                    agencyMobile:
                                        currentMedicalAgencyData['mobile'] ??
                                            '',
                                    agencyTelephone:
                                        currentMedicalAgencyData['telephone'] ??
                                            '',
                                    agencyEmail:
                                        currentMedicalAgencyData['email'] ?? '',
                                    agencyFB:
                                        currentMedicalAgencyData['fb'] ?? '',
                                    agencyWebsite:
                                        currentMedicalAgencyData['website'] ??
                                            '',
                                    onPageChanged: _onMedicalContactChange,
                                    onAgencySelected: _onMedicalContactTapped,
                                    isAddContactPressed:
                                        _isMedicalAddContactPressed,
                                    onAddContactPressed:
                                        _onMedicalAddContactTapped,
                                    isEditContactPressed:
                                        _isMedicalEditContactPressed,
                                    onEditContactPressed:
                                        _onMedicalEditContactTapped,
                                    isContactTapped:
                                        isSelectedMedicalAgency.isEmpty
                                            ? false
                                            : isSelectedMedicalAgency[
                                                _currentMedicalAgencyIndex],
                                    passAgencyContactData:
                                        _passMedicalContactData,
                                    deleteAgencyContactData:
                                        _deleteMedicalContactData,
                                    editAgencyContactData:
                                        _editMedicalContactData,
                                    agencyContactsList: medicalAgencyContacts,
                                  ),
                                ),
                                //ACCIDENTS AND NATURAL DISASTER EMERGENCY
                                Expanded(
                                  child: ContactsTemplate(
                                    agencyTypeHeading:
                                        'Accident and Natural Disaster',
                                    agencyHeadingFontColor:
                                        Colors.lightGreen.shade300,
                                    agencyContactController:
                                        _naturalContactController,
                                    agencyCount: naturalAgencyContacts.length,
                                    agencyName: currentNaturalAgencyData[
                                            'agencyName'] ??
                                        '',
                                    agencyLocation:
                                        currentNaturalAgencyData['location'] ??
                                            '',
                                    agencyMobile:
                                        currentNaturalAgencyData['mobile'] ??
                                            '',
                                    agencyTelephone:
                                        currentNaturalAgencyData['telephone'] ??
                                            '',
                                    agencyEmail:
                                        currentNaturalAgencyData['email'] ?? '',
                                    agencyFB:
                                        currentNaturalAgencyData['fb'] ?? '',
                                    agencyWebsite:
                                        currentNaturalAgencyData['website'] ??
                                            '',
                                    onPageChanged: _onNaturalContactChange,
                                    onAgencySelected: _onNaturalContactTapped,
                                    isAddContactPressed:
                                        _isNaturalAddContactPressed,
                                    onAddContactPressed:
                                        _onNaturalAddContactTapped,
                                    isEditContactPressed:
                                        _isNaturalEditContactPressed,
                                    onEditContactPressed:
                                        _onNaturalEditContactTapped,
                                    isContactTapped:
                                        isSelectedNaturalAgency.isEmpty
                                            ? false
                                            : isSelectedNaturalAgency[
                                                _currentNaturalAgencyIndex],
                                    passAgencyContactData:
                                        _passNaturalContactData,
                                    deleteAgencyContactData:
                                        _deleteNaturalContactData,
                                    editAgencyContactData:
                                        _editNaturalContactData,
                                    agencyContactsList: naturalAgencyContacts,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.015,
                                ),
                              ],
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
        ),
      ),
    );
  }
}
