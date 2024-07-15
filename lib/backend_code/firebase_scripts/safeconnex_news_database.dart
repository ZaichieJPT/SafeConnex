
import 'package:firebase_database/firebase_database.dart';
import 'package:safeconnex/api/dependecy_injector/injector.dart';
import 'package:safeconnex/backend_code/firebase_scripts/firebase_init.dart';

class SafeConnexNewsDatabase{
  DatabaseReference _dbNewsReference = FirebaseDatabase.instanceFor(
      app: FirebaseInit.firebaseApp,
      databaseURL: "https://safeconnex-92054-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .ref("news");

  List<Map<String, dynamic>> newsData = [];
  Future<void> createNews(String agency, String agencyType, String agencyLocation,
  String agencyPhone, String agencyTelephone, String agencyEmail, String agencyFacebook,
      String agencyWebsite, String title, String body, String sender, String role, DateTime date, [String? imagePath]) async
  {
    final postData = {
      'agency': agency,
      'agencyType': agencyType,
      "agencyLocation": agencyLocation,
      "agencyPhone": agencyPhone,
      "agencyTelephone": agencyTelephone,
      "agencyEmail": agencyEmail,
      "agencyFacebook": agencyFacebook,
      "agencyWebsite": agencyWebsite,
      'title': title,
      'body': body,
      'sender': sender,
      'role': role,
      'date': date,
      'imagePath': imagePath
    };

    final newPostKey = _dbNewsReference.push().key;

    final Map<String, Map> updates = {};
    updates['/$newPostKey'] = postData;

    await _dbNewsReference.update(updates);

    print("Database Update Done");
  }

  Future<void> editNews(String postKey, String title, String body, String date, [String? imagePath]) async {
    final postData = {
      'title': title,
      'body': body,
      'date': date,
      'imagePath': imagePath
    };

    await _dbNewsReference.update(postData);
  }

  Future<void> deleteNews(String postKey) async {
    await _dbNewsReference.child(postKey).remove();
  }

  Future<void> listenOnTheNews() async
  {
    _dbNewsReference.orderByChild("date").onValue.listen((DatabaseEvent event) {
      final news = event.snapshot;
      //print(news);
      if(newsData.isEmpty){
        for(var post in news.children){
          //print(post.value);
          
          newsData.add({
            "postKey": post.key.toString(),
            "agencyType": post.child("agencyType").value,
            "agencyLocation": post.child("agencyLocation").value,
            "agencyPhone": post.child("agencyPhone").value,
            "agencyTelephone": post.child("agencyTelephone").value,
            "agencyEmail": post.child("agencyEmail").value,
            "agencyFacebook": post.child("agencyFacebook").value,
            "agencyWebsite": post.child("agencyWebsite").value,
            "role": post.child("role").value,
            "agency": post.child("agency").value,
            "sender": post.child("sender").value,
            "body": post.child("body").value,
            "title": post.child("title").value,
            "date": post.child("date").value,
            "imagePath": post.child("imagePath").value
          });
        }
      }else{
        newsData.clear();
        for(var post in news.children){
          //print(post.value);
          //print(post.value);
          newsData.add({
            "postKey": post.key.toString(),
            "agencyType": post.child("agencyType").value,
            "agencyLocation": post.child("agencyLocation").value,
            "agencyPhone": post.child("agencyPhone").value,
            "agencyTelephone": post.child("agencyTelephone").value,
            "agencyEmail": post.child("agencyEmail").value,
            "agencyFacebook": post.child("agencyFacebook").value,
            "agencyWebsite": post.child("agencyWebsite").value,
            "role": post.child("role").value,
            "agency": post.child("agency").value,
            "sender": post.child("sender").value,
            "body": post.child("body").value,
            "title": post.child("title").value,
            "date": post.child("date").value,
            "imagePath": post.child("imagePath").value
          });
        }
      }


      print(newsData);
    });
  }
}