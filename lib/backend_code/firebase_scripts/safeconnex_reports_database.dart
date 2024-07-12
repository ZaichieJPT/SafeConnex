
import 'package:firebase_database/firebase_database.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_init.dart';

class SafeConnexReportsDatabase{
  DatabaseReference _dbReportsReference = FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("reports");

  DatabaseReference _dbNotificationReference = FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("notification_data");

  int? sosCount = 0;
  int? canceledSOSCount = 0;
  int? contactInfoCount = 0;

  Future<void> setSOSReports() async {
    DataSnapshot reportsSnapshot = await _dbReportsReference.child("SOS_Reports").get();

    if(reportsSnapshot.exists){
      int count = int.parse(reportsSnapshot.child("count").value.toString()) + 1;
      await _dbReportsReference.child("SOS_Reports").update({
      "count": count,
      });
    }else{
      await _dbReportsReference.child("SOS_Reports").set({
        "count": 1,
      });
    }
  }

  Future<void> getReportCounts() async {
    DataSnapshot sosSnapshot = await _dbReportsReference.child("SOS_Reports").get();
    DataSnapshot cancelSosSnapshot = await _dbReportsReference.child("Canceled_SOS_Reports").get();
    DataSnapshot contactInfoSnapshot = await _dbReportsReference.child("Contact_Info_Request").get();

    sosCount = int.parse(sosSnapshot.child("count").value.toString());
    canceledSOSCount = int.parse(cancelSosSnapshot.child("count").value.toString());
    contactInfoCount = int.parse(contactInfoSnapshot.child("count").value.toString());
  }

  Future<void> setCancelledSOSReports() async {
    DataSnapshot reportsSnapshot = await _dbReportsReference.child("Canceled_SOS_Reports").get();

    if(reportsSnapshot.exists){
      int count = int.parse(reportsSnapshot.child("count").value.toString()) + 1;
      await _dbReportsReference.child("Canceled_SOS_Reports").update({
        "count": count,
      });
    }else{
      await _dbReportsReference.child("Canceled_SOS_Reports").set({
        "count": 1,
      });
    }
  }

  Future<void> setContactInfoRequest() async {
    DataSnapshot reportsSnapshot = await _dbReportsReference.child("Contact_Info_Request").get();

    if(reportsSnapshot.exists){
      int count = int.parse(reportsSnapshot.child("count").value.toString()) + 1;
      await _dbReportsReference.child("Contact_Info_Request").update({
        "count": count,
      });
    }else{
      await _dbReportsReference.child("Contact_Info_Request").set({
        "count": 1,
      });
    }
  }

  Future<void> getSortedNotification() async {
    DataSnapshot notificationData = await _dbNotificationReference.get();

    for(var users in notificationData.children){
      for(var notifications in users.children){
        print(notifications);
      }
    }
  }
}