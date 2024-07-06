// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_circle_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_news_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_storage.dart';
import 'package:safeconnex/front_end_code/components/agency_components/agency_deletepost_dialog.dart';
import 'package:safeconnex/front_end_code/components/agency_components/agency_feed_editpost.dart';

class AgencyFeedPost extends StatefulWidget {
  final Function onEditPostSelected;
  const AgencyFeedPost({
    super.key,
    required this.onEditPostSelected,
  });

  @override
  State<AgencyFeedPost> createState() => _AgencyFeedPostState();
}

class _AgencyFeedPostState extends State<AgencyFeedPost> {
  final _postScrollController = ScrollController();
  List<bool> _isMoreClicked = [];
  List<bool> _isDeletePostConfirmed = [];
  List<bool> _isLikePostTapped = [];
  int _currentPostIndex = -1;
  bool _showPostFilter = false;

  //SafeConnexNewsDatabase newsDatabase = SafeConnexNewsDatabase();

  Future deletePostDialog() => showDialog(
        context: context,
        builder: (BuildContext context) {
          return AgencyDeletePost(
            onDeleteTapped: _onDeleteConfirmed,
            postIndex: _currentPostIndex,
          );
        },
      );
  _onDeleteConfirmed(bool isConfirmed, int postIndex) {
    setState(() {
      _isDeletePostConfirmed[postIndex] = isConfirmed;
      print('Post $_currentPostIndex has been deleted');
    });
  }

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
      });
    }
    DependencyInjector().locator<SafeConnexNewsDatabase>().listenOnTheNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    final _dateRangeFilterStart = _dateRangeFilter.start;
    final _dateRangeFilterEnd = _dateRangeFilter.end;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 66, 79, 88),
        title: Row(
          children: [
            Image.asset(
              'assets/images/splash-logo.png',
              width: width * 0.13,
            ),
            Text(
              'Your posts',
              style: TextStyle(
                fontFamily: 'OpunMai',
                fontSize: height * 0.025,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.035,
                vertical: height * 0.01,
              ),
              //FILTER BUTTON && GO TO TOP BUTTON
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //FILTER BUTTON
                  InkWell(
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
                  //GO TO TOP BUTTON
                  InkWell(
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
                      width: width * 0.07,
                      height: width * 0.07,
                      padding: EdgeInsets.only(top: height * 0.001),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade600,
                        borderRadius: BorderRadius.circular(width * 0.008),
                      ),
                      child: Icon(
                        Icons.change_history_outlined,
                        color: Colors.white,
                        size: width * 0.05,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                    itemCount: DependencyInjector().locator<SafeConnexNewsDatabase>().newsData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.075,
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
                                      topRight: Radius.circular(width * 0.05),
                                      topLeft: Radius.circular(width * 0.05),
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
                                      color:
                                          const Color.fromARGB(255, 14, 46, 67),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(width * 0.05),
                                        topLeft: Radius.circular(width * 0.05),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          flex: 4,
                                          child: Container()
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
                                                  DependencyInjector().locator<SafeConnexNewsDatabase>().newsData[index]["sender"],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontFamily: 'Monserrat',
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),

                                              //AGENCY STAFF ROLE
                                              Container(
                                                width: width,
                                                //color: Colors.cyan,
                                                child: Text(
                                                  DependencyInjector().locator<SafeConnexNewsDatabase>().newsData[index]["role"],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
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
                                            child: PopupMenuButton<String>(
                                              icon: !_isMoreClicked[index]
                                                  ? Image.asset(
                                                      'assets/images/agency_app/agency_role_icon.png',
                                                      color:
                                                          Colors.grey.shade600,
                                                    )
                                                  : Text(
                                                      String.fromCharCode(Icons
                                                          .more_vert.codePoint),
                                                      style: TextStyle(
                                                        fontFamily: Icons
                                                            .more_vert
                                                            .fontFamily,
                                                        fontSize: width * 0.065,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: Colors
                                                            .grey.shade600,
                                                      ),
                                                    ),
                                              onSelected: (value) {
                                                setState(() {
                                                  _isMoreClicked[index] =
                                                      !_isMoreClicked[index];
                                                  _currentPostIndex = index;
                                                });
                                                if (value == "Edit post") {
                                                  widget.onEditPostSelected(
                                                    true,
                                                    'Post Title $index',
                                                    'Post Desc $index',
                                                  );
                                                }
                                              },
                                              onCanceled: () {
                                                setState(() {
                                                  _isMoreClicked[index] =
                                                      !_isMoreClicked[index];
                                                });
                                              },
                                              onOpened: () {
                                                setState(() {
                                                  _isMoreClicked[index] =
                                                      !_isMoreClicked[index];
                                                });
                                              },
                                              position: PopupMenuPosition.under,
                                              color: Colors.white,
                                              surfaceTintColor:
                                                  Colors.transparent,
                                              padding: EdgeInsets.zero,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        width * 0.03),
                                              ),
                                              itemBuilder: (context) => [
                                                PopupMenuItem<String>(
                                                  height: height * 0.03,
                                                  value: "Edit post",
                                                  child: Text(
                                                    "Edit post",
                                                    style: TextStyle(
                                                      fontFamily: 'OpunMai',
                                                      fontSize: height * 0.015,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Color.fromARGB(
                                                          255, 14, 46, 67),
                                                    ),
                                                  ),
                                                ),
                                                PopupMenuItem<String>(
                                                  height: height * 0.03,
                                                  value: "Delete post",
                                                  onTap: () async {
                                                    await deletePostDialog();
                                                    print('DONE');
                                                  },
                                                  child: Text(
                                                    "Delete post",
                                                    style: TextStyle(
                                                      fontFamily: 'OpunMai',
                                                      fontSize: height * 0.015,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.red,
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
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width * 0.06),
                                  child: CircleAvatar(
                                    radius: width * 0.08,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: width * 0.073,
                                      backgroundColor: Colors.amber.shade200,
                                      child: SafeConnexProfileStorage.imageUrl != null ? Image.network(SafeConnexProfileStorage.imageUrl!) : Container(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            //POST TITLE AND CAPTION CONTAINER
                            Container(
                              width: width * 0.85,
                              //color: const Color.fromARGB(255, 217, 217, 217),
                              color: const Color.fromARGB(255, 217, 217, 217),
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.05,
                                  vertical: height * 0.01),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //POST TITLE
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      DependencyInjector().locator<SafeConnexNewsDatabase>().newsData[index]["title"],
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: 'OpunMai',
                                        fontSize: height * 0.017,
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromARGB(255, 14, 46, 67),
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
                                      DependencyInjector().locator<SafeConnexNewsDatabase>().newsData[index]["body"],                                     textAlign: TextAlign.left,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        fontFamily: 'OpunMai',
                                        fontSize: height * 0.015,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromARGB(255, 14, 46, 67),
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
                              color: const Color.fromARGB(255, 217, 217, 217),
                              child: DependencyInjector().locator<SafeConnexNewsStorage>().imageUrl != null ? Image.network(
                                DependencyInjector().locator<SafeConnexNewsStorage>().imageUrl!,
                                fit: BoxFit.contain,
                              ) : Container(),
                            ),
                            //POST FOOTER
                            Container(
                              height: height * 0.05,
                              width: width * 0.85,
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.05,
                                  vertical: height * 0.01),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 217, 217, 217),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(width * 0.05),
                                  bottomLeft: Radius.circular(width * 0.05),
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
                                    DependencyInjector().locator<SafeConnexNewsDatabase>().newsData[index]["date"].toString().replaceAll(" ", "-"),
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontFamily: 'OpunMai',
                                      fontSize: height * 0.012,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 14, 46, 67),
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
                                          color:
                                              Color.fromARGB(255, 14, 46, 67),
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
                                                color: Colors.red.shade700,
                                              )
                                            : Icon(
                                                Icons.favorite_border_outlined,
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
      ),
    );
  }
}
