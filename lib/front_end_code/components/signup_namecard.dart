// ignore_for_file: prefer_const_constructors
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
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              //color: Colors.amber,
              margin: EdgeInsets.only(top: 33),
              height: 280,
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 218, 237, 254),
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _nameCardFormKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            //BACK ICON BUTTON
                            ClipRRect(
                              borderRadius: BorderRadius.circular(300),
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
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'OpunMai',
                              ),
                            ),
                          ],
                        ),
                        //WHAT'S YOUR NAME
                        Container(
                          //color: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          width: double.infinity,
                          child: Text(
                            "What's your name?",
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: "OpunMai",
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 62, 73, 101),
                            ),
                          ),
                        ),
                        //FIRST NAME
                        SizedBox(
                          height: 15,
                        ),
                        SignupFormField(
                          hintText: "First Name",
                          controller: widget.firstNameController,
                          textMargin: 90,
                          validator: (lastName) {
                            if (lastName.toString().isEmpty) {
                              return "First name is required";
                            }
                            return null;
                          },
                          //autofocus: false,
                        ),

                        //LAST NAME
                        SizedBox(
                          height: 10,
                        ),

                        SignupFormField(
                          hintText: "Last Name",
                          controller: widget.lastNameController,
                          textMargin: 90,
                          validator: (lastName) {
                            if (lastName.toString().isEmpty) {
                              return "Last name is required";
                            }
                            return null;
                          },
                          //autofocus: false,
                        ),

                        //DATE OF BIRTH
                        SizedBox(
                          height: 15,
                        ),
                        SignupDateField(
                          hintText: "Date of Birth",
                          controller: widget.dateController,
                          textMargin: 90,
                          validator: (date) {
                            if (date.toString().isEmpty) {
                              return "Date of birth is required";
                            }
                            return null;
                          },
                          //autofocus: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              height: 85,
              width: 85,
              top: 25,
              right: 60,
              child: Image.asset(
                'assets/images/signup_page/signup_page_1.1.png',
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              height: 85,
              width: 85,
              top: 55,
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
          topMargin: 15.0,
          height: 40,
          leftMargin: 50,
          rightMargin: 50,
          fontSize: 12,
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
