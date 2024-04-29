import 'package:flutter/material.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_circle_database.dart';

class CircleCreator{
  void createCircle(BuildContext context){
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
                child: Column(
                  children: [
                    TextFormField(
                      controller: textController,
                      decoration: InputDecoration(
                        labelText: 'Circle Name',
                        icon: Icon(Icons.groups),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: (){
                    CircleDatabaseHandler circleCreator = CircleDatabaseHandler();
                    circleCreator.createCircle("xsfes", "name", textController.text, "email", "phone");
                    Navigator.pop(context);
                    print("Data Added");
                  },
                  child: Text("Add Circle")
              )
            ],
          );
        }
    );
  }
}
