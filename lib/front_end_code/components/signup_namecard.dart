// ignore_for_file: prefer_const_constructors
import "package:safeconnex/front_end_code/components/home_components/error_snackbar.dart";
import "package:safeconnex/front_end_code/components/signup_textformfield.dart";
import "package:safeconnex/front_end_code/components/signup_datefield.dart";
import "package:safeconnex/front_end_code/components/signup_continue_btn.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class NameCard extends StatefulWidget {
  const NameCard({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.dateController,
    required this.backClicked,
    required this.continueClicked,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController dateController;

  final Function() continueClicked;
  final Function() backClicked;

  @override
  State<NameCard> createState() => _NameCardState();
}

class _NameCardState extends State<NameCard> {
  final _nameCardFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              //color: Colors.amber,
              //margin: EdgeInsets.only(top: 10),
              //height: 280,
              height: height * 0.33,

              width: width,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 218, 237, 254),
                  borderRadius: BorderRadius.circular(width * 0.07),
                ),
                child: Padding(
                  padding: EdgeInsets.all(width * 0.02),
                  child: Form(
                    key: _nameCardFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              //BACK ICON BUTTON
                              ClipRRect(
                                borderRadius: BorderRadius.circular(width),
                                child: IconButton(
                                  icon: Icon(Icons.arrow_back_ios_new),
                                  color: Colors.black,
                                  style: IconButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    iconSize: 12,
                                    minimumSize: Size(10, 10),
                                  ),
                                  onPressed: widget.backClicked,
                                ),
                              ),
                              //TOP TEXT
                              Text(
                                "Let us know who you are.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: width * 0.035,
                                  fontFamily: 'OpunMai',
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 62, 73, 101),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //WHAT'S YOUR NAME
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: width * 0.05,
                              right: width * 0.33,
                            ),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: width,
                              //color: Colors.grey,
                              child: FittedBox(
                                child: Text(
                                  "What's your name?",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: height * 0.03,
                                    fontFamily: "OpunMai",
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 62, 73, 101),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //FIRST NAME
                        Flexible(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                child: SignupFormField(
                                  hintText: "First Name",
                                  controller: widget.firstNameController,
                                  textMargin: width * 0.23,
                                  validator: (lastName) {
                                    if (lastName.toString().isEmpty) {
                                      showErrorMessage(
                                          context,
                                          "First name is required",
                                          height,
                                          width);
                                      return '';
                                    }
                                    return null;
                                  },
                                  //autofocus: false,
                                ),
                              ),

                              //LAST NAME
                              Flexible(
                                child: SignupFormField(
                                  hintText: "Last Name",
                                  controller: widget.lastNameController,
                                  textMargin: width * 0.23,
                                  validator: (lastName) {
                                    if (lastName.toString().isEmpty) {
                                      showErrorMessage(
                                          context,
                                          "Last name is required",
                                          height,
                                          width);
                                      return '';
                                    }
                                    return null;
                                  },
                                  //autofocus: false,
                                ),
                              ),

                              //DATE OF BIRTH

                              Flexible(
                                child: SignupDateField(
                                  hintText: "Date of Birth",
                                  controller: widget.dateController,
                                  textMargin: width * 0.23,
                                  validator: (date) {
                                    if (date.toString().isEmpty) {
                                      showErrorMessage(
                                          context,
                                          "Date of birth is required",
                                          height,
                                          width);
                                      return '';
                                    }
                                    return null;
                                  },
                                  //autofocus: false,
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
            Positioned(
              height: width * 0.25,
              width: width * 0.2,
              top: -15,
              right: width * 0.17,
              child: Image.asset(
                'assets/images/signup_page/signup_page_1.1.png',
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              height: width * 0.25,
              width: width * 0.2,
              top: 15,
              right: 0,
              child: Image.asset(
                'assets/images/signup_page/signup_page_1.2.png',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
        //CONTINUE BUTTON
        BtnContinue(
          backgroundColor: Color.fromARGB(255, 238, 247, 254),
          borderColor: Color.fromARGB(255, 218, 237, 254),
          topMargin: height * 0.017,
          height: height * 0.05,
          leftMargin: width * 0.12,
          rightMargin: width * 0.12,
          fontSize: 13,
          btnName: "Continue",
          formKey: _nameCardFormKey,
          continueClicked: () {
            if (_nameCardFormKey.currentState!.validate()) {
              widget.continueClicked();
            } else {}
          },
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
        ),
      ],
    );
  }
}