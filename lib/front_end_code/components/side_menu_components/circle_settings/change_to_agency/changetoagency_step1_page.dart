// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AgencyStep1 extends StatefulWidget {
  final Function() toNextStep;
  const AgencyStep1({
    super.key,
    required this.toNextStep,
  });

  @override
  State<AgencyStep1> createState() => _AgencyStep1State();
}

class _AgencyStep1State extends State<AgencyStep1> {
  int _currentAgencyIndex = 0;
  bool _isAgencySelected = false;
  String _selectedAgencyType = '';
  List<String> agencyTypes = [
    'Fire Incident Responder',
    'Crime Incident Responder',
    'Medical Emergency Responder',
    'Natural Disaster and Accidents',
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.02),
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: FittedBox(
                child: Text(
                  'What kind of agency do you\nbelong?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'OpunMai',
                    fontSize: width * 0.045,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: CarouselSlider.builder(
                itemCount: 4,
                itemBuilder: ((context, index, realIndex) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _isAgencySelected = !_isAgencySelected;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _currentAgencyIndex == index && _isAgencySelected
                            ? Color.fromARGB(255, 207, 207, 207)
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/change_to_agency/agency_${index}_icon.png',
                        width: width * 0.5,
                      ),
                    ),
                  );
                }),
                options: CarouselOptions(
                  height: height * 0.5,
                  scrollPhysics: _isAgencySelected
                      ? NeverScrollableScrollPhysics()
                      : ScrollPhysics(),
                  pageSnapping: true,
                  viewportFraction: _isAgencySelected ? 0.8 : 0.55,
                  enlargeCenterPage: true,
                  enlargeFactor: _isAgencySelected ? 0.1 : 0,
                  enableInfiniteScroll: true,
                  initialPage: 0,
                  enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentAgencyIndex = index;
                      //_isAgencySelected = false;
                    });
                  },
                ),
              ),
            ),
            //AGENCY NAME
            Flexible(
              child: Text(
                agencyTypes[_currentAgencyIndex],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'OpunMai',
                  fontSize: height * 0.017,
                  color: Colors.white,
                ),
              ),
            ),
            //CONFIRM BUTTON
            Flexible(
              flex: 1,
              child: Center(
                child: Container(
                  width: width * 0.6,
                  //color: Colors.grey,
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        _selectedAgencyType = agencyTypes[_currentAgencyIndex];
                        print(_selectedAgencyType);
                        widget.toNextStep();
                      });
                    },
                    elevation: 2,
                    height: height * 0.05,
                    color: const Color.fromARGB(255, 121, 192, 148),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(width * 0.2),
                    ),
                    child: Text(
                      'Confirm',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'OpunMai',
                        fontSize: height * 0.023,
                        fontWeight: FontWeight.w700,
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
    );
  }
}
