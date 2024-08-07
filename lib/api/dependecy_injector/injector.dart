import 'package:get_it/get_it.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_init.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_agencies.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_agency_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_authentication.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_circle_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_feedback_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_firestore.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_geofence_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_location_history.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_news_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_notification.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_notification_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_reports_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_scoring_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_storage.dart';

class DependencyInjector{
  final locator = GetIt.instance;

  void setupDependencyInjector(){

    // Firebase Authentication Class
    locator.registerSingleton<SafeConnexAuthentication>(SafeConnexAuthentication());

    locator.registerSingleton<SafeConnexCircleDatabase>(SafeConnexCircleDatabase());

    locator.registerSingleton<SafeConnexProfileStorage>(SafeConnexProfileStorage());

    locator.registerSingleton<SafeConnexGeofenceDatabase>(SafeConnexGeofenceDatabase());

    locator.registerSingleton<SafeConnexAgencyDatabase>(SafeConnexAgencyDatabase());

    locator.registerSingleton<SafeConnexNewsDatabase>(SafeConnexNewsDatabase());

    locator.registerSingleton<SafeConnexSafetyScoringDatabase>(SafeConnexSafetyScoringDatabase());

    locator.registerSingleton<SafeConnexFeedbackDatabase>(SafeConnexFeedbackDatabase());

    locator.registerSingleton<SafeConnexGeolocation>(SafeConnexGeolocation());

    locator.registerSingleton<SafeConnexNewsStorage>(SafeConnexNewsStorage());

    locator.registerSingleton<SafeConnexNotification>(SafeConnexNotification());

    locator.registerSingleton<SafeConnexLocationHistory>(SafeConnexLocationHistory());

    locator.registerSingleton<SafeConnexNotificationDatabase>(SafeConnexNotificationDatabase());

    locator.registerSingleton<SafeConnexReportsDatabase>(SafeConnexReportsDatabase());

    locator.registerSingleton<SafeConnexAgencies>(SafeConnexAgencies());
  }
}