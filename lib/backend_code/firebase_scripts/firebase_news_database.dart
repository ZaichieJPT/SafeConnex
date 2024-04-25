import 'package:firebase_database/firebase_database.dart';
import "firebase_init.dart";

class NewsDatabaseHandler {
  DatabaseReference dbNewsReference = FirebaseDatabase.instanceFor(app: FirebaseInit.firebaseApp, databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/").ref("news");

  Future<void> createNews(String agency, String title, String body) async
  {
    final postData = {
      'agency': agency,
      'title': title,
      'body': body
    };

    final newPostKey = dbNewsReference.push().key;

    final Map<String, Map> updates = {};
    updates['/$newPostKey'] = postData;

    await dbNewsReference.update(updates);

    print("Database Update Done");
  }

  Future<void> listenOnTheNews() async
  {
    dbNewsReference.onValue.listen((DatabaseEvent event) {
      final news = event.snapshot.value;
      print(news);
    });
  }
}