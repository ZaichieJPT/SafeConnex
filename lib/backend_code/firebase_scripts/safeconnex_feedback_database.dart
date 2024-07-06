import 'package:firebase_database/firebase_database.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_init.dart';
import 'package:safeconnex/backend_code/firebase_scripts/safeconnex_authentication.dart';

class SafeConnexFeedbackDatabase{
  DatabaseReference _dbFeedbackReference = FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("feedback");

  createFeedBack(String feedBack) async {
    final feedbackData = {
      'username': DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.displayName,
      'userId': DependencyInjector().locator<SafeConnexAuthentication>().currentUser!.uid,
      'body': feedBack
    };

    final newFeedKey = _dbFeedbackReference.push().key;

    final Map<String, Map> updates = {};
    updates['/$newFeedKey'] = feedbackData;

    await _dbFeedbackReference.update(updates);

    print("Database Update Done");
  }
}