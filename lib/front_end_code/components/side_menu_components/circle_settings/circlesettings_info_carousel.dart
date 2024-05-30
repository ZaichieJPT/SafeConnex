// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';

class InfoCarousel extends StatefulWidget {
  final double height;
  final double width;

  const InfoCarousel({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  State<InfoCarousel> createState() => _InfoCarouselState();
}

class _InfoCarouselState extends State<InfoCarousel> {
  int _currentCarouselIndex = 0;
  final List<Map<String, dynamic>> settingsInfo = [
    {
      'title': 'Circle Management',
      'content':
          'Changes you make here apply only to the current selected Circle.',
      'image':
          'assets/images/side_menu/circle_settings/circlesettings_management_icon.png',
    },
    {
      'title': 'Additional Circles',
      'content':
          'Create different Circles for groups of important people in your life.',
      'image':
          'assets/images/side_menu/circle_settings/circlesettings_additional_icon.png',
    },
    {
      'title': 'Location Sharing',
      'content':
          'This must be turned “on” so Circle members can see you on the map.',
      'image':
          'assets/images/side_menu/circle_settings/circlesettings_sharing_icon.png',
    },
    {
      'title': 'Device Permissions',
      'content':
          'Your device’s location is required to be “on” for the app to work.',
      'image':
          'assets/images/side_menu/circle_settings/circlesettings_permission_icon.png',
    },
  ];

  carouselIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < settingsInfo.length; i++)
          Container(
            height: widget.height * 0.02,
            width: widget.width * 0.03,
            margin: EdgeInsets.symmetric(
              horizontal: widget.width * 0.008,
            ),
            decoration: BoxDecoration(
              color: _currentCarouselIndex == i
                  ? Color.fromARGB(255, 70, 85, 104)
                  : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: Color.fromARGB(255, 70, 85, 104),
                width: 2,
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider.builder(
          itemCount: 4,
          itemBuilder: ((context, index, realIndex) {
            //MAIN CONTAINER WITH SHADOW
            return Padding(
              padding: EdgeInsets.fromLTRB(
                widget.width * 0.08,
                widget.height * 0.015,
                widget.width * 0.08,
                widget.height * 0.02,
              ),
              child: Container(
                //width: widget.width * 0.75,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 174, 174, 174)
                          .withOpacity(0.8),
                      spreadRadius: widget.width * 0.008,
                      blurRadius: widget.width * 0.04,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      //CAROUSEL IMAGE
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: widget.width * 0.04),
                        child: Image.asset(
                          settingsInfo[index]['image'],
                        ),
                      ),
                    ),
                    //CAROUSEL TITLE
                    Flexible(
                      flex: 7,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: widget.width * 0.02),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                right: widget.width * 0.015,
                              ),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                //color: Colors.red,
                                child: Text(
                                  settingsInfo[index]['title'],
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'OpunMai',
                                    fontWeight: FontWeight.w600,
                                    fontSize: widget.height * 0.0175,
                                    color: Color.fromARGB(255, 70, 85, 104),
                                  ),
                                ),
                              ),
                            ),
                            //SPACER
                            SizedBox(
                              height: widget.height * 0.008,
                            ),
                            //CAROUSEL CONTENT
                            Padding(
                              padding:
                                  EdgeInsets.only(right: widget.width * 0.015),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                //color: Colors.blue,
                                child: Text(
                                  settingsInfo[index]['content'],
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'OpunMai',
                                    fontWeight: FontWeight.w500,
                                    fontSize: widget.height * 0.0125,
                                    color: Color.fromARGB(255, 70, 85, 104),
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
              ),
            );
          }),
          options: CarouselOptions(
            height: widget.height * 0.16,
            pageSnapping: true,
            viewportFraction: 1,
            enableInfiniteScroll: true,
            initialPage: 0,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            onPageChanged: (index, reason) {
              setState(() {
                _currentCarouselIndex = index;
              });
            },
          ),
        ),
        carouselIndicator(),
      ],
    );
  }
}
