// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:safeconnex/front_end_code/components/agency_components/agency_home_appbar.dart';
import 'package:safeconnex/front_end_code/components/home_components/emergency_mini_button.dart';
import 'package:safeconnex/front_end_code/components/home_components/home_app_bar.dart';
import 'package:safeconnex/front_end_code/pages/agency_pages/agency%20_floodscore_page.dart';
import 'package:safeconnex/front_end_code/pages/forgot_pass_dialog.dart';
import 'package:safeconnex/front_end_code/provider/new_map_provider.dart';

class AgencyHomePage extends StatefulWidget {
  final Function onSafetyScoreSelected;
  const AgencyHomePage({
    super.key,
    required this.onSafetyScoreSelected,
  });

  @override
  State<AgencyHomePage> createState() => _AgencyHomePageState();
}

class _AgencyHomePageState extends State<AgencyHomePage> {
  String floodRisk = '1';
  String accidentRisk = '1';
  final Map<String, Map<String, dynamic>> _popupData = {
    //FLOOD LOW
    '11': {
      'title': 'CAUTION',
      'description': 'Safe area with minimal risks.',
      'floodColor': Colors.limeAccent.shade400,
      'accidentColors': Colors.limeAccent.shade400,
      'circleColor': Colors.limeAccent.shade400,
    },
    '12': {
      'title': 'CAUTION',
      'description': 'Generally safe but caution is advised',
      'floodColor': Colors.limeAccent.shade400,
      'accidentColors': Colors.orange.shade400,
      'circleColor': Colors.yellowAccent,
    },
    '13': {
      'title': 'WARNING',
      'description': 'Safe from floods but high accident risk.',
      'floodColor': Colors.limeAccent.shade400,
      'accidentColors': Colors.red.shade600,
      'circleColor': Colors.orange.shade500,
    },
    //FLOOD MID
    '21': {
      'title': 'CAUTION',
      'description': 'Flood risk present, but low accident risk.',
      'floodColor': Colors.orange.shade400,
      'accidentColors': Colors.limeAccent.shade400,
      'circleColor': Colors.yellowAccent,
    },
    '22': {
      'title': 'WARNING',
      'description': 'Moderate risk for both floods and accidents.',
      'floodColor': Colors.orange.shade400,
      'accidentColors': Colors.orange.shade400,
      'circleColor': Colors.orange.shade400,
    },
    '23': {
      'title': 'DANGER',
      'description': 'High accident risk with moderate flood risk.',
      'floodColor': Colors.orange.shade400,
      'accidentColors': Colors.red.shade600,
      'circleColor': Colors.red.shade600,
    },
    //FLOOD HIGH
    '31': {
      'title': 'WARNING',
      'description': 'High flood risk, but low accident risk.',
      'floodColor': Colors.red.shade600,
      'accidentColors': Colors.limeAccent.shade400,
      'circleColor': Colors.orange.shade400,
    },
    '32': {
      'title': 'DANGER',
      'description': 'High flood risk with moderate accident risk.',
      'floodColor': Colors.red.shade600,
      'accidentColors': Colors.orange.shade400,
      'circleColor': Colors.red.shade600,
    },
    '33': {
      'title': 'DANGER',
      'description': 'High risk area for both floods and accidents.',
      'floodColor': Colors.red.shade600,
      'accidentColors': Colors.red.shade600,
      'circleColor': Colors.red.shade600,
    },
  };

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    floodRisk = '1';
    accidentRisk = '3';

    final _currentPopupData = _popupData[floodRisk + accidentRisk];

