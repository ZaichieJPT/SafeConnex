import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class SafeConnexCloudStorage{
  final _profileRefs = FirebaseStorage.instance.ref().child("profile_pics");
  static String? imageUrl;

  Future<void> getProfilePicture(String userId) async {
    final alternative_pic_male = _profileRefs.child("male_profile.png");
    final networkImageAlternate = await alternative_pic_male.getDownloadURL();

    try{
      final profile_pic = _profileRefs.child("${userId}.png");
      final networkImage = await profile_pic.getDownloadURL();
      imageUrl = networkImage;
    } on FirebaseException catch(e){
      if(e.code == "object-not-found"){
        imageUrl = networkImageAlternate;
      }
    }
  }

  Future<void> uploadProfilePic(String userId, String path) async {
    final profile_pic = _profileRefs.child("${userId}.png");
    final file = File(path);
    await profile_pic.putFile(file);
    print("File Uploaded");
  }
}