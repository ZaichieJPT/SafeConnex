// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AgencyCreatePost extends StatefulWidget {
  const AgencyCreatePost({super.key});

  @override
  State<AgencyCreatePost> createState() => _AgencyCreatePostState();
}

class _AgencyCreatePostState extends State<AgencyCreatePost> {
  final _postTitleController = TextEditingController();
  final _postDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 66, 79, 88),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/splash-logo.png',
                    width: width * 0.13,
                  ),
                  Text(
                    'Create post',
                    style: TextStyle(
                      fontFamily: 'OpunMai',
                      fontSize: height * 0.025,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: width * 0.02),
                child: InkWell(
                  onTap: () {},
                  child: Image.asset(
                    'assets/images/agency_app/agency_createpost_icon.png',
                    width: width * 0.09,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: height * 0.015),
          child: Container(
            height: height,
            width: width,
            child: Padding(
              padding: EdgeInsets.only(
                left: width * 0.09,
                right: width * 0.07,
              ),
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  height: height * 0.7,
                  //color: Colors.green,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //AGENCY CARD
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: CircleAvatar(
                                radius: width * 0.07,
                                backgroundColor: Colors.amber.shade200,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //AGENCY STAFF NAME
                                  Container(
                                    width: width,
                                    //color: Colors.grey,
                                    child: Text(
                                      'Garry Penoliar',
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: 'OpunMai',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromARGB(255, 14, 46, 67),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.003,
                                  ),

                                  //AGENCY STAFF ROLE
                                  Container(
                                    width: width,
                                    //color: Colors.green,
                                    child: Text(
                                      'Admin Staff at PNP',
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: 'OpunMai',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromARGB(255, 14, 46, 67),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      //POST TITLE
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: height * 0.02),
                        child: TextFormField(
                          controller: _postTitleController,
                          cursorColor: Color.fromARGB(255, 173, 162, 153),
                          decoration: InputDecoration(
                            isCollapsed: true,
                            isDense: true,
                            hintText: 'Post Title',
                            hintStyle: TextStyle(
                              fontFamily: 'OpunMai',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 173, 162, 153),
                            ),
                            errorStyle: TextStyle(fontSize: 0),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontFamily: 'OpunMai',
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 173, 162, 153),
                          ),
                        ),
                      ),

                      //POST DESCRIPTION
                      Expanded(
                        flex: 6,
                        child: Container(
                          height: height * 0.6,
                          width: width,
                          padding: EdgeInsets.only(left: 10),
                          //color: Colors.grey,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(255, 173, 162, 153),
                              width: 1,
                            ),
                          ),
                          child: TextFormField(
                            controller: _postDescriptionController,
                            expands: true,
                            maxLines: null,
                            cursorColor: Color.fromARGB(255, 173, 162, 153),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Write your post here...',
                              hintStyle: TextStyle(
                                fontFamily: 'OpunMai',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 173, 162, 153),
                              ),
                            ),
                            style: TextStyle(
                              fontFamily: 'OpunMai',
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 123, 123, 123),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      //UPLOAD FILE
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: Image.asset(
                                'assets/images/agency_app/agency_createpost_arrowup.png',
                                width: width * 0.09,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            Expanded(
                              child: MaterialButton(
                                onPressed: () {},
                                color: Color.fromARGB(255, 119, 194, 152),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(width * 0.03),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.05),
                                  child: Text(
                                    'UPLOAD FILE',
                                    style: TextStyle(
                                      fontFamily: 'OpunMai',
                                      fontSize: width * 0.04,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
