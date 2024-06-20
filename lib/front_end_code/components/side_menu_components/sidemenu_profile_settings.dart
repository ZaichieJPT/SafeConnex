// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_authentication.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_storage.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_auth.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_profile_storage.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_users_database.dart';
import 'package:safeconnex/controller/app_manager.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/change_to_agency/sidemenu_changetoagency_dialog.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/sidemenu_deleteAccount_passdialog.dart';
import 'package:safeconnex/front_end_code/provider/setting_provider.dart';
import 'package:safeconnex/front_end_code/components/home_components/error_snackbar.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/sidemenu_feedback_dialog.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/sidemenu_logout_dialog.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/sidemenu_deleteAccount_dialog.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/sidemenu_profile_option.dart';
import 'package:intl/intl.dart';

class ProfileSettings extends StatefulWidget {
  final double height;
  final double width;

  const ProfileSettings({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final provider = SettingsProvider();
  final _profileFormKey = GlobalKey<FormState>();
  final _profileDateFormKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  SafeConnexProfileStorage profileStorage = SafeConnexProfileStorage();
  double innerHeight = 0;
  double innerWidth = 0;
  int _selectedMenuIndex = 4;
  String? _phoneNumber = '000000000';
  String? _birthDate = 'January 15, 2001';
  bool _isProfileEditable = false;

  void _onMenuTapped(int index) {
    setState(() {
      _selectedMenuIndex = index;
    });
  }

  Future<void> _onProfileTapped() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    profileStorage.uploadProfilePic(
        SafeConnexAuthentication.currentUser!.uid, image!.path);
    if (image == null) return;
  }

  void _onShareFeedback() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FeedbackDialog(
          height: widget.height,
          width: widget.width,
        );
      },
    );
  }

  void _onLogout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LogoutDialog(
          height: widget.height,
          width: widget.width,
        );
      },
    );
  }

  void _onDeleteAccount() async {
    final isConfirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return DeleteAccountDialog(
          height: widget.height,
          width: widget.width,
        );
      },
    );

    if (isConfirmed == true && context.mounted) {
      final password = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return DeleteDialogPassField(
            height: widget.height,
            width: widget.width,
          );
        },
      );

      if (password != null && password.isNotEmpty) {
        // Perform account deletion logic using password
        // ... your account deletion code here
      } else {
        // Handle case where user cancels password dialog or enters empty password
      }
    }
  }

  bool validatePhilippineMobileNumber(String value) {
    final regex = RegExp(r'^[+]*[6]?[3][9][0-9]{9}$');
    return regex.hasMatch(value);
  }

  void validateAndSavePhoneNumber() {
    final currentState = _profileFormKey.currentState;
    if (currentState != null && currentState.validate()) {
      currentState.save();
      setState(() {
        _phoneNumber = '9${_phoneController.text}';
        _isProfileEditable = !_isProfileEditable;
      });
    } else {}
  }

  void validateAndSaveBirthDate() {
    final currentState = _profileDateFormKey.currentState;
    if (currentState != null && currentState.validate()) {
      currentState.save();
      setState(() {
        _birthDate = _birthdateController.text;
        _isProfileEditable = !_isProfileEditable;
      });
    } else {}
  }

  @override
  void initState() {
    super.initState();
    _phoneController.text = _phoneNumber!;
    _birthdateController.text = _birthDate!;
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _birthdateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //AppManager.userDatabaseHandler.getRegularUser(AppManager.authHandler.authHandler.currentUser!.uid);
    Future.delayed(Duration(milliseconds: 500), () {
      _phoneNumber = "test";
      _birthDate = "day";
    });
    return Column(
      children: [
        //PROFILE CARD AREA
        Flexible(
          flex: 12,
          child: Container(
            height: widget.height * 0.46,
            width: widget.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: const [
                  Color.fromARGB(255, 221, 221, 221),
                  Color.fromARGB(255, 241, 241, 241),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              border: Border(
                //bottom: BorderSide(width: 1),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //OUTER PROFILE CARD CONTAINER
                Flexible(
                  flex: 9,
                  child: Padding(
                    padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                    child: LayoutBuilder(builder: (context, constraints) {
                      innerHeight = constraints.maxHeight;
                      innerWidth = constraints.maxWidth;

                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          //PROFILE CARD
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: innerHeight * 0.83,
                              //height: 215,
                              width: innerWidth,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 241, 241, 241),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  width: 2.5,
                                  color: Colors.white,
                                ),
                              ),

                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  //EDIT PROFILE BUTTON
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: innerHeight * 0.02,
                                      right: innerHeight * 0.03,
                                      bottom: innerHeight * 0.02,
                                    ),
                                    child: Tooltip(
                                      message: 'Edit Profile',
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (_isProfileEditable) {
                                              validateAndSavePhoneNumber();
                                              //_isProfileEditable = !_isProfileEditable;
                                            } else {
                                              _isProfileEditable =
                                              !_isProfileEditable;
                                            }
                                          });
                                        },
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Image.asset(
                                            _isProfileEditable
                                                ? 'assets/images/side_menu/sidemenu_check_icon.png'
                                                : 'assets/images/side_menu/sidemenu_edit_icon.png',
                                            scale: 2.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  //PROFILE NAME
                                  Flexible(
                                    flex: 2,
                                    child: FittedBox(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: innerHeight * 0.05,
                                        ),
                                        child: Text(
                                          '${SafeConnexAuthentication.currentUser!.displayName}',
                                          style: TextStyle(
                                            fontFamily: 'OpunMai',
                                            fontSize: innerHeight * 0.11,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  //PROFILE EMAIL
                                  Flexible(
                                    child: FittedBox(
                                      child: Text(
                                        'Email: ${SafeConnexAuthentication.currentUser!.email}',
                                        style: TextStyle(
                                          fontFamily: 'OpunMai',
                                          fontSize: widget.height * 0.018,
                                        ),
                                      ),
                                    ),
                                  ),
                                  //PROFILE PHONE
                                  Flexible(
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          _isProfileEditable
                                              ? 'Phone Number: +639'
                                              : 'Phone Number: +63',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'OpunMai',
                                            fontSize: widget.height * 0.018,
                                            fontWeight: _isProfileEditable
                                                ? FontWeight.w700
                                                : FontWeight.w400,
                                            color: _isProfileEditable
                                                ? Color.fromARGB(
                                                255, 70, 85, 104)
                                                : Colors.black,
                                          ),
                                        ),
                                        _isProfileEditable
                                            ? Container(
                                            width: widget.width * 0.28,
                                            alignment: Alignment.center,
                                            //color: Colors.amber,

                                            //PHONE TEXT FIELD
                                            child: Form(
                                              key: _profileFormKey,
                                              child: TextFormField(
                                                controller:
                                                _phoneController,
                                                autofocus: true,
                                                validator: (value) {
                                                  return provider
                                                      .phoneNumberValidator(
                                                      context,
                                                      widget.height,
                                                      widget.width,
                                                      value!);
                                                },
                                                textAlign: TextAlign.center,
                                                cursorColor: Colors.grey,
                                                maxLength: 9,
                                                keyboardType:
                                                TextInputType.phone,
                                                style: TextStyle(
                                                  fontFamily: 'OpunMai',
                                                  fontSize:
                                                  widget.height * 0.018,
                                                  fontWeight:
                                                  _isProfileEditable
                                                      ? FontWeight.w700
                                                      : FontWeight.w400,
                                                  color: _isProfileEditable
                                                      ? Color.fromARGB(
                                                      255, 70, 85, 104)
                                                      : Colors.black,
                                                ),
                                                decoration: InputDecoration(
                                                  counterText: '',
                                                  border: _isProfileEditable
                                                      ? UnderlineInputBorder()
                                                      : InputBorder.none,
                                                  focusedBorder:
                                                  _isProfileEditable
                                                      ? UnderlineInputBorder(
                                                    borderSide:
                                                    BorderSide(
                                                      color: Color
                                                          .fromARGB(
                                                          255,
                                                          70,
                                                          85,
                                                          104),
                                                      width: 2,
                                                    ),
                                                  )
                                                      : InputBorder
                                                      .none,
                                                ),
                                              ),
                                            ))
                                            : Container(
                                          width: widget.width * 0.24,
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${_phoneNumber}',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: 'OpunMai',
                                              fontSize:
                                              widget.height * 0.018,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //PROFILE BIRTHDATE
                                  Flexible(
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Birthdate: ',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'OpunMai',
                                            fontSize: widget.height * 0.018,
                                            fontWeight: _isProfileEditable
                                                ? FontWeight.w700
                                                : FontWeight.w400,
                                            color: _isProfileEditable
                                                ? Color.fromARGB(
                                                255, 70, 85, 104)
                                                : Colors.black,
                                          ),
                                        ),
                                        _isProfileEditable
                                            ? Container(
                                            width: widget.width * 0.4,
                                            alignment: Alignment.center,
                                            //color: Colors.amber,

                                            //BIRTHDATE TEXT FIELD
                                            child: Form(
                                              key: _profileDateFormKey,
                                              child: TextFormField(
                                                onTap: () async {
                                                  DateTime? datePicked =
                                                  await showDatePicker(
                                                    context: context,
                                                    initialDate:
                                                    DateTime.now(),
                                                    firstDate:
                                                    DateTime(1900),
                                                    lastDate:
                                                    DateTime(2100),
                                                  );
                                                  if (datePicked != null) {
                                                    setState(() {
                                                      _birthdateController
                                                          .text = DateFormat(
                                                          'yMMMMd')
                                                          .format(
                                                          datePicked);
                                                      _birthDate =
                                                          _birthdateController
                                                              .text;
                                                    });
                                                  }
                                                },

                                                controller:
                                                _birthdateController,
                                                readOnly: true,

                                                validator: (value) {
                                                  return provider
                                                      .birthdateValidator(
                                                      context,
                                                      widget.height,
                                                      widget.width,
                                                      value!);
                                                },
                                                textAlign: TextAlign.center,
                                                cursorColor: Colors.grey,
                                                //maxLength: 9,
                                                keyboardType:
                                                TextInputType.datetime,
                                                style: TextStyle(
                                                  fontFamily: 'OpunMai',
                                                  fontSize:
                                                  widget.height * 0.018,
                                                  fontWeight:
                                                  _isProfileEditable
                                                      ? FontWeight.w700
                                                      : FontWeight.w400,
                                                  color: _isProfileEditable
                                                      ? Color.fromARGB(
                                                      255, 70, 85, 104)
                                                      : Colors.black,
                                                ),
                                                decoration: InputDecoration(
                                                  counterText: '',
                                                  border: _isProfileEditable
                                                      ? UnderlineInputBorder()
                                                      : InputBorder.none,
                                                  focusedBorder:
                                                  _isProfileEditable
                                                      ? UnderlineInputBorder(
                                                    borderSide:
                                                    BorderSide(
                                                      color: Color
                                                          .fromARGB(
                                                          255,
                                                          70,
                                                          85,
                                                          104),
                                                      width: 2,
                                                    ),
                                                  )
                                                      : InputBorder
                                                      .none,
                                                ),
                                              ),
                                            ))
                                            : Container(
                                          width: widget.width * 0.32,
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${_birthDate}',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: 'OpunMai',
                                              fontSize:
                                              widget.height * 0.018,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: innerHeight * 0.02),
                                  //CHANGE TO AGENCY BUTTON
                                  Flexible(
                                    flex: 3,
                                    child: Container(
                                      height: innerHeight * 0.2,
                                      width: innerWidth,
                                      decoration: BoxDecoration(
                                        color:
                                        Color.fromARGB(255, 168, 165, 165),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(27),
                                          bottomRight: Radius.circular(27),
                                        ),
                                      ),
                                      child: FractionallySizedBox(
                                        widthFactor: 0.7,
                                        heightFactor: 0.45,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return ChangeToAgency(
                                                  height: widget.height,
                                                  width: widget.width,
                                                );
                                              },
                                            );
                                          },
                                          style: ButtonStyle(
                                            overlayColor:
                                            MaterialStateProperty.all(
                                              const Color.fromARGB(50, 0, 0, 0),
                                            ),
                                            backgroundColor:
                                            MaterialStateProperty.all(
                                              Color.fromARGB(
                                                  255, 123, 123, 123),
                                            ),
                                            side: MaterialStateProperty.all<
                                                BorderSide>(
                                              BorderSide(
                                                color: Colors.white,
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                          child: FittedBox(
                                            child: Text(
                                              'Change to Agency Access',
                                              style: TextStyle(
                                                fontFamily: 'OpunMai',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                letterSpacing: -0.05,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //PROFILE PICTURE
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: widget.height * 0.12,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: _isProfileEditable
                                          ? _onProfileTapped
                                          : null,
                                      child: CircleAvatar(
                                        radius: innerHeight * 0.168,
                                        backgroundColor: _isProfileEditable
                                            ? Color.fromARGB(255, 70, 85, 104)
                                            : Colors.white,
                                        child: CircleAvatar(
                                          backgroundColor: Color.fromARGB(
                                              255, 112, 144, 142),
                                          foregroundColor: Colors.white,
                                          radius: innerHeight * 0.155,
                                          child: SafeConnexProfileStorage
                                              .imageUrl !=
                                              null
                                              ? Image.network(
                                              SafeConnexProfileStorage
                                                  .imageUrl!)
                                              : Container(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  //PHOTO ICON PROFILE
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: widget.height * 0.027,
                                      child: _isProfileEditable
                                          ? Row(
                                        children: [
                                          Flexible(
                                            flex: 10,
                                            child: Container(
                                              //color: Colors.yellow,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              //color: Colors.grey,
                                              child: Image.asset(
                                                  'assets/images/side_menu/profilesettings_picker_icon.png'),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 7,
                                            child: Container(
                                              //color: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      )
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                //MORE ACCOUNT SETTINGS
                Flexible(
                  flex: 2,
                  child: Row(
                    children: const [
                      Flexible(
                        child: FractionallySizedBox(
                          widthFactor: 0.2,
                        ),
                      ),
                      Center(
                        child: Text(
                          'More Account Settings:',
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'OpunMai',
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 120, 120, 120),
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
        //CHANGE PASSWORD
        Flexible(
          flex: 2,
          child: ProfileOption(
              optionText: 'Change Password',
              image: 'assets/images/side_menu/sidemenu_changepass_icon.png',
              index: 0,
              selectedMenuIndex: _selectedMenuIndex,
              onMenuTapped: _onMenuTapped,
              onTap: () {
                Navigator.pushNamed(context, '/changePassword');
              }),
        ),
        //SHARE YOUR FEEDBACK
        Flexible(
          flex: 2,
          child: ProfileOption(
            optionText: 'Share your Feedback',
            image: 'assets/images/side_menu/sidemenu_feedback_icon.png',
            index: 1,
            selectedMenuIndex: _selectedMenuIndex,
            onMenuTapped: _onMenuTapped,
            onTap: _onShareFeedback,
          ),
        ),
        //LOGOUT
        Flexible(
          flex: 2,
          child: ProfileOption(
            optionText: 'Log Out your Account',
            image: 'assets/images/side_menu/sidemenu_logout_icon.png',
            index: 2,
            selectedMenuIndex: _selectedMenuIndex,
            onMenuTapped: _onMenuTapped,
            onTap: _onLogout,
          ),
        ),
        //DELETE ACCOUNT
        Flexible(
          flex: 2,
          child: ProfileOption(
            optionText: 'Delete Account',
            image: 'assets/images/side_menu/sidemenu_delete_icon.png',
            index: 3,
            selectedMenuIndex: _selectedMenuIndex,
            onMenuTapped: _onMenuTapped,
            onTap: _onDeleteAccount,
          ),
        ),
      ],
    );
  }
}