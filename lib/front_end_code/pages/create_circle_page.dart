import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_auth.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_circle_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_users_database.dart';
import 'package:safeconnex/front_end_code/components/login_textformfield.dart';
import 'package:safeconnex/front_end_code/pages/circle_results_page.dart';

class CreateCirclePage extends StatefulWidget {
  const CreateCirclePage({super.key});

  @override
  State<CreateCirclePage> createState() => _CreateCirclePageState();
}

class _CreateCirclePageState extends State<CreateCirclePage> {
  Widget build(BuildContext context) {
    TextEditingController _circleNameController = TextEditingController();

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/create_circle_background.png'),
        ),
      ),
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Positioned(
                    top: 115,
                    left: 40,
                    child: InkWell(
                      child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: Colors.black,
                              )),
                          child: Icon(Icons.arrow_back_ios_sharp)
                      ),
                      onTap: (){
                        Navigator.pop(context);
                      },
                    )
                ),
                Positioned(
                  top: 190,
                  left: 75,
                  child: Text(
                    'Enter your circle name.',
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: "OpunMai",
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 62, 73, 101),
                    ),
                  ),
                ),
                Positioned(
                    top: 240,
                    left: 65,
                    child: Container(
                      height: 50,
                      width: 270,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade400.withRed(210),
                          borderRadius: BorderRadius.circular(30)
                      ),
                    )
                ),
               Positioned(
                 top: 235,
                 left: 40,
                 width: 320,
                 height: 60,
                 child: LoginFormField(
                   hintText: "Circle Name",
                   controller: _circleNameController,
                   textMargin: 10,
                   verticalPadding: 0,
                   borderRadius: 30,
                  ),
                ),
                Positioned(
                    top: 320,
                    left: 145,
                    child: ElevatedButton(
                      child: Text(
                        "CREATE",
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: "OpunMai",
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 62, 73, 101),
                        ),
                      ),
                      onPressed: () {
                        FirebaseAuthHandler authHandler = FirebaseAuthHandler();
                        CircleDatabaseHandler circleDatabase = CircleDatabaseHandler();
                        UserDatabaseHandler userDatabase = UserDatabaseHandler();
                        userDatabase.getRegularUser(authHandler.authHandler.currentUser?.uid);
                        circleDatabase.createCircle(authHandler.authHandler.currentUser?.uid, authHandler.authHandler.currentUser?.displayName!, _circleNameController.text, authHandler.authHandler.currentUser?.email, "0");
                        userDatabase.addUserCircle(authHandler.authHandler.currentUser?.uid, CircleDatabaseHandler.generatedCode);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CircleResultsPage()));
                      },
                    )
                )
              ],
            ),
          ),
          Positioned(
            right: 20,
            bottom: 60,
            child: Image.asset("assets/images/create_button.png", scale: 9,),
          ),
        ]
      ),
    );
  }
}
