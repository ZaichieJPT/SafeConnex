import 'package:flutter/material.dart';

class ContactOptions extends StatefulWidget {
  final String sOSType;
  final Color sOSFontColor;
  final String? typeImage;
  final IconData? typeIcon;
  final Color? typeColor;
  final List<Color>? typeGradient;
  bool isCircleCheck;
  bool isAgencyCheck;
  final Function onCheck;

  ContactOptions({
    super.key,
    required this.sOSType,
    required this.sOSFontColor,
    this.typeIcon,
    this.typeColor,
    this.typeGradient,
    required this.isCircleCheck,
    required this.isAgencyCheck,
    this.typeImage,
    required this.onCheck,
  });

  @override
  State<ContactOptions> createState() => _ContactOptionsState();
}

class _ContactOptionsState extends State<ContactOptions> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    List<Color> gradient = widget.typeGradient == null
        ? [
            widget.typeColor!,
            widget.typeColor!,
          ]
        : widget.typeGradient!;

    widget.typeGradient ?? [widget.typeColor!, widget.typeColor!];
    String imageAssetLink = widget.typeImage == null ? '' : widget.typeImage!;

    return Column(
      children: [
        //TITLE
        Text(
          widget.sOSType,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'OpunMai',
            fontSize: height * 0.02,
            fontWeight: FontWeight.w800,
            color: widget.sOSFontColor,
          ),
        ),
        SizedBox(
          height: height * 0.005,
        ),
        //OPTIONS
        Container(
          height: height * 0.1,
          width: width * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(width * 0.025),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 205, 206, 204),
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              //SOS IMAGE
              Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05,
                    vertical: height * 0.015,
                  ),
                  child: Container(
                    width: width,
                    height: height,
                    padding: EdgeInsets.only(
                      left: width * 0.03,
                      right: width * 0.03,
                      bottom: widget.typeColor == null ? height * 0.006 : 0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.035),
                      gradient: RadialGradient(
                        colors: gradient,
                      ),
                    ),
                    child: imageAssetLink.length > 1
                        ? Image.asset(
                            imageAssetLink,
                          )
                        : FittedBox(
                            fit: BoxFit.contain,
                            child: Icon(
                              widget.typeIcon,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.025,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  //color: Colors.blue,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.00005),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //CIRCLE MEMBERS
                        Flexible(
                          child: Row(
                            children: [
                              //CHECK BOX
                              Flexible(
                                flex: 2,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      widget.isCircleCheck =
                                          !widget.isCircleCheck;
                                      widget.onCheck(widget.isCircleCheck,
                                          widget.isAgencyCheck);
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.02,
                                    ),
                                    child: AnimatedContainer(
                                      height: width * 0.06,
                                      width: width * 0.06,
                                      duration: Duration(milliseconds: 500),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(width * 0.02),
                                        border: Border.all(
                                          color:
                                              Color.fromARGB(255, 14, 46, 67),
                                          width: 2,
                                        ),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          String.fromCharCode(
                                              Icons.check.codePoint),
                                          style: TextStyle(
                                            inherit: false,
                                            color: widget.isCircleCheck == true
                                                ? Color.fromARGB(
                                                    255, 14, 46, 67)
                                                : Colors.transparent,
                                            fontSize: height * 0.02,
                                            fontWeight: FontWeight.w900,
                                            fontFamily: Icons.check.fontFamily,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              //DESCRIPTION
                              Expanded(
                                flex: 5,
                                child: Text(
                                  'Allow the Circle Members to be notified',
                                  style: TextStyle(
                                    fontFamily: 'OpunMai',
                                    fontWeight: FontWeight.w600,
                                    fontSize: height * 0.0115,
                                    height: 1.1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //AGENCY
                        Flexible(
                          child: Row(
                            children: [
                              //CHECK BOX
                              Flexible(
                                flex: 2,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      setState(() {
                                        widget.isAgencyCheck =
                                            !widget.isAgencyCheck;
                                        widget.onCheck(widget.isCircleCheck,
                                            widget.isAgencyCheck);
                                      });
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.02,
                                    ),
                                    child: AnimatedContainer(
                                      height: width * 0.06,
                                      width: width * 0.06,
                                      duration: Duration(milliseconds: 500),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(width * 0.02),
                                        border: Border.all(
                                          color:
                                              Color.fromARGB(255, 14, 46, 67),
                                          width: 2,
                                        ),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          String.fromCharCode(
                                              Icons.check.codePoint),
                                          style: TextStyle(
                                            inherit: false,
                                            color: widget.isAgencyCheck == true
                                                ? Color.fromARGB(
                                                    255, 14, 46, 67)
                                                : Colors.transparent,
                                            fontSize: height * 0.02,
                                            fontWeight: FontWeight.w900,
                                            fontFamily: Icons.check.fontFamily,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              //DESCRIPTION
                              Expanded(
                                flex: 5,
                                child: Text(
                                  'Allow the Safety Agencies to be notified',
                                  style: TextStyle(
                                    fontFamily: 'OpunMai',
                                    fontWeight: FontWeight.w600,
                                    fontSize: height * 0.0115,
                                    height: 1.1,
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
            ],
          ),
        ),
      ],
    );
  }
}
