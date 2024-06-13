
import 'package:firebase_database/firebase_database.dart';
import 'package:safeconnex/controller/app_manager.dart';
import 'firebase_init.dart';

class FeedbackDatabase{
  DatabaseReference dbfeedbackReference = FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("feedback");

  createFeedBack(String feedBack) async {
    final feedbackData = {
      'username': AppManager.authHandler.authHandler.currentUser!.displayName,
      'userId': AppManager.authHandler.authHandler.currentUser!.uid,
      'body': feedBack
    };

    final newFeedKey = dbfeedbackReference.push().key;

    final Map<String, Map> updates = {};
    updates['/$newFeedKey'] = feedbackData;

    await dbfeedbackReference.update(updates);

    print("Database Update Done");
  }
}