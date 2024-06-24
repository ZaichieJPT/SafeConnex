import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_init.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;

class SafeConnexNotification{
  // Create a firebase messaging instance
  final _firebaseMessaging = FirebaseMessaging.instance;
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


  static Future<String> getAccessToken() async {
    final serviceAccountJson = {

    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    auth.AccessCredentials credentials = await auth.obtainAccessCredentialsViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
      client
    );

    client.close();

    return credentials.accessToken.data; 
  }

  static sendNotification(String deviceToken, String notifTitle, String notifbody, Map<String, dynamic> dataToSend) async {
    final String serverAccessToken = await getAccessToken();
    String endpointFirebaseCloudMessaging = 'https://fcm.googleapis.com/v1/projects/safeconnex-92054/messages:send';

    final Map<String, dynamic> message = {
      'message': {
        'token': deviceToken,
        'notification': {
          'title': notifTitle,
          'body': notifbody
        },
        "data":{
          dataToSend,
        }
      }
    };

    final http.Response response = await http.post(
      Uri.parse(endpointFirebaseCloudMessaging),
      headers: <String, String> {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverAccessToken'
      },
      body: jsonEncode(message),
    );

    if(response.statusCode == 200){
      print("Notification Sent");
    }else{
      print("notification Failed to Send");
    }
  }
}