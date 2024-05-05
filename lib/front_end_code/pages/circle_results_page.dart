import 'package:flutter/material.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_auth.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_circle_database.dart';

class CircleResultsPage extends StatefulWidget {
  const CircleResultsPage({super.key});

  @override
  State<CircleResultsPage> createState() => _CircleResultsPageState();
}

class _CircleResultsPageState extends State<CircleResultsPage> {
  @override
  Widget build(BuildContext context) {
    CircleDatabaseHandler circleDatabase = CircleDatabaseHandler();
    print(CircleDatabaseHandler.generatedCode);

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/circle_results_background.png")
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              top: 95,
              left: 80,
              child: Text(
                'Here we go.\nYour Circle code is displayed\nbelow',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: "OpunMai",
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 62, 73, 101),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              top: 200,
              left: 140,
              child: SelectableText(
                '${CircleDatabaseHandler.generatedCode}',
                style: TextStyle(
                  fontSize: 35,
                  fontFamily: "OpunMai",
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 62, 73, 101),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              top: 290,
              left: 75,
              child: Container(
                height: 50,
                width: 270,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(style: BorderStyle.solid, width: 1.5)
                ),
                child: ElevatedButton(
                  child: Text(
                    "CONTINUE",
                    style: TextStyle(
                      fontSize: 21,
                      fontFamily: "OpunMai",
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 62, 73, 101),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: (){
                    Navigator.of(context).popUntil((route) => route.settings.name == "/home");
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 65,
              left: 72,
              child: Image.asset("assets/images/create_button.png", scale: 9.5,)
            )
          ],
        ),
      ),
    );
  }
}
