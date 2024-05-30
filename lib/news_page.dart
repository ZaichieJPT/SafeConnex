// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:settings_side_menu/components/home_components/home_bottom_nav_bar.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 244, 244, 244),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //APP BAR
              Container(
                color: Color.fromARGB(255, 244, 244, 244),
                height: height * 0.1,
                child: FractionallySizedBox(
                  widthFactor: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //FILTER BUTTON
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          highlightColor: Colors.grey,
                          borderRadius: BorderRadius.circular(250),
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.grey, width: 1.5),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 0.6,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: FractionallySizedBox(
                              //widthFactor: 0.7,
                              heightFactor: 0.5,
                              child: Image.asset(
                                'assets/images/feed_filter_icon.png',
                                scale: 7,
                              ),
                            ),
                          ),
                        ),
                      ),
                      //SEARCH BAR
                      Expanded(
                        flex: 6,
                        child: FractionallySizedBox(
                          heightFactor: 0.5,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 0.5,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: TextField(
                              cursorColor: Colors.grey,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                                letterSpacing: 0.7,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 0,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    'assets/images/feed_search_icon.png',
                                    scale: 8,
                                  ),
                                ),
                                hintText: "Search Office",
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "OpunMai",
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(22),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 1.5,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(22),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: FractionallySizedBox(
                          widthFactor: 0.1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //SCROLLABLE BODY
              Expanded(
                child: Scrollbar(
                  radius: Radius.circular(10),
                  thickness: width * 0.02,
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(width * 0.05),
                        height: height * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10.0),
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
    );
  }
}
