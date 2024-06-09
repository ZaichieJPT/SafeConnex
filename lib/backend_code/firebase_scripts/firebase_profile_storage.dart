import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirebaseProfileStorage{
  final profileRefs = FirebaseStorage.instance.ref().child("profile_pics");
  static String? imageUrl;

  FirebaseProfileStorage(String userId){
    getProfilePic(userId);
  }

  getProfilePic(String userId) async {
      final alternative_pic_male = profileRefs.child("male_profile.png");
      final networkImageAlternate = await alternative_pic_male.getDownloadURL();

      try{
        final profile_pic = profileRefs.child("${userId}.png");
        final networkImage = await profile_pic.getDownloadURL();
        imageUrl = networkImage;
      } on FirebaseException catch(e){
        if(e.code == "object-not-found"){
          imageUrl = networkImageAlternate;
        }
      }
  }

  uploadProfilePic(String userId, String path) async {
    final profile_pic = profileRefs.child("${userId}.png");
    final file = File(path);
    await profile_pic.putFile(file);
    print("File Uploaded");
  }
}