    return Stack(
      children: [
        //SCROLLABLE BODY
        Container(
          color: Colors.blue[700],
          child: SingleChildScrollView(
            child: Center(
              child: Text(
                'Hello Word!' * 1000,
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'OpunMai',
                ),
              ),
            ),
          ),
        ),
        //NewMapProvider(),

        Center(
          child: Container(
            width: height * 0.2,
            height: height * 0.2,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPopupData?['circleColor'],
            ),
            child:
                //START OF THE POPUP CODE
                Builder(builder: (context) {
              return GestureDetector(
                onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ForgotPassDialog(height: height, width: width);
                  },
                  //showPopover(
                  //   context: context,
                  //   width: width * 0.45,
                  //   height: height * 0.1,
                  //   //arrowDyOffset is HEIGHT OF THE SAFETY SCORE CIRCLE DIVIDED BY 2 TO MAKE IT CENTERED
                  //   arrowDyOffset: height * 0.2 / 2,
                  //   direction: PopoverDirection.top,
                  //   barrierDismissible: true,
                  //   backgroundColor: Colors.white,
                  //   shadow: [
                  //     BoxShadow(
                  //       offset: Offset(0, 4),
                  //       color: Colors.grey.shade500,
                  //     ),
                  //   ],
                  //   bodyBuilder: ((context) => Padding(
                  //         padding: EdgeInsets.symmetric(vertical: height * 0.005),
                  //         child: Column(
                  //           children: [
                  //             //POPUP HEADER
                  //             Expanded(
                  //               child: Row(
                  //                 children: [
                  //                   Expanded(
                  //                     child: Container(
                  //                         //color: Colors.deepPurple[300],
                  //                         ),
                  //                   ),
                  //                   Expanded(
                  //                     flex: 3,
                  //                     child: Container(
                  //                       child: Text(
                  //                         _currentPopupData?['title'],
                  //                         textAlign: TextAlign.center,
                  //                         style: TextStyle(
                  //                           fontFamily: 'OpunMai',
                  //                           fontWeight: FontWeight.w700,
                  //                           fontSize: 12.5,
                  //                           color: Colors.red,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   //EDIT BUTTON
                  //                   Expanded(
                  //                     child: InkWell(
                  //                       //PASS DATA OF THIS SAFETY SCORE TO THE EDIT PAGE
                  //                       onTap: () {
                  //                         Navigator.of(context).push(
                  //                           MaterialPageRoute(
                  //                             builder: (context) =>
                  //                                 AgencyFloodScore(),
                  //                           ),
                  //                         );
                  //                       },
                  //                       child: CircleAvatar(
                  //                         backgroundColor: Colors.grey.shade600,
                  //                         radius: width * 0.027,
                  //                         child: Image.asset(
                  //                           'assets/images/agency_app/agency_edit_button.png',
                  //                           width: width * 0.027,
                  //                           color: Colors.white,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //             //TEXT DESCRIPTION
                  //             Expanded(
                  //               child: Padding(
                  //                 padding: EdgeInsets.symmetric(
                  //                     horizontal: width * 0.01),
                  //                 child: Text(
                  //                   _currentPopupData?['description'],
                  //                   textAlign: TextAlign.center,
                  //                   overflow: TextOverflow.clip,
                  //                   style: TextStyle(
                  //                     fontFamily: 'OpunMai',
                  //                     fontSize: 10,
                  //                     color: Colors.black,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //             //RISK LEVEL
                  //             Expanded(
                  //               child: Padding(
                  //                 padding: EdgeInsets.symmetric(
                  //                     horizontal: width * 0.02),
                  //                 child: Row(
                  //                   children: [
                  //                     //FLOOD LEVEL
                  //                     Expanded(
                  //                       flex: 2,
                  //                       child: Row(
                  //                         children: [
                  //                           Expanded(
                  //                             child: Container(
                  //                               width: width * 0.08,
                  //                               height: height * 0.022,
                  //                               decoration: BoxDecoration(
                  //                                 color: _currentPopupData?[
                  //                                     'floodColor'],
                  //                                 border: Border.all(
                  //                                   color: Colors.black,
                  //                                 ),
                  //                                 borderRadius:
                  //                                     BorderRadius.circular(
                  //                                         width * 0.02),
                  //                               ),
                  //                             ),
                  //                           ),
                  //                           SizedBox(
                  //                             width: width * 0.01,
                  //                           ),
                  //                           Expanded(
                  //                             flex: 2,
                  //                             child: Text(
                  //                               'FLOOD',
                  //                               textAlign: TextAlign.left,
                  //                               overflow: TextOverflow.clip,
                  //                               style: TextStyle(
                  //                                 fontFamily: 'OpunMai',
                  //                                 fontWeight: FontWeight.w600,
                  //                                 fontSize: width * 0.023,
                  //                                 color: Colors.black,
                  //                               ),
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),

                  //                     //ACCIDENT LEVEL
                  //                     Expanded(
                  //                       flex: 2,
                  //                       child: Row(
                  //                         children: [
                  //                           Expanded(
                  //                             child: Container(
                  //                               width: width * 0.08,
                  //                               height: height * 0.022,
                  //                               decoration: BoxDecoration(
                  //                                 color: _currentPopupData?[
                  //                                     'accidentColors'],
                  //                                 border: Border.all(
                  //                                   color: Colors.black,
                  //                                 ),
                  //                                 borderRadius:
                  //                                     BorderRadius.circular(
                  //                                         width * 0.02),
                  //                               ),
                  //                             ),
                  //                           ),
                  //                           SizedBox(
                  //                             width: width * 0.01,
                  //                           ),
                  //                           Expanded(
                  //                             flex: 2,
                  //                             child: Text(
                  //                               'ACCIDENT',
                  //                               textAlign: TextAlign.center,
                  //                               overflow: TextOverflow.clip,
                  //                               style: TextStyle(
                  //                                 fontFamily: 'OpunMai',
                  //                                 fontWeight: FontWeight.w600,
                  //                                 fontSize: width * 0.022,
                  //                                 color: Colors.black,
                  //                               ),
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       )),
                ),
              );
              //END OF THE POPUP CODE
            }),
          ),
        ),

        //APP BAR
        AgencyAppBar(
          onSafetyScoreSelected: widget.onSafetyScoreSelected,
        ),
      ],
    );
  }
}
