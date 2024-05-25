import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class GeofencingPage extends StatefulWidget {
  const GeofencingPage({super.key});

  @override
  State<GeofencingPage> createState() => _GeofencingPageState();
}

class _GeofencingPageState extends State<GeofencingPage> {
  List<bool> isSelected = [
    true,
    false
  ];
  List<bool> isSelectedList = List.generate(2, (index) => false);
  int? tempIndex;
  int? indexedStackValue = 0;
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade500,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text("Place"),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 25
        ),
      ),
      bottomSheet: BottomAppBar(
        color: Colors.blueGrey.shade800,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              child: IconButton(
                onPressed: (){},
                color: Colors.white,
                icon: Icon(Icons.cancel_outlined),
                iconSize: 40,
              ),
            ),
            SizedBox(
              width: 80,
            ),
            Container(
              alignment: Alignment.center,
              height: 35,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.green.shade200,
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.shade400,
                    offset: Offset(0, 4)
                  )
                ],
                borderRadius: BorderRadius.circular(20)
              ),
              child: TextButton(
                onPressed: (){},
                child: Text(
                  indexedStackValue == 0 ? "Edit Location" : "Save Changes",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  )
                ),
              ),
            ),
            SizedBox(
              width: 60,
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            width: 320,
            height: 43,
            top:20,
            left: 50,
            child: ToggleButtons(
              children: [
                Container(child: Text("View Location", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,), width: 150, padding: EdgeInsets.all(10),),
                Container(child: Text("Add Location", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,), width: 150, padding: EdgeInsets.all(10),),
              ],
              borderRadius: BorderRadius.circular(40),
              borderColor: Colors.blueGrey.shade800,
              borderWidth: 1.5,
              color: Colors.blueGrey.shade800,
              selectedColor: Colors.white,
              fillColor: Colors.blueGrey.shade800,
              onPressed: (int index){
                setState(() {
                  if(index == 0){
                    isSelected[0] = true;
                    isSelected[1] = false;
                    indexedStackValue = 0;
                  }
                  else if(index == 1){
                    if(index == 1){
                      isSelected[1] = true;
                      isSelected[0] = false;
                      indexedStackValue = 1;
                    }
                  }
                });
              },
              isSelected: isSelected,
            ),
          ),

          IndexedStack(
            index: indexedStackValue,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 100,
                  bottom: 20,
                ),
                child: ListView(
                  children: [
                    ToggleButtons(
                      direction: Axis.vertical,
                      onPressed: (int index){
                        if(tempIndex == null){
                          setState(() {
                            isSelectedList[index] = !isSelectedList[index];
                          });
                        }else{
                          setState(() {
                            isSelectedList[tempIndex!] = false;
                            isSelectedList[index] = true;
                          });
                        }
                        tempIndex = index;
                      },
                      borderColor: Colors.white,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10, top: 10),
                          child: Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.brown.shade100,
                                    borderRadius: BorderRadius.circular(100)
                                ),
                                child: Icon(
                                  Icons.location_pin,
                                  size: 35,
                                  color: Colors.blueGrey.shade800,
                                ),
                              ),
                              SizedBox(width: 20,),
                              Text(
                                "At the beach",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.blueGrey.shade800,
                                    fontWeight: FontWeight.w400
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10, top: 10),
                          child: Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.brown.shade100,
                                    borderRadius: BorderRadius.circular(100)
                                ),
                                child: Icon(
                                  Icons.location_pin,
                                  size: 35,
                                  color: Colors.blueGrey.shade800,
                                ),
                              ),
                              SizedBox(width: 20,),
                              Text(
                                "Home",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.blueGrey.shade800,
                                    fontWeight: FontWeight.w400
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                      isSelected: isSelectedList,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 100,
                  bottom: 20,
                ),
                child: Column(
                  children: [
                    Divider(
                      thickness: 7,
                      color: Colors.brown.shade200,
                    ),
                    Container(
                      height: 175,
                    ),
                    Divider(
                      thickness: 5,
                      color: Colors.brown.shade200,
                    ),
                    Slider(
                      value: _currentSliderValue,
                      max: 100,
                      divisions: 5,
                      label: _currentSliderValue.round().toString(),
                      onChanged: (value){
                        setState(() {
                          _currentSliderValue = value;
                        });
                      },
                    ),
                    Container(
                      width: 1000,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.brown.shade100,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Location Details",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.brown.shade300
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 300,
                      child: Form(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: 450,
                              child: Text(
                                "Label",
                                style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.blueGrey.shade800,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            TextFormField(
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
                              decoration: InputDecoration(
                                icon: Icon(Icons.bookmark),
                                iconColor: Colors.blueGrey.shade200,
                                hintText: "Name",
                                hintStyle: TextStyle(
                                  color: Colors.blueGrey.shade200,
                                ),
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueGrey.shade800, width: 3))
                               )
                             ),
                            TextFormField(
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
                                decoration: InputDecoration(
                                  icon: Icon(Icons.house),
                                  iconColor: Colors.blueGrey.shade200,
                                  hintText: "Address",
                                  hintStyle: TextStyle(
                                    color: Colors.blueGrey.shade200,
                                  ),
                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueGrey.shade800, width: 3))
                                )
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
