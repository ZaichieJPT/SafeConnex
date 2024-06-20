// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safeconnex/front_end_code/components/home_components/home_bottom_nav_bar.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final _postScrollController = ScrollController();
  List<bool> _isMoreClicked = [];
  List<bool> _isDeletePostConfirmed = [];
  List<bool> _isLikePostTapped = [];
  int _currentPostIndex = -1;
  bool _showPostFilter = false;

  List<bool> _isContactComplete = [];

  DateTimeRange _dateRangeFilter = DateTimeRange(
    start: DateTime.now().toLocal(),
    end: DateTime.now().toLocal(),
  );

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (newDateRange == null) return;
    Navigator.pop(context);
    setState(() => _dateRangeFilter = newDateRange);
  }

  @override
  void initState() {
    for (int i = 0; i < 6; i++) {
      setState(() {
        _isMoreClicked.add(false);
        _isDeletePostConfirmed.add(false);
        _isLikePostTapped.add(false);
        _isContactComplete.add(false);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    final _dateRangeFilterStart = _dateRangeFilter.start;
    final _dateRangeFilterEnd = _dateRangeFilter.end;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 244, 244, 244),
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          toolbarHeight: height * 0.1,
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 244, 244, 244),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //FILTER BUTTON
              Flexible(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    print(
                      'Start: ${_dateRangeFilterStart.month}/${_dateRangeFilterStart.day}/${_dateRangeFilterStart.year}'
                          .toString(),
                    );
                    //BOTTOM SHEET DATE FILTER
                    showModalBottomSheet(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: height * 0.25,
                          width: width,
                          child: Column(
                            children: [
                              //FILTER POSTS TITLE
                              Container(
                                height: height * 0.07,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: width * 0.04),
                                decoration: BoxDecoration(
                                  //color: Colors.grey,
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                child: FittedBox(
                                  child: Text(
                                    'Filter Posts',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromARGB(255, 14, 46, 67),
                                    ),
                                  ),
                                ),
                              ),
                              //DATE RANGE TEXT
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Select a Date Range',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 14, 46, 67),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    //START DATE
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.03,
                                          vertical: height * 0.035,
                                        ),
                                        child: InkWell(
                                          onTap: pickDateRange,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: height * 0.01),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 66, 79, 88),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  width * 0.025),
                                            ),
                                            child: Text(
                                              '${_dateRangeFilterStart.month}/${_dateRangeFilterStart.day}/${_dateRangeFilterStart.year}'
                                                  .toString(),
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    //END DATE
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.03,
                                          vertical: height * 0.035,
                                        ),
                                        child: InkWell(
                                          onTap: pickDateRange,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: height * 0.01),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 66, 79, 88),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  width * 0.025),
                                            ),
                                            child: Text(
                                              '${_dateRangeFilterEnd.month}/${_dateRangeFilterEnd.day}/${_dateRangeFilterEnd.year}'
                                                  .toString(),
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Container(
                    width: width * 0.12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey, width: 1.5),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 0.6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/feed_filter_icon.png',
                      scale: width * 0.018,
                    ),
                  ),
                ),
              ),

              //SEARCH BAR
              Expanded(
                flex: 5,
                child: Container(
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 0.5,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TextField(
                    cursorColor: Colors.grey,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      letterSpacing: 0.7,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 0,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/images/feed_search_icon.png',
                          scale: 8,
                        ),
                      ),
                      hintText: "Search Office",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "OpunMai",
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          height: height,
          width: width,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                children: [
                  Expanded(
                    child: Container(
                      height: height,
                      width: width,
                      //color: Colors.grey.shade200,
                      child: Scrollbar(
                        controller: _postScrollController,
                        radius: Radius.circular(width * 0.025),
                        thickness: width * 0.015,
                        child: ListView.builder(
                          controller: _postScrollController,
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.09,
                                vertical: height * 0.015,
                              ),
                              child: Column(
                                children: [
                                  //PROFILE AND NAME CONTAINER
                                  Stack(
                                    children: [
                                      //BACKGROUND CONTAINER
                                      Container(
                                        height: height * 0.08,
                                        width: width,
                                        decoration: BoxDecoration(
                                          //color: Colors.amber,
                                          borderRadius: BorderRadius.only(
                                            topRight:
                                            Radius.circular(width * 0.05),
                                            topLeft:
                                            Radius.circular(width * 0.05),
                                          ),
                                        ),
                                      ),
                                      //MAIN PROFILE CONTAINER
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          height: height * 0.06,
                                          width: width,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 14, 46, 67),
                                            borderRadius: BorderRadius.only(
                                              topRight:
                                              Radius.circular(width * 0.05),
                                              topLeft:
                                              Radius.circular(width * 0.05),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                flex: 4,
                                                child: Container(
                                                  //color: Colors.white,
                                                ),
                                              ),
                                              Flexible(
                                                flex: 7,
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    //AGENCY STAFF NAME
                                                    Container(
                                                      width: width,
                                                      //color: Colors.yellow,
                                                      child: Text(
                                                        'Garry Penoliar $index',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                        TextAlign.left,
                                                        style: TextStyle(
                                                          fontFamily:
                                                          'Monserrat',
                                                          fontSize: 13,
                                                          fontWeight:
                                                          FontWeight.w700,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),

                                                    //AGENCY STAFF ROLE
                                                    Container(
                                                      width: width,
                                                      //color: Colors.cyan,
                                                      child: Text(
                                                        'Admin Staff at PNP $index',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                        TextAlign.left,
                                                        style: TextStyle(
                                                          fontFamily:
                                                          'Montserrat',
                                                          fontSize: 10,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              //MODIFY POST BUTTON
                                              Flexible(
                                                flex: 2,
                                                child: Container(
                                                  height: height * 0.045,
                                                  width: width * 0.095,
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: width * 0.015,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade300,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        width * 0.03),
                                                  ),
                                                  child:
                                                  PopupMenuButton<String>(
                                                    icon: Image.asset(
                                                      'assets/images/agency_app/agency_role_icon.png',
                                                      color:
                                                      Colors.grey.shade600,
                                                    ),
                                                    onSelected: (value) {},
                                                    onCanceled: () {
                                                      setState(() {
                                                        _isMoreClicked[index] =
                                                        !_isMoreClicked[
                                                        index];
                                                      });
                                                    },
                                                    onOpened: () {
                                                      setState(() {
                                                        _isMoreClicked[index] =
                                                        !_isMoreClicked[
                                                        index];
                                                      });
                                                    },
                                                    position:
                                                    PopupMenuPosition.under,
                                                    color: Colors.white,
                                                    surfaceTintColor:
                                                    Colors.transparent,
                                                    padding: EdgeInsets.zero,
                                                    shape:
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                        width * 0.05,
                                                      ),
                                                    ),
                                                    itemBuilder: (context) => [
                                                      PopupMenuItem<String>(
                                                        enabled: false,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal:
                                                          width * 0.0105,
                                                          vertical:
                                                          height * 0.001,
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                          children: [
                                                            Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                  left: width *
                                                                      0.03),
                                                              child: Text(
                                                                "Philippine National Police",
                                                                textAlign:
                                                                TextAlign
                                                                    .left,
                                                                style:
                                                                TextStyle(
                                                                  fontFamily:
                                                                  'OpunMai',
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                                  fontSize:
                                                                  12.5,
                                                                  color: Color
                                                                      .fromARGB(
                                                                      255,
                                                                      14,
                                                                      46,
                                                                      67),
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
                                                                    right:
                                                                    width *
                                                                        0.01,
                                                                  ),

                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/side_menu/emergency_mgmt/safetyagency_location_icon.png',
                                                                    width: width *
                                                                        0.035,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                  Container(
                                                                    // color:
                                                                    //     Colors.brown,
                                                                    child:
                                                                    Tooltip(
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
                                                                        FontWeight.w600,
                                                                        fontSize:
                                                                        height *
                                                                            0.015,
                                                                        color: Color.fromARGB(
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
                                                                      message:
                                                                      'Perez Blvd., Dagupan City',
                                                                      child:
                                                                      Text(
                                                                        'Perez Blvd., Dagupan City',
                                                                        textAlign:
                                                                        TextAlign.left,
                                                                        overflow:
                                                                        TextOverflow.ellipsis,
                                                                        style:
                                                                        TextStyle(
                                                                          fontFamily:
                                                                          'OpunMai',
                                                                          fontWeight:
                                                                          FontWeight.w400,
                                                                          fontSize:
                                                                          11,
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
                                                                    right:
                                                                    width *
                                                                        0.01,
                                                                  ),

                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/side_menu/emergency_mgmt/safetyagency_mobile_icon.png',
                                                                    width: width *
                                                                        0.035,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                  Tooltip(
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
                                                                      color: Color.fromARGB(
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
                                                                    message:
                                                                    '09990989877',
                                                                    child:
                                                                    SelectableText(
                                                                      '02-9087-900',
                                                                      textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                      style:
                                                                      TextStyle(
                                                                        fontFamily:
                                                                        'OpunMai',
                                                                        fontWeight:
                                                                        FontWeight.w400,
                                                                        fontSize:
                                                                        11,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            14,
                                                                            46,
                                                                            67),
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
                                                                    right:
                                                                    width *
                                                                        0.01,
                                                                  ),

                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/side_menu/emergency_mgmt/safetyagency_telephone_icon.png',
                                                                    width: width *
                                                                        0.035,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                  Tooltip(
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
                                                                      color: Color.fromARGB(
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
                                                                    message:
                                                                    '02-9087-900',
                                                                    child:
                                                                    SelectableText(
                                                                      '02-9087-900',
                                                                      textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                      style:
                                                                      TextStyle(
                                                                        fontFamily:
                                                                        'OpunMai',
                                                                        fontWeight:
                                                                        FontWeight.w400,
                                                                        fontSize:
                                                                        11,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            14,
                                                                            46,
                                                                            67),
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
                                                                    right:
                                                                    width *
                                                                        0.01,
                                                                  ),

                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/side_menu/emergency_mgmt/safetyagency_email_icon.png',
                                                                    width: width *
                                                                        0.035,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                  Tooltip(
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
                                                                      color: Color.fromARGB(
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
                                                                    message:
                                                                    'pnp@gmail.com',
                                                                    child:
                                                                    SelectableText(
                                                                      'pnp@gmail.com',
                                                                      textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                      style:
                                                                      TextStyle(
                                                                        fontFamily:
                                                                        'OpunMai',
                                                                        fontWeight:
                                                                        FontWeight.w400,
                                                                        fontSize:
                                                                        11,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            14,
                                                                            46,
                                                                            67),
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
                                                                    right:
                                                                    width *
                                                                        0.01,
                                                                  ),

                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/side_menu/emergency_mgmt/safetyagency_fb_icon.png',
                                                                    width: width *
                                                                        0.035,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                  Tooltip(
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
                                                                      color: Color.fromARGB(
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
                                                                    message:
                                                                    'www.facebook.com/pnpdagupan',
                                                                    child:
                                                                    SelectableText(
                                                                      'www.facebook.com/pnpdagupan',
                                                                      textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                      style:
                                                                      TextStyle(
                                                                        fontFamily:
                                                                        'OpunMai',
                                                                        fontWeight:
                                                                        FontWeight.w400,
                                                                        fontSize:
                                                                        11,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            14,
                                                                            46,
                                                                            67),
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
                                                                    right:
                                                                    width *
                                                                        0.01,
                                                                  ),

                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/side_menu/emergency_mgmt/safetyagency_web_icon.png',
                                                                    width: width *
                                                                        0.035,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                  Tooltip(
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
                                                                      color: Color.fromARGB(
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
                                                                    message:
                                                                    'www.pnp.com',
                                                                    child:
                                                                    SelectableText(
                                                                      'www.pnp.com',
                                                                      textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                      style:
                                                                      TextStyle(
                                                                        fontFamily:
                                                                        'OpunMai',
                                                                        fontWeight:
                                                                        FontWeight.w400,
                                                                        fontSize:
                                                                        11,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            14,
                                                                            46,
                                                                            67),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            if (_isContactComplete[
                                                            index]) ...[
                                                              Container(
                                                                height: height *
                                                                    0.025,
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    width *
                                                                        0.02),
                                                                decoration:
                                                                BoxDecoration(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade300,
                                                                  borderRadius:
                                                                  BorderRadius.circular(
                                                                      width *
                                                                          0.01),
                                                                ),
                                                                child: Text(
                                                                  'More Contact Info Request',
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style:
                                                                  TextStyle(
                                                                    fontFamily:
                                                                    'OpunMai',
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                    fontSize:
                                                                    11,
                                                                    color: Color
                                                                        .fromARGB(
                                                                        255,
                                                                        14,
                                                                        46,
                                                                        67),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
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
                                      Padding(
                                        padding:
                                        EdgeInsets.only(left: width * 0.06),
                                        child: CircleAvatar(
                                          radius: width * 0.08,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: width * 0.073,
                                            backgroundColor:
                                            Colors.amber.shade200,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //POST TITLE AND CAPTION CONTAINER
                                  Container(
                                    width: width * 0.85,
                                    //color: const Color.fromARGB(255, 217, 217, 217),
                                    color: const Color.fromARGB(
                                        255, 217, 217, 217),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.05,
                                        vertical: height * 0.01),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        //POST TITLE
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "EARTHQUAKE INFORMATION $index",
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily: 'OpunMai',
                                              fontSize: height * 0.017,
                                              fontWeight: FontWeight.w700,
                                              color: Color.fromARGB(
                                                  255, 14, 46, 67),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        //POST DESCRIPTION
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Date/Time: 16 Jun 2024 - 07:48:52 PM\nLocation: 04.17°N, 125.51°E - 138 km S 4° E of Sarangani (Davao Occidental)\nDepth of Focus (Km):  010\nOrigin: TECTONIC\nMagnitude: Ms 5.1 Expecting\nDamage: NO\nExpecting Aftershocks: YES \nIndex $index",
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                              fontFamily: 'OpunMai',
                                              fontSize: height * 0.015,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromARGB(
                                                  255, 14, 46, 67),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  //POST IMAGE CONTAINER
                                  Container(
                                    width: width * 0.85,
                                    //color: const Color.fromARGB(255, 217, 217, 217),
                                    color: const Color.fromARGB(
                                        255, 217, 217, 217),
                                    child: Image.network(
                                      'https://scontent.fmnl4-6.fna.fbcdn.net/v/t39.30808-6/448546132_895295879303519_3604536046110788333_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeGOnnX1PwwgCxETN0JwpYWEtVrwXTLUNzm1WvBdMtQ3OQ3vbtXjTJw_wtkOkb6v0V_jMRhX5-t9uv_vCaTMhp5-&_nc_ohc=PFUZ2BzF1QYQ7kNvgGbLHaj&_nc_ht=scontent.fmnl4-6.fna&oh=00_AYD430cbJILM_yEPjM0BrwmKAQsL6UdElMkldxacF4qTFg&oe=66769FAA',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  //POST FOOTER
                                  Container(
                                    height: height * 0.05,
                                    width: width * 0.85,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.05,
                                        vertical: height * 0.01),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 217, 217, 217),
                                      borderRadius: BorderRadius.only(
                                        bottomRight:
                                        Radius.circular(width * 0.05),
                                        bottomLeft:
                                        Radius.circular(width * 0.05),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade400,
                                          offset: Offset(0, height * 0.0115),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        //POST TIME ELAPSED
                                        Text(
                                          '12 mins ago',
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontFamily: 'OpunMai',
                                            fontSize: height * 0.012,
                                            fontWeight: FontWeight.w400,
                                            color:
                                            Color.fromARGB(255, 14, 46, 67),
                                          ),
                                        ),
                                        //POST LIKES AND HEART BUTTON
                                        Row(
                                          children: [
                                            Text(
                                              '$index likes',
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                fontFamily: 'OpunMai',
                                                fontSize: height * 0.012,
                                                fontWeight: FontWeight.w400,
                                                color: Color.fromARGB(
                                                    255, 14, 46, 67),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _isLikePostTapped[index] =
                                                  !_isLikePostTapped[index];
                                                });
                                              },
                                              child: _isLikePostTapped[index]
                                                  ? Icon(
                                                Icons.favorite,
                                                color:
                                                Colors.red.shade700,
                                              )
                                                  : Icon(
                                                Icons
                                                    .favorite_border_outlined,
                                                color: Color.fromARGB(
                                                    255, 14, 46, 67),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //GO TO TOP BUTTON
              Padding(
                padding: EdgeInsets.only(right: width * 0.015),
                child: InkWell(
                  onTap: () {
                    _postScrollController.animateTo(
                      0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Container(
                    alignment: Alignment.topCenter,
                    width: width * 0.06,
                    height: width * 0.06,
                    padding: EdgeInsets.only(top: height * 0.001),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade600,
                      borderRadius: BorderRadius.circular(width * 0.008),
                    ),
                    child: Icon(
                      Icons.change_history_outlined,
                      color: Colors.white,
                      size: width * 0.045,
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