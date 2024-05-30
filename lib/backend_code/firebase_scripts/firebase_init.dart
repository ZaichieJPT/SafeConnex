import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

/// Universal Firebase Initialization Class
class FirebaseInit{
  ///Can be used to create Firebase Functions
  static Future<FirebaseApp> rootFirebase = Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  static FirebaseApp firebaseApp = Firebase.app();
}

