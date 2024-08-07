// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_news_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_storage.dart';

class AgencyEditPost extends StatefulWidget {
  final String postTitle;
  final String postDescription;
  final Function onEditPostSelected;
  final String postSender;
  final String postRole;
  final String postImage;
  final String agencyName;

  const AgencyEditPost({
    super.key,
    required this.postTitle,
    required this.postDescription,
    required this.onEditPostSelected,
    required this.postSender,
    required this.postRole,
    required this.postImage,
    required this.agencyName
  });

  @override
  State<AgencyEditPost> createState() => _AgencyEditPostState();
}

class _AgencyEditPostState extends State<AgencyEditPost> {
  final _postTitleController = TextEditingController();
  final _postDescriptionController = TextEditingController();

  @override
  void initState() {
    _postTitleController.text = widget.postTitle;
    _postDescriptionController.text = widget.postDescription;
    super.initState();
  }

  Future<void> _onFileUploadTapped() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    DependencyInjector().locator<SafeConnexNewsStorage>().uploadNewsPic(
        _postTitleController.text, image!.path);
    if (image == null) return;
  }

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
                    'Edit post',
                    style: TextStyle(
                      fontFamily: 'OpunMai',
                      fontSize: height * 0.025,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              //SAVE BUTTON
              Padding(
                padding: EdgeInsets.only(right: width * 0.02),
                child: InkWell(
                  onTap: () {
                    widget.onEditPostSelected(false, '', '',);
                    // Put something here

                  },
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
                                      widget.postSender,
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
                                      "${widget.postRole} at ${widget.agencyName}",
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
                                onPressed: () {
                                  _onFileUploadTapped();
                                },
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
