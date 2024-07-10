
import 'package:firebase_database/firebase_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_init.dart';

class SafeConnexNotificationDatabase{
  DatabaseReference _dbNotificationDataReference = FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("notification_data");

  List<Map<String, dynamic>> notificationData = [];

  Future<void> addNotificationToDatabase(String userId, int notificationType, String fullname, String name, String age, String date, [String? data]) async {

    final notificationData = {
      'type': notificationType,
      'fullname': fullname,
      'name': name,
      'age': age,
      'date': date,
      'data': data
    };

    final newNotificationKey = _dbNotificationDataReference.push().key;

    final Map<String, Map> sendNotification = {};
    sendNotification['/$newNotificationKey'] = notificationData;

    await _dbNotificationDataReference.child(userId).update(sendNotification);

    print("notification sent");
  }

  Future<void> getNotificationsFromDatabase(String userId) async {
    _dbNotificationDataReference.onValue.listen((DatabaseEvent event) {
      final notificationsDataFromDatabase = event.snapshot;

      if(notificationData.isEmpty) {
        for (var notification in notificationsDataFromDatabase.children) {
          //print(post.value);
          notificationData.add({
            'type': notification.child("type").value,
            'fullname': notification.child("fullname").value,
            'name': notification.child("name").value,
            'age': notification.child("age").value,
            'date': notification.child("date").value,
            'data': notification.child("data").value
          });
        }
      }else if(notificationData.isNotEmpty){
        notificationData.clear();
        for (var notification in notificationsDataFromDatabase.children) {
          //print(post.value);
          notificationData.add({
            'type': notification.child("type").value,
            'fullname': notification.child("fullname").value,
            'name': notification.child("name").value,
            'age': notification.child("age").value,
            'date': notification.child("date").value,
            'data': notification.child("data").value
          });
        }
      }
    });
  }
}