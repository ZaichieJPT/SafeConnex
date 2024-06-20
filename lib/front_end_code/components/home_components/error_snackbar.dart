import 'package:flutter/material.dart';

void showErrorMessage(
    BuildContext context, String errorMessage, double height, double width) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: const Duration(seconds: 3),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: width * 0.05,
        right: width * 0.05,
      ),
      content: Container(
        width: width * 0.8,
        //height: height * 0.1,
        padding: EdgeInsets.symmetric(vertical: height * 0.01),
        decoration: BoxDecoration(
          color: Colors.red[400],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 174, 174, 174).withOpacity(0.8),
              spreadRadius: width * 0.005,
              blurRadius: width * 0.01,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 3,
              //ERROR ICON
              child: Container(
                alignment: Alignment.center,
                child: Icon(
                  Icons.error,
                  color: Colors.white,
                  size: height * 0.07,
                ),
              ),
            ),
            //ERROR TITLE
            Flexible(
              flex: 7,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: width * 0.015,
                      ),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        //color: Colors.blue,
                        child: Text(
                          'Oh, Snap!',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'OpunMai',
                            fontWeight: FontWeight.w700,
                            fontSize: height * 0.023,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    //SPACER

                    //ERROR MESSAGE
                    Padding(
                      padding: EdgeInsets.only(right: width * 0.015),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        //color: Colors.green,
                        child: Text(
                          errorMessage,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'OpunMai',
                            fontWeight: FontWeight.w400,
                            fontSize: height * 0.014,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              //EXIT ICON
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  //color: Colors.amber,
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: height * 0.025,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}