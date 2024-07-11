// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safeconnex/front_end_code/components/agency_components/agency_feed_createpost.dart';
import 'package:safeconnex/front_end_code/components/agency_components/agency_feed_editpost.dart';
import 'package:safeconnex/front_end_code/components/agency_components/agency_feed_post.dart';
import 'package:safeconnex/front_end_code/components/agency_components/agency_feed_profile.dart';

class AgencyFeedPage extends StatefulWidget {
  final bool isSafetyScoreSelected;
  const AgencyFeedPage({
    super.key,
    required this.isSafetyScoreSelected,
  });

  @override
  State<AgencyFeedPage> createState() => _AgencyFeedPageState();
}

class _AgencyFeedPageState extends State<AgencyFeedPage> {
  int _currentFeedIndex = 0;
  double _detailsProgress = 0;
  bool _isEditDetailsSelected = false;
  bool _isEditProfileSelected = false;
  bool _isEditPostSelected = false;
  String _postTitle = '';
  String _postDescription = '';
  String _postSender = '';
  String _postImage = '';
  String _postRole = '';
  String _agencyName = '';

  final List<TextEditingController> _agencyDataControllers = [];
  final TextEditingController _agencyNameController = TextEditingController();
  final TextEditingController _agencyRoleController = TextEditingController();

  final GlobalKey<FormState> _agencyDataFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _agencyProfileFormKey = GlobalKey<FormState>();

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

  _onEditPostSelected(
      bool isSelected, String postTitle, String postDescription, String postSender) {
    setState(() {
      _isEditPostSelected = isSelected;
      if (_isEditPostSelected) {
        _postTitle = postTitle;
        _postDescription = postDescription;
        _postSender = postSender;
        _currentFeedIndex = -1;
      } else {
        _currentFeedIndex = 1;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i <= 6; i++) {
      _agencyDataControllers.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: _currentFeedIndex == 0
              ? AgencyFeedProfile()
              : _currentFeedIndex == 1
                  ? AgencyFeedPost(
                      onEditPostSelected: _onEditPostSelected,
                    )
                  : _currentFeedIndex == 2
                      ? AgencyCreatePost()
                      : _isEditPostSelected
                          ? AgencyEditPost(
                              postTitle: _postTitle,
                              postDescription: _postDescription,
                              postSender: _postSender,
                              postImage: _postImage,
                              postRole: _postRole,
                              agencyName: _agencyName,
                              onEditPostSelected: _onEditPostSelected,
                            )
                          : Container(),
        ),
        bottomNavigationBar: Container(
          height: height * 0.075,
          color: const Color.fromARGB(255, 75, 91, 106),
          child: Row(
            children: [
              //PROFILE TAB
              Expanded(
                child: InkWell(
                  onTap: () => _onTabTapped(0),
                  child: Container(
                    color: _currentFeedIndex == 0
                        ? Color.fromARGB(255, 66, 79, 88)
                        : Color.fromARGB(255, 75, 91, 106),
                    padding: EdgeInsets.symmetric(vertical: height * 0.012),
                    child: Image.asset(
                      'assets/images/agency_app/agency_profile_tab.png',
                    ),
                  ),
                ),
              ),
              //POSTS TAB
              Expanded(
                child: InkWell(
                  onTap: () => _onTabTapped(1),
                  child: Container(
                    color: _currentFeedIndex == 1
                        ? Color.fromARGB(255, 66, 79, 88)
                        : Color.fromARGB(255, 75, 91, 106),
                    padding: EdgeInsets.symmetric(vertical: height * 0.012),
                    child: Image.asset(
                      'assets/images/agency_app/agency_post_tab.png',
                    ),
                  ),
                ),
              ),
              //CREATE POST TAB
              Expanded(
                child: InkWell(
                  onTap: () => _onTabTapped(2),
                  child: Container(
                    color: _currentFeedIndex == 2
                        ? Color.fromARGB(255, 66, 79, 88)
                        : Color.fromARGB(255, 75, 91, 106),
                    padding: EdgeInsets.symmetric(vertical: height * 0.015),
                    child: Image.asset(
                      'assets/images/agency_app/agency_createpost_tab.png',
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
