import 'package:flutter/material.dart';
import 'package:safeconnex/front_end_code/components/home_components/emergency_mini_button.dart';
import 'package:safeconnex/front_end_code/components/home_components/home_app_bar.dart';
import 'package:safeconnex/front_end_code/provider/new_map_provider.dart';

class HomePage extends StatefulWidget {
  final double height;
  final double width;
  const HomePage({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _toggle = false;

  Alignment alignment1 = Alignment(0.0, 1.0);
  Alignment alignment2 = Alignment(0.0, 1.0);
  Alignment alignment3 = Alignment(0.0, 1.0);
  Alignment alignment4 = Alignment(0.0, 1.0);

  toggleButtons() {
    setState(() {
      _toggle = !_toggle;
      if (_toggle) {
        alignment1 = Alignment(-0.6, 0.8);
        alignment2 = Alignment(-0.27, -0.05);
        alignment3 = Alignment(0.27, -0.05);
        alignment4 = Alignment(0.6, 0.8);
      } else {
        alignment1 = Alignment(0.0, 1.0);
        alignment2 = Alignment(0.0, 1.0);
        alignment3 = Alignment(0.0, 1.0);
        alignment4 = Alignment(0.0, 1.0);
      }
      //print(_toggle);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //SCROLLABLE BODY
        NewMapProvider(),

        //APP BAR
        HomeAppBar(
          height: widget.height,
          scrollController: _scrollController,
        ),
        if (_toggle)
          Opacity(
            opacity: 0.4,
            child: ModalBarrier(
              dismissible: true,
              onDismiss: toggleButtons,
              color: Colors.black,
            ),
          ),

        //FAB SPEED DIAL
        Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: widget.height * 0.3,
                //color: Colors.white,
                child: Stack(
                  children: [
                    //FIRE BUTTON
                    EMGMiniButton(
                      toggle: _toggle,
                      alignment: alignment1,
                      color: Colors.red,
                      icon: Icons.local_fire_department,
                      iconColor: Colors.white,
                      tooltip: 'BFP',
                    ),
                    //HEALTH AND ACCIDENT BUTTON
                    EMGMiniButton(
                      toggle: _toggle,
                      alignment: alignment2,
                      color: Colors.green,
                      icon: Icons.medical_services,
                      iconColor: Colors.white,
                      tooltip: 'CDRRMO/PNP',
                    ),
                    //SAFETY BUTTON
                    EMGMiniButton(
                      toggle: _toggle,
                      alignment: alignment3,
                      color: Colors.blue,
                      icon: Icons.local_police,
                      iconColor: Colors.white,
                      tooltip: 'PNP',
                    ),
                    //NATURAL EMERGENCY BUTTON
                    EMGMiniButton(
                      toggle: _toggle,
                      alignment: alignment4,
                      color: Colors.orange,
                      icon: Icons.flood,
                      iconColor: Colors.white,
                      tooltip: 'CDRRMO',
                    ),
                    //EMERGENCY BUTTON
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: toggleButtons,
                        child: Image.asset(
                          'assets/images/home_emergency_btnIcon.png',
                          scale: 2.8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
