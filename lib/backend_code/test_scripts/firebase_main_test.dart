import 'package:safeconnex/backend_code/firebase_scripts/firebase_news_database.dart';
import '../firebase_scripts/firebase_init.dart';
import '../firebase_scripts/firebase_auth.dart';

void main(List<String> args) {
  FirebaseInit.rootFirebase;
  FirebaseAuthHandler authentication = FirebaseAuthHandler();
  NewsDatabaseHandler databaseHandler = NewsDatabaseHandler();
  //databaseHandler.listenOnTheNews();
  //authentication.registerEmailAccount("charleszolina19@gmail.com", "charleszolina1000", "Charles", "Zolina", 9512807552, "2000/12/24", "link");
  //authentication.loginEmailAccount("charleszolina19@gmail.com", "charleszolina1000");
  //authentication.phoneVerificationAndroid('+447444555666');
  //authentication.phoneVerificationAndroid("+639608975193");
  databaseHandler.createNews("PNP", "Another", "Stay Away");
}