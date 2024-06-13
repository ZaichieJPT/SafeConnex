
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_auth.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_circle_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_coordinates_store.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_feedback_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_geofence_store.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_init.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_news_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_profile_storage.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_safety_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_users_database.dart';

class AppManager{

  static FirebaseAuthHandler authHandler = FirebaseAuthHandler();
  static CircleDatabaseHandler circleDatabaseHandler = CircleDatabaseHandler();
  static FlutterFireCoordinates flutterFireCoordinates = FlutterFireCoordinates();
  static GeofenceDatabase geofenceDatabase = GeofenceDatabase();
  static NewsDatabaseHandler newsDatabaseHandler = NewsDatabaseHandler();
  static SafetyScoringDatabaseHandler safetyScoringDatabaseHandler = SafetyScoringDatabaseHandler();
  static UserDatabaseHandler userDatabaseHandler = UserDatabaseHandler();
  static FeedbackDatabase feedbackDatabase = FeedbackDatabase();

}