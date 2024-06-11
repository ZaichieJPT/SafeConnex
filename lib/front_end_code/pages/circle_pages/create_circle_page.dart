import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_auth.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_circle_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_users_database.dart';
import 'package:safeconnex/controller/app_manager.dart';
import 'package:safeconnex/front_end_code/components/login_textformfield.dart';
import 'package:safeconnex/front_end_code/pages/circle_pages/circle_results_page.dart';

class CreateCirclePage extends StatefulWidget {
  const CreateCirclePage({super.key});

  @override
  State<CreateCirclePage> createState() => _CreateCirclePageState();
}

class _CreateCirclePageState extends State<CreateCirclePage> {
  Widget build(BuildContext context) {
    TextEditingController _circleNameController = TextEditingController();
    final _circleKey = GlobalKey<FormState>();
    AppManager appController = AppManager();

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
                    top: 237,
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
                 left: 60 ,
                 width: 270,
                 height: 60,
                 child: Form(
                   key: _circleKey,
                   child: TextFormField(
                     onTapOutside: (event){
                       FocusManager.instance.primaryFocus?.unfocus();
                     },
                     validator: (value){
                       print(value);
                       if(value!.isEmpty){
                         return "Please enter a Circle Name";
                       }
                       else{
                         return null;
                       }
                     },
                     controller: _circleNameController,
                     textAlignVertical: TextAlignVertical.center,
                     cursorColor: Color.fromARGB(255, 175, 173, 173),
                     maxLength: 55,
                     style: TextStyle(
                       fontSize: 12,
                       fontFamily: "OpunMai",
                     ),
                     decoration: InputDecoration(
                       //isDense: true,
                       contentPadding: EdgeInsets.symmetric(
                           vertical: 11, horizontal: 10),
                       fillColor: Colors.white,
                       filled: true,
                       hintText: "Circle Name",
                       hintStyle: TextStyle(
                         color: Color.fromARGB(255, 175, 173, 173),
                         fontSize: 12,
                         height: 0.5,
                       ),
                       helperText: "",
                       helperStyle: TextStyle(
                         fontSize: 11,
                         height: 0.05,
                       ),
                       errorStyle: TextStyle(
                         fontSize: 11,
                         height: 0.05,
                       ),
                       counterText: '',
                       //floatingLabelStyle: TextStyle(color: Colors.black),
                       errorBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(25),
                         borderSide: BorderSide(
                           color: Colors.red,
                           width: 1.5,
                         ),
                       ),
                       focusedErrorBorder: true
                           ? OutlineInputBorder(
                         borderRadius: BorderRadius.circular(25),
                         borderSide: BorderSide(
                           color: Colors.red,
                           width: 1.5,
                         ),
                       )
                           : null,
                       enabledBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(25),
                         borderSide: BorderSide(
                           color: Color.fromARGB(255, 175, 173, 173),
                           width: 0.0,
                         ),
                       ),
                       focusedBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(25),
                         borderSide: BorderSide(color: Colors.black),
                       ),
                     ),
                   ),
                 )
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
                        if(_circleKey.currentState!.validate()){
                          if(_circleNameController.text.length <= 25){
                            AppManager.circleDatabaseHandler.createCircleWithName(_circleNameController.text, context, CircleResultsPage());
                          }
                        }
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
