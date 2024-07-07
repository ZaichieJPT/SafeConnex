// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_camera/flutter_camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_agency_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_circle_database.dart';

class AgencyStep4 extends StatefulWidget {
  final Function() toNextStep;
  const AgencyStep4({
    super.key,
    required this.toNextStep,
  });

  @override
  State<AgencyStep4> createState() => _AgencyStep4State();
}

class _AgencyStep4State extends State<AgencyStep4> {

  /*Future<void> _onSelfieIDTapped() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    DependencyInjector().locator<SafeConnexAgencyDatabase>().selfieLink = image!.path;
    if (image == null) return;
  }*/

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //STEP SUB HEADING
          Container(
            height: height * 0.03,
            width: width,
            margin: EdgeInsets.only(bottom: height * 0.01),
            //color: Colors.white,
            child: Text(
              'Take a selfie',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'OpunMai',
                fontSize: width * 0.045,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          //UPLOAD IMAGES
          Flexible(
            flex: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //PICTURE VIEW AREA
                Flexible(
                  flex: 6,
                  child: Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: const [
                          Colors.white,
                          Colors.grey,
                        ],
                        radius: 1,
                      ),
                      border: Border.all(
                        color: Colors.blueAccent,
                        width: 5,
                      ),
                    ),
                  ),
                ),

                //CAPTURE && RETAKE BUTTONS
                Expanded(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //CAPTURE BUTTON
                        SizedBox(
                          width: width * 0.3,
                          child: MaterialButton(
                            onPressed: () {
                              setState(() {});
                            },
                            height: height * 0.025,
                            color: Colors.green.shade50,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(width * 0.25),
                            ),
                            child: FittedBox(
                              child: Text(
                                'CAPTURE',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'OpunMai',
                                  fontSize: height * 0.012,
                                  fontWeight: FontWeight.w700,
                                  color: const Color.fromARGB(255, 40, 72, 113),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //RETAKE BUTTON
                        SizedBox(
                          width: width * 0.3,
                          child: MaterialButton(
                            onPressed: () {
                              setState(() {});
                            },
                            height: height * 0.025,
                            color: Colors.green.shade50,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(width * 0.25),
                            ),
                            child: FittedBox(
                              child: Text(
                                'RETAKE',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'OpunMai',
                                  fontSize: height * 0.012,
                                  fontWeight: FontWeight.w700,
                                  color: const Color.fromARGB(255, 40, 72, 113),
                                ),
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

          //SUBMIT BUTTON
          Center(
            heightFactor: 1,
            child: SizedBox(
              width: width * 0.6,
              //color: Colors.grey,
              child: MaterialButton(
                onPressed: () {
                  setState(() {
                    widget.toNextStep();
                  });
                },
                padding: EdgeInsets.zero,
                elevation: 2,
                height: height * 0.05,
                color: const Color.fromARGB(255, 121, 192, 148),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(width * 0.2),
                ),
                child: Text(
                  'Submit',
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
          SizedBox(
            height: height * 0.008,
          ),
        ],
      ),
    );
  }
}
