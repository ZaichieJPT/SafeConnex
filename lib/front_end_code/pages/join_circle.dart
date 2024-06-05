import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_auth.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_circle_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_users_database.dart';
import 'package:safeconnex/front_end_code/pages/join_circle_confirm.dart';

class JoinCirclePage extends StatefulWidget {
  const JoinCirclePage({super.key});

  @override
  State<JoinCirclePage> createState() => _JoinCirclePageState();
}

class _JoinCirclePageState extends State<JoinCirclePage> {
  final _joinCircleKey = GlobalKey<FormState>();
  final _joinCircleController = TextEditingController();
  UserDatabaseHandler userDatabase = UserDatabaseHandler();

  @override
  Widget build(BuildContext context) {
    CircleDatabaseHandler circleDatabase = CircleDatabaseHandler();
    FirebaseAuthHandler authHandler = FirebaseAuthHandler();
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            right: 19,
            bottom: 610,
            child: Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                color: Colors.yellow.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Positioned(
            left: 52,
            bottom: 800,
            child: Container(
              height: 38,
              width: 38,
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Positioned(
            bottom: 500,
            left: 30,
            child: Image.asset("assets/images/join_button.png", scale: 9.2,),
          ),
          Positioned(
              bottom: 415,
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
                          width: 1
                        )),
                    child: Icon(Icons.arrow_back_ios_sharp)
                ),
                onTap: (){
                  Navigator.pop(context);
                },
              )
          ),
          Positioned(
            bottom: 350,
            left: 60,
            child: Text(
              "Enter your circle code.",
              style: TextStyle(
                fontSize: 18,
                fontFamily: "OpunMai",
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 62, 73, 101),
              ),
            ),
          ),
          Positioned(
            bottom: 265,
            left: 80,
            child: Form(
              key: _joinCircleKey,
              child: Container(
                height: 65,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.brown.shade100,
                      offset: Offset(5, -1),
                      
                    )
                  ]
                ),
                child: TextFormField(
                  onTapOutside: (event){
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  controller: _joinCircleController,
                  validator: (value){
                    print(value);
                    if(value!.isEmpty){
                      return "Please enter a Circle Code";
                    }else if(value.length < 6 || value.length > 6){
                      return "Invalid Code";
                    }
                    else{
                      if(CircleDatabaseHandler.circleToJoin['circle_code'] == null || CircleDatabaseHandler.circleToJoin['circle_name'] == null){
                        return "Circle does not exist";
                      }else if(CircleDatabaseHandler.circleToJoin['id'] != null){
                        return "Already in the Circle";
                      }
                      return null;
                    }
                  } ,
                  textAlignVertical: TextAlignVertical.center,
                  cursorColor: Color.fromARGB(255, 175, 173, 173),
                  maxLength: 6,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "OpunMai",
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.amber.shade100,
                    //isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 21, horizontal: 10),
                    hintText: "Circle Code",
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 175, 173, 173),
                      fontSize: 16,
                      height: 0.5,
                    ),
                    helperText: "",
                    helperStyle: TextStyle(
                      fontSize: 15,
                      height: 0.05,
                    ),
                    errorStyle: TextStyle(
                      fontSize: 15,
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
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 180,
            left: 150,
            child: Container(
              height: 38,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(13)
              ),
              child: TextButton(
                onPressed: () {
                  circleDatabase.getCircleToJoin(_joinCircleController.text, authHandler.authHandler.currentUser!.uid);
                  circleDatabase.getCircleData(_joinCircleController.text);
                  Future.delayed(Duration(milliseconds: 1500), (){
                    if(_joinCircleKey.currentState!.validate()) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmJoinCircle()));
                    }
                  });
                },
                child: Text(
                  "ENTER",
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: "OpunMai",
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 62, 73, 101),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
