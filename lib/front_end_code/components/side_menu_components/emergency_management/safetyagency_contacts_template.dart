// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:safeconnex/front_end_code/components/home_components/error_snackbar.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/emergency_management/safetyagency_add_contact.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/emergency_management/safetyagency_delete_dialog.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/emergency_management/safetyagency_edit_contact.dart';

class ContactsTemplate extends StatefulWidget {
  final String agencyTypeHeading;
  final Color agencyHeadingFontColor;
  final CarouselController agencyContactController;
  final int agencyCount;
  final String agencyName;
  final String agencyLocation;
  final String agencyMobile;
  final String agencyTelephone;
  final String agencyEmail;
  final String agencyFB;
  final String agencyWebsite;
  final Function onAgencySelected;
  final Function onPageChanged;
  final Function onAddContactPressed;
  final Function onEditContactPressed;
  final Function passAgencyContactData;
  final Function editAgencyContactData;
  final Function deleteAgencyContactData;
  final List<Map<String, dynamic>> agencyContactsList;
  bool isContactTapped;
  bool isAddContactPressed;
  bool isEditContactPressed;

  ContactsTemplate({
    super.key,
    required this.agencyContactController,
    required this.agencyCount,
    required this.agencyName,
    required this.agencyLocation,
    required this.agencyMobile,
    required this.agencyTelephone,
    required this.agencyEmail,
    required this.agencyFB,
    required this.agencyWebsite,
    required this.onPageChanged,
    required this.onAgencySelected,
    required this.isContactTapped,
    required this.onAddContactPressed,
    required this.isAddContactPressed,
    required this.agencyTypeHeading,
    required this.agencyHeadingFontColor,
    required this.passAgencyContactData,
    required this.deleteAgencyContactData,
    required this.agencyContactsList,
    required this.onEditContactPressed,
    required this.isEditContactPressed,
    required this.editAgencyContactData,
  });

  @override
  State<ContactsTemplate> createState() => _ContactsTemplateState();
}

class _ContactsTemplateState extends State<ContactsTemplate> {
  final _agencyAddContactFormKey = GlobalKey<FormState>();
  final _agencyEditContactFormKey = GlobalKey<FormState>();
  TextEditingController _agencyNameController = TextEditingController();
  TextEditingController _agencyLocationController = TextEditingController();
  TextEditingController _agencyMobileController = TextEditingController();
  TextEditingController _agencyTelephoneController = TextEditingController();
  TextEditingController _agencyEmailController = TextEditingController();
  TextEditingController _agencyFBController = TextEditingController();
  TextEditingController _agencyWebController = TextEditingController();

  int _currentContactIndex = 0;

  var dragGesturePosition = Offset.zero;
  bool _showMagnifier = false;
  bool _showEmptyContact = false;
  bool _isDeleteConfirmed = false;

  _onDeleteConfirmed(bool isConfirmed) {
    setState(() {
      _isDeleteConfirmed = isConfirmed;
    });
  }

  Future deleteDialog() => showDialog(
        context: context,
        builder: (BuildContext context) {
          return DeleteDialog(
            onDeleteTapped: _onDeleteConfirmed,
          );
        },
      );

