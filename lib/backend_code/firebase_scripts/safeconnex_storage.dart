import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class SafeConnexProfileStorage{
  final _profileRefs = FirebaseStorage.instance.ref().child("profile_pics");
  String? imageUrl;

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

class SafeConnexIDDatabase{
  final _idRefs = FirebaseStorage.instance.ref().child("identification");

  Future<void> uploadFrontPicture(String userId, String path) async {
    final front_id = _idRefs.child(userId).child("${userId}_front.png");
    final file = File(path);
    await front_id.putFile(file);
    print("Front Uploaded");
  }

  Future<void> uploadBackPicture(String userId, String path) async {
    final back_id = _idRefs.child(userId).child("${userId}_back.png");
    final file = File(path);
    await back_id.putFile(file);
    print("Back Uploaded");
  }

  Future<void> uploadSelfiePicture(String userId, String path) async {
    final selfie_pic = _idRefs.child(userId).child("${userId}_selfie.png");
    final file = File(path);
    await selfie_pic.putFile(file);
    print("Selfie Uploaded");
  }
}

class SafeConnexNewsStorage{
  final _newsRefs = FirebaseStorage.instance.ref().child("news_pics");
  String? imageUrl;

  Future<void> getProfilePicture(String userId) async {
    final alternative_pic_male = _newsRefs.child("male_profile.png");
    final networkImageAlternate = await alternative_pic_male.getDownloadURL();

    try{
      final profile_pic = _newsRefs.child("${userId}.png");
      final networkImage = await profile_pic.getDownloadURL();
      imageUrl = networkImage;
    } on FirebaseException catch(e){
      if(e.code == "object-not-found"){
        imageUrl = networkImageAlternate;
      }
    }
  }

  Future<void> uploadNewsPic(String title, String path) async {
    final news_pic = _newsRefs.child("${title}.png");
    final file = File(path);
    await news_pic.putFile(file);
    print("File Uploaded");
  }
}

