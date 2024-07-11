
import 'package:firebase_database/firebase_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_init.dart';

class SafeConnexNotificationDatabase{
  DatabaseReference _dbNotificationDataReference = FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("notification_data");

  DatabaseReference _dbAgencyReference = FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("agency");

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

  Future<void> sendNotificationToAgency(int notificationType, String fullname, String name, String age, String date, [String? agencyType] ) async {
    if(agencyType != null || agencyType != ""){
      //Send to all agency in the same agency type
      DataSnapshot agencySnapshot = await _dbAgencyReference.child(
          agencyType!).get();

      for(var agencyNames in agencySnapshot.children){
        for (var employee in agencyNames.child("employees").children) {
          addNotificationToDatabase(
              employee.key!,
              notificationType,
              fullname,
              name,
              age,
              date
          );
        }
      }
    }
    else{
      //Send to all agency in general
      DataSnapshot agencyTypeSnapshot = await _dbAgencyReference.get();

      for (var agencyTypes in agencyTypeSnapshot.children){
        for(var agencyNames in agencyTypes.children){
          for (var employee in agencyNames.child("employees").children) {
            addNotificationToDatabase(
                employee.key!,
                notificationType,
                fullname,
                name,
                age,
                date
            );
          }
        }
      }
    }
  }

  Future<void> getNotificationsFromDatabase(String userId) async {
    _dbNotificationDataReference.child(userId).onValue.listen((DatabaseEvent event) {
      final notificationsDataFromDatabase = event.snapshot;

      if(notificationData.isEmpty) {
        for (var notification in notificationsDataFromDatabase.children) {
          //print(post.value);
          notificationData.add({
            'notifKey': notification.key.toString(),
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
            'notifKey': notification.key.toString(),
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

  Future<void> deleteNotificationForUser(String userId, String notifKey) async {
    await _dbNotificationDataReference.child(userId).child(notifKey).remove();
  }
}