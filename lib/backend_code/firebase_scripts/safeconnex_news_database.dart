
import 'package:firebase_database/firebase_database.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_init.dart';

class SafeConnexNewsDatabase{
  DatabaseReference _dbNewsReference = FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("news");

  List<Map<String, dynamic>> newsData = [];
  Future<void> createNews(String agency, String title, String body, String sender, String role, String date) async
  {
    final postData = {
      'agency': agency,
      'title': title,
      'body': body,
      'sender': sender,
      'role': role,
      'date': date
    };

    final newPostKey = _dbNewsReference.push().key;

    final Map<String, Map> updates = {};
    updates['/$newPostKey'] = postData;

    await _dbNewsReference.update(updates);

    print("Database Update Done");
  }

  Future<void> listenOnTheNews() async
  {
    _dbNewsReference.onValue.listen((DatabaseEvent event) {
      final news = event.snapshot;
      //print(news);
      for(var post in news.children){
        //print(post.value);
        newsData.add({
          "role": post.child("role").value,
          "agency": post.child("agency").value,
          "sender": post.child("sender").value,
          "body": post.child("body").value,
          "title": post.child("title").value,
          "date": post.child("date").value,
        });
      }

      print(newsData);
    });
  }
}