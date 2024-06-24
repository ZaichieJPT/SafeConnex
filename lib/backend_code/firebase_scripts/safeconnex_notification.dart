import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_init.dart';

class SafeconnexNotification{
  // Create a firebase messaging instance
  final _firebaseMessaging = FirebaseMessaging.instance;

  // Message Stream Controller
  final _messageStreamController = BehaviorSubject<RemoteMessage>();

  // Notification Token References
  DatabaseReference dbNotificationTokenReference = FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("notification_tokens");

  /// initialize Firebase Messaging
  Future<void> initializeNotification(String userId) async {
    // request permission from the user
    await _firebaseMessaging.requestPermission(criticalAlert: true);

    // fetch the FCM Token for this device
    final _fcmToken = await _firebaseMessaging.getToken();

    // print token
    await dbNotificationTokenReference.child(userId).set({
      "notificationToken": _fcmToken
    });
  }
}