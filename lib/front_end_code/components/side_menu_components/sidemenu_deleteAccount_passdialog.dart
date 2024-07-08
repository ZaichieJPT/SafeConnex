// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_authentication.dart';
import 'package:safeconnex/front_end_code/components/home_components/error_snackbar.dart';

class DeleteDialogPassField extends StatefulWidget {
  final double height;
  final double width;
  const DeleteDialogPassField({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  State<DeleteDialogPassField> createState() => _DeleteDialogPassFieldState();
}

class _DeleteDialogPassFieldState extends State<DeleteDialogPassField> {
  final TextEditingController _passController = TextEditingController();
  final _deleteAccountPassKey = GlobalKey<FormState>();
  bool _obscureText = false;
  double height = 0;
  double width = 0;
  //SafeConnexAuthentication authentication = SafeConnexAuthentication();

  _getVisibleButton() {
    return InkWell(
      onTap: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
      child: Icon(
        _obscureText ? Icons.visibility_off : Icons.visibility,
        color: Color.fromARGB(255, 143, 75, 112),
        size: height * 0.025,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    height = widget.height;
    width = widget.width;

    return Dialog(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: widget.height * 0.37,
        color: Colors.transparent,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: widget.height * 0.32,
              width: widget.width,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 241, 241, 241),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: widget.height * 0.045,
                  ),
                  //DIALOG TITLE
                  Flexible(
                    flex: 3,
                    child: FittedBox(
                      child: Text(
                        'ENTER YOUR PASSWORD\nTO CONTINUE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'OpunMai',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 238, 29, 35),
                        ),
                      ),
                    ),
                  ),
                  //DIALOG MESSAGE
                  Flexible(
                    flex: 5,
                    child: Form(
                      key: _deleteAccountPassKey,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          controller: _passController,
                          validator: (password) {
                            if (password.toString().isEmpty) {
                              showToast(
                                'Enter your password to continue',
                                textStyle: TextStyle(
                                  fontFamily: 'OpunMai',
                                  fontWeight: FontWeight.w600,
                                  fontSize: widget.height * 0.018,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                                context: context,
                                backgroundColor: Colors.red,
                                position: StyledToastPosition.center,
                                borderRadius: BorderRadius.circular(10),
                                duration: Duration(milliseconds: 4000),
                                animation: StyledToastAnimation.fade,
                                reverseAnimation: StyledToastAnimation.fade,
                                fullWidth: true,
                              );
                              return '';
                            }
                          },
                          cursorColor: Color.fromARGB(255, 143, 75, 112),
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              fontFamily: 'OpunMai',
                              fontSize: widget.width * 0.04,
                              fontWeight: FontWeight.w700,
                              color: Colors.red.shade300,
                            ),
                            suffixIconConstraints:
                                BoxConstraints(maxHeight: height * 0.025),
                            suffixIcon: _getVisibleButton(),
                            errorStyle: TextStyle(fontSize: 0),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 143, 75, 112),
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 143, 75, 112),
                              ),
                            ),
                          ),
                          style: TextStyle(
                            fontFamily: 'OpunMai',
                            fontSize: widget.width * 0.04,
                            fontWeight: FontWeight.w700,
                            color: Colors.red.shade300,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(),
                  Flexible(
                    flex: 3,
                    child: Row(
                      children: [
                        //CANCEL BUTTON CONTAINER
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 198, 164, 192),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                              ),
                              border: Border(
                                bottom: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 241, 241, 241),
                                ),
                                left: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 241, 241, 241),
                                ),
                                right: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 241, 241, 241),
                                ),
                              ),
                            ),
                            //CANCEL BUTTON
                            child: FittedBox(
                              child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(
                                  Icons.cancel,
                                  fill: 0,
                                  color: Color.fromARGB(255, 123, 123, 123),
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //DELETE BUTTON CONTAINER
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: widget.height * 0.1,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 143, 75, 112),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(25),
                              ),
                              border: Border(
                                bottom: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 241, 241, 241),
                                ),
                                right: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 241, 241, 241),
                                ),
                                left: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 241, 241, 241),
                                ),
                              ),
                            ),
                            //DELETE BUTTON
                            child: FractionallySizedBox(
                              widthFactor: 0.8,
                              heightFactor: 0.7,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_deleteAccountPassKey.currentState!
                                      .validate()) {
                                    showToast(
                                      'We are now deleting your account...',
                                      textStyle: TextStyle(
                                        fontFamily: 'OpunMai',
                                        fontWeight: FontWeight.w600,
                                        fontSize: widget.height * 0.018,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                      context: context,
                                      backgroundColor: Colors.red[400],
                                      position: StyledToastPosition.center,
                                      borderRadius: BorderRadius.circular(10),
                                      duration: Duration(milliseconds: 4000),
                                      animation: StyledToastAnimation.fade,
                                      reverseAnimation:
                                          StyledToastAnimation.fade,
                                      fullWidth: true,

                                    );
                                    // Delete Function
                                    DependencyInjector().locator<SafeConnexAuthentication>().deleteUserAccount("password");
                                    Navigator.of(context).pop();
                                  }
                                },
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 133, 67, 101),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 200, 100, 152),
                                  ),
                                  side: MaterialStateProperty.all<BorderSide>(
                                    BorderSide(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                child: FittedBox(
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(
                                      fontFamily: 'OpunMai',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
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
            //LOGOUT ICON
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CircleAvatar(
                radius: widget.height * 0.048,
                backgroundColor: Colors.white,
                child: Image.asset(
                  'assets/images/side_menu/sidemenu_delete_icon.png',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
