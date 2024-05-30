import 'package:settings_side_menu/components/home_components/circle_list_tile.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatefulWidget {
  final double height;
  final ScrollController scrollController;
  const HomeAppBar(
      {super.key, required this.height, required this.scrollController});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  final List _circleList = [
    'Circle Name Random Test Name',
    'Office',
    'CSITS',
    'Special Someones',
    'Family',
    'Capstone Group 3'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                //color: Colors.white,
                color: Colors.transparent,
                height: widget.height * 0.19,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //SETTINGS BUTTON
                            Flexible(
                              flex: 1,
                              child: FractionallySizedBox(
                                widthFactor: 0.9,
                                heightFactor: 0.9,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                    border: Border.all(
                                      width: 0.5,
                                      color: Colors.grey,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 0.5,
                                        offset: Offset(-3, 4),
                                      ),
                                    ],
                                  ),
                                  child: Builder(builder: (context) {
                                    return IconButton(
                                      onPressed: () =>
                                          Scaffold.of(context).openDrawer(),
                                      icon: Image.asset(
                                        'assets/images/home_settings_icon.png',
                                        scale: 3,
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                            //ADD CIRCLE BUTTON
                            //SizedBox(),
                            Flexible(
                              flex: 1,
                              child: InkWell(
                                highlightColor: Colors.grey,
                                borderRadius: BorderRadius.circular(250),
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.grey, width: 0.5),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 0.6,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: FractionallySizedBox(
                                    //widthFactor: 0.7,
                                    heightFactor: 0.7,
                                    child: Image.asset(
                                      'assets/images/home_add_icon.png',
                                      scale: 7,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //CIRCLE LIST EXPANSION TILE PLACEHOLDER
                            Expanded(
                              flex: 4,
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                      //SPACE BETWEEN ROWS
                      Flexible(
                        flex: 1,
                        child: FractionallySizedBox(
                          heightFactor: 1,
                          child: Container(
                              //color: Colors.red,
                              ),
                        ),
                      ),
                      //2ND ROW APP BAR
                      Flexible(
                        flex: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //ADD PLACES BUTTON
                            Flexible(
                              flex: 1,
                              child: FractionallySizedBox(
                                widthFactor: 0.9,
                                heightFactor: 0.9,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                    border: Border.all(
                                      width: 0.5,
                                      color: Colors.grey,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 0.5,
                                        offset: Offset(-3, 4),
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Image.asset(
                                      'assets/images/home_location_icon.png',
                                      scale: 3,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            //PLACEHOLDER
                            Expanded(
                              flex: 5,
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(),
                    ),
                    //CIRCLE LIST CONTAINER
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          border: Border.all(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 0.5,
                              offset: Offset(3, 7),
                            ),
                          ],
                        ),
                        //CIRCLE LIST DROPDOWN LIST
                        child: ExpansionTile(
                          iconColor: const Color.fromARGB(255, 62, 73, 101),
                          collapsedIconColor:
                              const Color.fromARGB(255, 62, 73, 101),
                          title: Text(
                            'Circle Nasasasdasasme',
                            textScaler: TextScaler.linear(0.9),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'OpunMai',
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: const Color.fromARGB(255, 62, 73, 101),
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          //OTHER CIRCLES OF THE USER
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Container(
                                constraints: BoxConstraints(
                                  maxHeight: widget.height * 0.2,
                                ),
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    return Scrollbar(
                                      thickness: 8,
                                      radius: Radius.circular(15),
                                      child: ListView.builder(
                                        controller: widget.scrollController,
                                        shrinkWrap: true,
                                        physics: const ClampingScrollPhysics(),
                                        itemCount: _circleList.length - 1,
                                        itemBuilder: (context, index) =>
                                            CircleListTile(
                                          title: _circleList[index + 1],
                                        ),
                                      ),
                                    );
                                  },
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
            ],
          ),
        ],
      ),
    );
  }
}