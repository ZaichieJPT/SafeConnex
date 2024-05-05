import 'package:flutter/material.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_circle_database.dart';

class CircleCreator{
  void createCircle(BuildContext context){
  final _circleKey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (context)
        {
          TextEditingController? textController = TextEditingController();
          return AlertDialog(
            scrollable: true,
            title: Text('Create Circle'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _circleKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: textController,
                      decoration: InputDecoration(
                        labelText: 'Circle Name',
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 1,
                          ),
                        ),
                        focusedErrorBorder: true
                            ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 1,
                          ),
                        )
                            : null,
                      ),
                      validator: (value) {
                        print(value);
                        if(value == null){
                          return "Please enter a Circle Name";
                        }
                        else{
                          return null;
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: (){
                    if(_circleKey.currentState!.validate()){
                      CircleDatabaseHandler circleCreator = CircleDatabaseHandler();
                      circleCreator.createCircle("xsfes", "name", textController.text, "email", "phone");
                      Navigator.pop(context);
                      print("Data Added");
                    }
                  },
                  child: Text("Add Circle")
              )
            ],
          );
        }
    );
  }
}
