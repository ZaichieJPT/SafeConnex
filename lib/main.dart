import 'package:flutter/material.dart';
import 'package:safeconnex/front_end_code/components/carouse_slider.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/circle_settings/change_to_agency/sidemenu_changetoagency_dialog.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/sidemenu_feedback_dialog.dart';
import 'package:safeconnex/front_end_code/components/side_menu_components/sidemenu_profile_settings.dart';
import 'package:safeconnex/front_end_code/pages/circle_pages/circle_editname_page.dart';
import 'package:safeconnex/front_end_code/pages/circle_pages/circle_page.dart';
import 'package:safeconnex/front_end_code/pages/circle_pages/circle_results_page.dart';
import 'package:safeconnex/front_end_code/pages/circle_pages/circle_viewcode_page.dart';
import 'package:safeconnex/front_end_code/pages/email_verification_page.dart';
import 'package:safeconnex/front_end_code/pages/emergency_button_pages/emergency_countdown_template.dart';
import 'package:safeconnex/front_end_code/pages/emergency_button_pages/emergency_pinsetup_page.dart';
import 'package:safeconnex/front_end_code/pages/emergency_button_pages/emergency_sent_page.dart';
import 'package:safeconnex/front_end_code/pages/geofencing_page.dart';
import 'package:safeconnex/front_end_code/pages/home_mainscreen.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_init.dart';
import 'package:safeconnex/front_end_code//pages/signup_page.dart';
import 'package:safeconnex/front_end_code/pages/join_circle.dart';
import 'package:safeconnex/front_end_code/pages/circle_pages/join_circle_confirm.dart';
import 'package:safeconnex/front_end_code/pages/login_page.dart';
import 'package:safeconnex/front_end_code/pages/onboarding_page.dart';
import 'package:safeconnex/front_end_code/pages/password_change_page.dart';
import 'package:safeconnex/front_end_code/provider/new_map_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'backend_code/firebase_scripts/firebase_options.dart';
import 'front_end_code/pages/circle_pages/create_circle_page.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseInit.rootFirebase;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isFirstTimeOpen;

  setPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    isFirstTimeOpen = preferences.getBool("isFirstTime");

    if (isFirstTimeOpen != null && isFirstTimeOpen == true) {
      preferences.setBool("isFirstTime", false);
      print(isFirstTimeOpen);
    } else {
      preferences.setBool("isFirstTime", true);
    }
    print(isFirstTimeOpen);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    setPreferences();
    precacheImage(
        AssetImage("assets/images/create_circle_background.png"), context);
    precacheImage(AssetImage("assets/images/circle_background.png"), context);

    // if (isFirstTimeOpen == null) {
    //   return Material(
    //     child: Container(
    //       color: Colors.white,
    //       child: MaterialApp(
    //           home: Icon(
    //         Icons.hourglass_bottom,
    //         size: 65,
    //       )),
    //     ),
    //   );
    // }
    return MaterialApp(
      title: 'Safe Connex',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 0, 21, 255)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      // initialRoute: "/",
      // routes: {
      //   "/": (context) => OnBoardingScreen(),
      //   "/login": (context) => LoginPage(),
      //   "/home": (context) => MainScreen(),
      //   "/create_circle": (context) => CirclePage(),
      //   "/join_circle": (context) => JoinCirclePage(),
      //   "/temp": (context) => NewMapProvider(),
      //   "/temp2": (context) => GeofencingPage(),
      //   "/temp3": (context) => CarouseSliderComponent(),
      // },
      home: ChangeToAgency(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
      ),
      // home: PasswordChange(),
    );
  }
}
