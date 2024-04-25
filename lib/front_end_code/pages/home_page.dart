import 'package:flutter/material.dart';
import 'package:safeconnex/front_end_code/components/button_component.dart';
import 'package:safeconnex/front_end_code/provider/map_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 150,
        actions: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/images/add_circle.png', scale: 8),
                  SizedBox(width: 12),
                  ClipRect(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      widthFactor: 0.95,
                      child: Image.asset('assets/images/circle_name.png', scale: 7.8,),
                    )
                  )
                ]
              ),
              SizedBox(height: 65,)
            ],
          ),
        ],
        leadingWidth: 120,
        leading: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(width: 15),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonComponent(imageLocation: 'assets/images/settings_icon.png', scale: 9,),
                ButtonComponent(imageLocation: 'assets/images/geofencing_icon.png', scale: 9),
              ],
            ),
          ],
        ),
      ),
      body: Stack(
        alignment: Alignment(0, 0.86),
          children: [
            MapProvider(),
            ButtonComponent(imageLocation: 'assets/images/emergency_button.png', scale: 8,)
          ],
        ),
      extendBodyBehindAppBar: true,
      bottomSheet: BottomAppBar(
        height: 110,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ButtonComponent(imageLocation: 'assets/images/circle_icon.png', width: 125, margin: EdgeInsets.only(bottom: 10),),
            ButtonComponent(imageLocation: 'assets/images/home_icon.png', width: 125, margin: EdgeInsets.only(bottom: 10)),
            ButtonComponent(imageLocation: 'assets/images/feed_icon.png', width: 125, margin: EdgeInsets.only(bottom: 10)),
          ],
        ),
        color: Colors.white,
      ),
    );
  }
}


