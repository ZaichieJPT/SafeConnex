
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:safeconnex/front_end_code/pages/agency_pages/agency%20_floodscore_page.dart';

class SafetyScorePopup extends StatefulWidget {
  const SafetyScorePopup({super.key, required this.width, required this.height, required this.locationName,
  required this.radiusSize, required this.longitude, required this.latitude, required this.riskInfo
 , required this.riskLevel, required this.safetyScoreId});

  final double width;
  final double height;
  final String locationName;
  final String riskLevel;
  final String riskInfo;
  final double radiusSize;
  final String safetyScoreId;
  final double latitude;
  final double longitude;
  @override
  State<SafetyScorePopup> createState() => _SafetyScorePopupState();
}

class _SafetyScorePopupState extends State<SafetyScorePopup> {

  Map<String, dynamic>? _currentPopupData = {
    "circleColor" : Colors.green,
    "title" : "Test",
    "description": "Another Test",
    "floodColor" : Colors.orange,
    "accidentColors": Colors.red
  };

  List<Map<String, dynamic>> safetyScoreMatrix = [{

  }];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("running");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showPopover(
            context: context,
            width: widget.width * 0.45,
            height: widget.height * 0.1,
            //arrowDyOffset is HEIGHT OF THE SAFETY SCORE CIRCLE DIVIDED BY 2 TO MAKE IT CENTERED
            arrowDyOffset: widget.height * 0.2 / 2,
            direction: PopoverDirection.top,
            barrierDismissible: true,
            backgroundColor: Colors.white,
            shadow: [
              BoxShadow(
                offset: Offset(0, 4),
                color: Colors.grey.shade500,
              ),
            ],
            bodyBuilder: ((context) => Padding(
              padding: EdgeInsets.symmetric(vertical: widget.height * 0.005),
              child: Column(
                children: [
                  //POPUP HEADER
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            //color: Colors.deepPurple[300],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: Text(
                              widget.locationName,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'OpunMai',
                                fontWeight: FontWeight.w700,
                                fontSize: 12.5,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        //EDIT BUTTON
                        Expanded(
                          child: InkWell(
                            //PASS DATA OF THIS SAFETY SCORE TO THE EDIT PAGE
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AgencyFloodScore(
                                        locationName: widget.locationName,
                                        radiusSize: widget.radiusSize,
                                        latitude: widget.latitude,
                                        longitude: widget.longitude,
                                        riskInfo: widget.riskInfo,
                                        riskLevel: widget.riskLevel,
                                        safetyScoreId: widget.safetyScoreId,
                                      ),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey.shade600,
                              radius: widget.width * 0.027,
                              child: Image.asset(
                                'assets/images/agency_app/agency_edit_button.png',
                                width: widget.width * 0.027,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //TEXT DESCRIPTION
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: widget.width * 0.01),
                      child: Text(
                        "${widget.riskInfo} area",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontFamily: 'OpunMai',
                          fontSize: 10,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  //RISK LEVEL
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: widget.width * 0.02),
                      child: Row(
                        children: [
                          //FLOOD LEVEL
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    width: widget.width * 0.08,
                                    height: widget.height * 0.022,
                                    decoration: BoxDecoration(
                                      color: _currentPopupData?[
                                      'floodColor'],
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(
                                          widget.width * 0.02),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: widget.width * 0.01,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'FLOOD',
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontFamily: 'OpunMai',
                                      fontWeight: FontWeight.w600,
                                      fontSize: widget.width * 0.023,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //ACCIDENT LEVEL
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    width: widget.width * 0.08,
                                    height: widget.height * 0.022,
                                    decoration: BoxDecoration(
                                      color: _currentPopupData?[
                                      'accidentColors'],
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(
                                          widget.width * 0.02),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: widget.width * 0.01,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'ACCIDENT',
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontFamily: 'OpunMai',
                                      fontWeight: FontWeight.w600,
                                      fontSize: widget.width * 0.022,
                                      color: Colors.black,
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
                ],
              ),
            )),
          );
        }
    );
  }
}