  @override
  void dispose() {
    _agencyNameController.dispose();
    _agencyLocationController.dispose();
    _agencyMobileController.dispose();
    _agencyTelephoneController.dispose();
    _agencyEmailController.dispose();
    _agencyFBController.dispose();
    _agencyWebController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _showEmptyContact = widget.agencyContactsList.isEmpty ? true : false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Container(
      width: width,
      height: height * 0.015,
      //color: Colors.grey,
      child: Column(
        children: [
          //SAFETY AGENCY CONTACT HEADING
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Row(
              children: [
                //SAFETY AGENCY TYPE
                Expanded(
                  flex: 3,
                  child: Container(
                    height: height * 0.035,
                    //color: Colors.lightBlue,
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      child: Text(
                        widget.agencyTypeHeading,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'OpunMai',
                          fontSize: height * 0.02,
                          fontWeight: FontWeight.w700,
                          color: widget.agencyHeadingFontColor,
                        ),
                      ),
                    ),
                  ),
                ),
                //ADD DELETE EDIT BUTTONS
                Expanded(
                  child: Container(
                    height: height * 0.035,
                    //color: Colors.red,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //ADD BUTTON
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (widget.isAddContactPressed) {
                                //IF ALL FIELDS ARE EMPTY, CANCEL
                                if (widget.isEditContactPressed) {
                                  print('no click');
                                } else if (_agencyNameController.text.isEmpty &&
                                    _agencyLocationController.text.isEmpty &&
                                    _agencyMobileController.text.isEmpty &&
                                    _agencyTelephoneController.text.isEmpty &&
                                    _agencyEmailController.text.isEmpty &&
                                    _agencyFBController.text.isEmpty &&
                                    _agencyWebController.text.isEmpty) {
                                  // if (widget.agencyContactsList.isNotEmpty) {
                                  //   widget.onAgencySelected(false);
                                  // }
                                  widget.isAddContactPressed =
                                      !widget.isAddContactPressed;
                                  widget.onAddContactPressed(
                                      widget.isAddContactPressed);
                                } else if (_agencyAddContactFormKey
                                    .currentState!
                                    .validate()) {
                                  setState(() {
                                    //CHANGE BOOLEAN FLAG AND PASS NEW VALUE TO MAIN PARENT
                                    widget.isAddContactPressed =
                                        !widget.isAddContactPressed;
                                    widget.onAddContactPressed(
                                        widget.isAddContactPressed);
                                    //PASS NEW CONTACT DATA TO MAIN PARENT
                                    widget.passAgencyContactData(
                                      _agencyNameController.text,
                                      _agencyLocationController.text,
                                      _agencyMobileController.text,
                                      _agencyTelephoneController.text,
                                      _agencyEmailController.text,
                                      _agencyFBController.text,
                                      _agencyWebController.text,
                                    );

                                    Future.delayed(Duration(milliseconds: 500),
                                        () {
                                      _showEmptyContact = false;
                                      //widget.onAgencySelected(false);
                                      _currentContactIndex =
                                          widget.agencyContactsList.length - 1;
                                      widget.onPageChanged(
                                          widget.agencyContactsList.length - 1);
                                      widget.agencyContactController.jumpToPage(
                                          widget.agencyContactsList.length - 1);

                                      //UNSET TEXT EDITING CONTROLLERS
                                      _agencyNameController.clear();
                                      _agencyLocationController.clear();
                                      _agencyMobileController.clear();
                                      _agencyTelephoneController.clear();
                                      _agencyEmailController.clear();
                                      _agencyFBController.clear();
                                      _agencyWebController.clear();
                                    });
                                  });
                                }
                              } else if (!widget.isAddContactPressed &&
                                  !widget.isEditContactPressed) {
                                widget.isAddContactPressed =
                                    !widget.isAddContactPressed;
                                widget.onAddContactPressed(
                                    widget.isAddContactPressed);
                              } else {
                                print('norp');
                              }
                            });
                          },
                          child: Container(
                            height: width * 0.055,
                            width: width * 0.055,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(width * 0.01),
                            ),
                            child: Icon(
                              widget.isAddContactPressed
                                  ? Icons.bookmark
                                  : Icons.add,
                              size: width * 0.055,
                              color: Color.fromARGB(255, 14, 46, 67),
                            ),
                          ),
                        ),
                        //DELETE BUTTON
                        InkWell(
                          onTap: () async {
                            if (widget.isAddContactPressed ||
                                widget.isEditContactPressed) {
                              print('No delete');
                            }
                            // else if (!widget.isContactTapped &&
                            //     widget.agencyContactsList.isNotEmpty) {
                            //   showErrorMessage(
                            //     context,
                            //     'Select a Safety Agency Emergency Contact to be deleted.',
                            //     height,
                            //     width,
                            //   );
                            // }
                            else if (widget.agencyContactsList.isEmpty) {
                              showErrorMessage(
                                  context,
                                  'No Emergency Contact to be deleted.',
                                  height,
                                  width);
                            } else {
                              await deleteDialog();
                              setState(() {
                                print('Confirmed: $_isDeleteConfirmed');
                                if (_isDeleteConfirmed) {
                                  if (widget.agencyCount > 1 &&
                                      _currentContactIndex == 0) {
                                    Future.delayed(Duration(milliseconds: 500),
                                        () {
                                      widget.agencyContactController.jumpToPage(
                                        _currentContactIndex,
                                      );
                                    });

                                    // widget.deleteAgencyContactData(
                                    //     _currentContactIndex);
                                  } else if (_currentContactIndex > 0) {
                                    widget.agencyContactController
                                        .previousPage();

                                    widget.onPageChanged(
                                        _currentContactIndex - 1);
                                  } else {
                                    _showEmptyContact = true;
                                    // widget.deleteAgencyContactData(
                                    //     _currentContactIndex);
                                  }
                                  widget.deleteAgencyContactData(
                                      _currentContactIndex);
                                }
                              });
                            }
                          },
                          child: Container(
                            height: width * 0.055,
                            width: width * 0.055,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(width * 0.01),
                            ),
                            child: Icon(
                              CupertinoIcons.delete,
                              size: width * 0.05,
                              color: Color.fromARGB(255, 14, 46, 67),
                            ),
                          ),
                        ),
                        //EDIT BUTTON
                        InkWell(
                          onTap: () {
                            if (widget.isAddContactPressed) {
                              print('you shall not click');
                            }
                            // else if (!widget.isContactTapped &&
                            //     widget.agencyContactsList.isNotEmpty) {
                            //   showErrorMessage(
                            //     context,
                            //     'Select a Safety Agency Emergency Contact to be updated',
                            //     height,
                            //     width,
                            //   );
                            // }
                            else if (widget.agencyContactsList.isEmpty) {
                              showErrorMessage(
                                context,
                                'No Emergency Contact to be updated',
                                height,
                                width,
                              );
                            } else if (widget.isEditContactPressed) {
                              //IF NOTHING CHANGED, CANCEL EDIT
                              if (_agencyNameController.text ==
                                      widget.agencyName &&
                                  _agencyLocationController.text ==
                                      widget.agencyLocation &&
                                  _agencyMobileController.text ==
                                      widget.agencyMobile &&
                                  _agencyTelephoneController.text ==
                                      widget.agencyTelephone &&
                                  _agencyEmailController.text ==
                                      widget.agencyEmail &&
                                  _agencyFBController.text == widget.agencyFB &&
                                  _agencyWebController.text ==
                                      widget.agencyWebsite) {
                                //UNSET TEXT EDITING CONTROLLERS
                                _agencyNameController.clear();
                                _agencyLocationController.clear();
                                _agencyMobileController.clear();
                                _agencyTelephoneController.clear();
                                _agencyEmailController.clear();
                                _agencyFBController.clear();
                                _agencyWebController.clear();
                                //CHANGE ISEDIT FLAG
                                widget.isEditContactPressed =
                                    !widget.isEditContactPressed;
                                widget.onEditContactPressed(
                                    widget.isEditContactPressed);
                                //IF ENTERED DATA HAS NO ERROR
                              } else if (_agencyEditContactFormKey.currentState!
                                  .validate()) {
                                widget.editAgencyContactData(
                                  _agencyNameController.text,
                                  _agencyLocationController.text,
                                  _agencyMobileController.text,
                                  _agencyTelephoneController.text,
                                  _agencyEmailController.text,
                                  _agencyFBController.text,
                                  _agencyWebController.text,
                                );

                                //UNSET TEXT EDITING CONTROLLERS
                                _agencyNameController.clear();
                                _agencyLocationController.clear();
                                _agencyMobileController.clear();
                                _agencyTelephoneController.clear();
                                _agencyEmailController.clear();
                                _agencyFBController.clear();
                                _agencyWebController.clear();

                                widget.isEditContactPressed =
                                    !widget.isEditContactPressed;
                                widget.onEditContactPressed(
                                    widget.isEditContactPressed);
                                widget.isContactTapped =
                                    !widget.isContactTapped;
                                widget.onAgencySelected(widget.isContactTapped);
                              }
                            } else {
                              setState(() {
                                _agencyNameController.text = widget.agencyName;
                                _agencyLocationController.text =
                                    widget.agencyLocation;
                                _agencyMobileController.text =
                                    widget.agencyMobile;
                                _agencyTelephoneController.text =
                                    widget.agencyTelephone;
                                _agencyEmailController.text =
                                    widget.agencyEmail;
                                _agencyFBController.text = widget.agencyFB;
                                _agencyWebController.text =
                                    widget.agencyWebsite;

                                widget.isEditContactPressed =
                                    !widget.isEditContactPressed;

                                widget.onEditContactPressed(
                                    widget.isEditContactPressed);
                              });
                            }
                          },
                          child: Container(
                            height: width * 0.055,
                            width: width * 0.055,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(width * 0.01),
                            ),
                            child: Icon(
                              widget.isEditContactPressed
                                  ? Icons.check
                                  : Icons.edit_outlined,
                              size: width * 0.055,
                              color: Color.fromARGB(255, 14, 46, 67),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          //SAFETY AGENCY CONTACT CARD AND BUTTONS
          Expanded(
            child: Container(
              //color: Colors.yellow.shade200,
              height: height,
              child: Row(
                children: [
                  //PREVIOUS BUTTON
                  Expanded(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          if (widget.agencyContactsList.isNotEmpty &&
                              !widget.isAddContactPressed &&
                              !widget.isEditContactPressed) {
                            widget.agencyContactController.previousPage();
                            //widget.onAgencySelected(false);
                          } else if (_currentContactIndex == 0) {
                            //DO NOTHING IF THIS IS THE FIRST CONTACT/INDEX
                          }
                        });
                      },
                      child: Text(
                        String.fromCharCode(Icons.chevron_left.codePoint),
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontFamily: Icons.chevron_left.fontFamily,
                          fontSize: height * 0.05,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          package: Icons.chevron_left.fontPackage,
                        ),
                      ),
                    ),
                  ),
                  //CENTER CONTACT INFO
                  Expanded(
                    flex: 5,
                    child: Container(
                      //color: Colors.lightGreen.shade300,
                      child: CarouselSlider.builder(
                        itemCount: widget.agencyContactsList.isEmpty
                            ? 1
                            : widget.agencyCount,
                        carouselController: widget.agencyContactController,
                        itemBuilder: ((context, carouselPageIndex, realIndex) {
                          return _showEmptyContact &&
                                  !widget.isAddContactPressed
                              ? Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: width * 0.08,
                                        right: width * 0.08,
                                      ),
                                      child: Container(
                                        height: height,
                                        //color: Colors.deepPurple[200],
                                      ),
                                    ),
                                    //MAIN AGENCY CONTACT CONTAINER
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: width * 0.08,
                                        right: width * 0.08,
                                        top: height * 0.0125,
                                        bottom: height * 0.01,
                                      ),
                                      child: Container(
                                        height: height,
                                        width: width,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 244, 244, 244),
                                          borderRadius: BorderRadius.circular(
                                              width * 0.03),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 205, 206, 204),
                                              offset: Offset(0, 5),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top: height * 0.013,
                                            bottom: height * 0.008,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              //INFO ICON
                                              Icon(
                                                Icons.info_outline,
                                                color: Color.fromARGB(
                                                        133, 14, 46, 67)
                                                    .withOpacity(0.5),
                                                size: width * 0.1,
                                              ),
                                              SizedBox(
                                                height: height * 0.01,
                                              ),
                                              //EMPTY TEXT
                                              Text(
                                                'No safety agency emergency contacts saved.',
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                  fontFamily: 'OpunMai',
                                                  fontWeight: FontWeight.w500,
                                                  //fontStyle: FontStyle.italic,
                                                  fontSize: height * 0.0155,
                                                  color: Color.fromARGB(
                                                          255, 14, 46, 67)
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : widget.isAddContactPressed
                                  ? AddContact(
                                      agencyContactFormKey:
                                          _agencyAddContactFormKey,
                                      agencyNameController:
                                          _agencyNameController,
                                      agencyLocationController:
                                          _agencyLocationController,
                                      agencyMobileController:
                                          _agencyMobileController,
                                      agencyTelephoneController:
                                          _agencyTelephoneController,
                                      agencyEmailController:
                                          _agencyEmailController,
                                      agencyFBController: _agencyFBController,
                                      agencyWebController: _agencyWebController,
                                    )
                                  : widget.isEditContactPressed
                                      ? EditContact(
                                          agencyContactFormKey:
                                              _agencyEditContactFormKey,
                                          agencyNameController:
                                              _agencyNameController,
                                          agencyLocationController:
                                              _agencyLocationController,
                                          agencyMobileController:
                                              _agencyMobileController,
                                          agencyTelephoneController:
                                              _agencyTelephoneController,
                                          agencyEmailController:
                                              _agencyEmailController,
                                          agencyFBController:
                                              _agencyFBController,
                                          agencyWebController:
                                              _agencyWebController,
                                          isSelected: widget.isContactTapped,
                                        )
                                      : Stack(
                                          alignment: Alignment.topCenter,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: width * 0.08,
                                                right: width * 0.08,
                                              ),
                                              child: Container(
                                                height: height,
                                                //color: Colors.deepPurple[200],
                                              ),
                                            ),
                                            //MAIN AGENCY CONTACT CONTAINER
                                            GestureDetector(
                                              onPanUpdate: (details) {
                                                setState(() {
                                                  dragGesturePosition =
                                                      details.localPosition;
                                                  _showMagnifier = true;
                                                });
                                              },
                                              onPanEnd: (details) {
                                                setState(() {
                                                  _showMagnifier = false;
                                                });
                                              },
                                              onTap: () {
                                                setState(() {
                                                  widget.isContactTapped =
                                                      !widget.isContactTapped;
                                                  widget.onAgencySelected(
                                                      widget.isContactTapped);
                                                });
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: width * 0.08,
                                                  right: width * 0.08,
                                                  top: height * 0.007,
                                                  bottom: height * 0.0075,
                                                ),
                                                child: Container(
                                                  height: height,
                                                  width: width,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 244, 244, 244),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            width * 0.03),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Color.fromARGB(
                                                            255, 205, 206, 204),
                                                        offset: Offset(0, 5),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      top: height * 0.01,
                                                      bottom: height * 0.0015,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        //CONTACT TITLE
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: width * 0.04,
                                                            right: width * 0.04,
                                                          ),
                                                          child: Tooltip(
                                                            textAlign: TextAlign
                                                                .center,
                                                            preferBelow: false,
                                                            textStyle:
                                                                TextStyle(
                                                              fontFamily:
                                                                  'OpunMai',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: height *
                                                                  0.015,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      14,
                                                                      46,
                                                                      67),
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.grey
                                                                  .shade100,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          width *
                                                                              0.025),
                                                            ),
                                                            message: widget
                                                                .agencyName,
                                                            child: Text(
                                                              widget.agencyName,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'OpunMai',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize:
                                                                    height *
                                                                        0.013,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        14,
                                                                        46,
                                                                        67),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        //AGENCY LOCATION
                                                        Row(
                                                          children: [
                                                            Container(
                                                              //color: Colors.grey,
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left: width *
                                                                    0.025,
                                                                right: width *
                                                                    0.01,
                                                              ),

                                                              child:
                                                                  Image.asset(
                                                                'assets/images/side_menu/emergency_mgmt/safetyagency_location_icon.png',
                                                                width: width *
                                                                    0.035,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                // color:
                                                                //     Colors.brown,
                                                                child: Tooltip(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  preferBelow:
                                                                      false,
                                                                  textStyle:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'OpunMai',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        height *
                                                                            0.015,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            14,
                                                                            46,
                                                                            67),
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade100,
                                                                    borderRadius:
                                                                        BorderRadius.circular(width *
                                                                            0.025),
                                                                  ),
                                                                  message: widget
                                                                      .agencyLocation,
                                                                  child: Text(
                                                                    widget
                                                                        .agencyLocation,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'OpunMai',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          height *
                                                                              0.01,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          14,
                                                                          46,
                                                                          67),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        //AGENCY MOBILE
                                                        Row(
                                                          children: [
                                                            Container(
                                                              //color: Colors.grey,
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left: width *
                                                                    0.025,
                                                                right: width *
                                                                    0.01,
                                                              ),

                                                              child:
                                                                  Image.asset(
                                                                'assets/images/side_menu/emergency_mgmt/safetyagency_mobile_icon.png',
                                                                width: width *
                                                                    0.035,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                // color:
                                                                //     Colors.brown,
                                                                child: Tooltip(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  preferBelow:
                                                                      false,
                                                                  textStyle:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'OpunMai',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        height *
                                                                            0.015,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            14,
                                                                            46,
                                                                            67),
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade100,
                                                                    borderRadius:
                                                                        BorderRadius.circular(width *
                                                                            0.025),
                                                                  ),
                                                                  message: widget
                                                                      .agencyMobile,
                                                                  child: Text(
                                                                    widget
                                                                        .agencyMobile,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'OpunMai',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          height *
                                                                              0.01,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          14,
                                                                          46,
                                                                          67),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        //AGENCY TELEPHONE
                                                        Row(
                                                          children: [
                                                            Container(
                                                              //color: Colors.grey,
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left: width *
                                                                    0.025,
                                                                right: width *
                                                                    0.01,
                                                              ),

                                                              child:
                                                                  Image.asset(
                                                                'assets/images/side_menu/emergency_mgmt/safetyagency_telephone_icon.png',
                                                                width: width *
                                                                    0.035,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                // color:
                                                                //     Colors.brown,
                                                                child: Tooltip(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  preferBelow:
                                                                      false,
                                                                  textStyle:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'OpunMai',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        height *
                                                                            0.015,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            14,
                                                                            46,
                                                                            67),
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade100,
                                                                    borderRadius:
                                                                        BorderRadius.circular(width *
                                                                            0.025),
                                                                  ),
                                                                  message: widget
                                                                      .agencyTelephone,
                                                                  child: Text(
                                                                    widget
                                                                        .agencyTelephone,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'OpunMai',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          height *
                                                                              0.01,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          14,
                                                                          46,
                                                                          67),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        //AGENCY EMAIL
                                                        Row(
                                                          children: [
                                                            Container(
                                                              //color: Colors.grey,
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left: width *
                                                                    0.025,
                                                                right: width *
                                                                    0.01,
                                                              ),

                                                              child:
                                                                  Image.asset(
                                                                'assets/images/side_menu/emergency_mgmt/safetyagency_email_icon.png',
                                                                width: width *
                                                                    0.035,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                // color:
                                                                //     Colors.brown,
                                                                child: Tooltip(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  preferBelow:
                                                                      false,
                                                                  textStyle:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'OpunMai',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        height *
                                                                            0.015,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            14,
                                                                            46,
                                                                            67),
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade100,
                                                                    borderRadius:
                                                                        BorderRadius.circular(width *
                                                                            0.025),
                                                                  ),
                                                                  message: widget
                                                                      .agencyEmail,
                                                                  child: Text(
                                                                    widget
                                                                        .agencyEmail,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'OpunMai',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          height *
                                                                              0.01,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          14,
                                                                          46,
                                                                          67),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        //AGENCY FACEBOOK
                                                        Row(
                                                          children: [
                                                            Container(
                                                              //color: Colors.grey,
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left: width *
                                                                    0.025,
                                                                right: width *
                                                                    0.01,
                                                              ),

                                                              child:
                                                                  Image.asset(
                                                                'assets/images/side_menu/emergency_mgmt/safetyagency_fb_icon.png',
                                                                width: width *
                                                                    0.035,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                // color:
                                                                //     Colors.brown,
                                                                child: Tooltip(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  preferBelow:
                                                                      false,
                                                                  textStyle:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'OpunMai',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        height *
                                                                            0.015,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            14,
                                                                            46,
                                                                            67),
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade100,
                                                                    borderRadius:
                                                                        BorderRadius.circular(width *
                                                                            0.025),
                                                                  ),
                                                                  message: widget
                                                                      .agencyFB,
                                                                  child: Text(
                                                                    widget
                                                                        .agencyFB,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'OpunMai',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          height *
                                                                              0.01,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          14,
                                                                          46,
                                                                          67),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        //AGENCY WEBSITE
                                                        Row(
                                                          children: [
                                                            Container(
                                                              //color: Colors.grey,
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left: width *
                                                                    0.025,
                                                                right: width *
                                                                    0.01,
                                                              ),

                                                              child:
                                                                  Image.asset(
                                                                'assets/images/side_menu/emergency_mgmt/safetyagency_web_icon.png',
                                                                width: width *
                                                                    0.035,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                // color:
                                                                //     Colors.brown,
                                                                child: Tooltip(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  preferBelow:
                                                                      false,
                                                                  textStyle:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'OpunMai',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        height *
                                                                            0.015,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            14,
                                                                            46,
                                                                            67),
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade100,
                                                                    borderRadius:
                                                                        BorderRadius.circular(width *
                                                                            0.025),
                                                                  ),
                                                                  message: widget
                                                                      .agencyWebsite,
                                                                  child: Text(
                                                                    widget
                                                                        .agencyWebsite,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'OpunMai',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          height *
                                                                              0.01,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          14,
                                                                          46,
                                                                          67),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //SELECTED TOP CONTAINER
                                            Positioned(
                                              top: 0,
                                              right: width * 0.12,
                                              child: Container(
                                                height: height * 0.02,
                                                width: width * 0.2,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          width * 0.01),
                                                  border: Border.all(
                                                    color: Color.fromARGB(
                                                        255, 217, 217, 217),
                                                    width: 1.5,
                                                  ),
                                                ),
                                                child: Text(
                                                  widget.isContactTapped
                                                      ? 'selected'
                                                      : 'unselected',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontFamily: 'OpunMai',
                                                    fontSize: height * 0.013,
                                                    fontWeight: FontWeight.w700,
                                                    color: widget
                                                            .isContactTapped
                                                        ? Color.fromARGB(
                                                            255, 142, 230, 0)
                                                        : Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (_showMagnifier) ...[
                                              Positioned(
                                                left: dragGesturePosition.dx -
                                                    (width * 0.5) / 2,
                                                top: dragGesturePosition.dy -
                                                    (width * 0.5) * 1.15,
                                                child: RawMagnifier(
                                                  focalPointOffset: Offset.zero,
                                                  magnificationScale: 2,
                                                  size: Size(width * 0.5,
                                                      height * 0.5),
                                                  decoration:
                                                      MagnifierDecoration(
                                                    shape: CircleBorder(
                                                      side: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 14, 46, 67),
                                                        width: 1.5,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ],
                                        );
                        }),
                        options: CarouselOptions(
                            initialPage: 0,
                            enableInfiniteScroll: false,
                            pauseAutoPlayOnManualNavigate: true,
                            scrollPhysics: NeverScrollableScrollPhysics(),
                            viewportFraction: 1,
                            onPageChanged: (index, reason) {
                              setState(() {
                                if (widget.agencyContactsList.isNotEmpty) {
                                  widget.onPageChanged(index);
                                  _currentContactIndex = index;
                                }
                              });
                            }),
                      ),
                    ),
                  ),
                  //NEXT BUTTON
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (widget.agencyContactsList.isNotEmpty &&
                              _currentContactIndex !=
                                  widget.agencyContactsList.length - 1 &&
                              widget.agencyContactsList.isNotEmpty &&
                              !widget.isAddContactPressed &&
                              !widget.isEditContactPressed) {
                            widget.agencyContactController.nextPage();
                            //widget.onAgencySelected(false);
                          } else {}
                        });
                      },
                      overlayColor:
                          MaterialStatePropertyAll(Colors.transparent),
                      child: Text(
                        String.fromCharCode(Icons.chevron_right.codePoint),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: Icons.chevron_right.fontFamily,
                          fontSize: height * 0.05,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          package: Icons.chevron_right.fontPackage,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
