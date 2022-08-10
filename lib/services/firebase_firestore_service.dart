import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:yugi_oh_cards/models/user_model.dart';

class FireStoreService {
  // instance de mo firestore
  //ref de mo image storage
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  final FirebaseStorage _ref = FirebaseStorage.instance;

  getUserByUid(String uid) async {
    var tmp = await _instance.collection("Users").doc(uid).get();
    return MyUser.fromJson(tmp.data()!);
  }

  Future<String> addNewUser(
    String name,
    String email,
    String password,
    String imageLink,
    String phoneNumber,
  ) async {
    var checkUser = await _instance
        .collection("Users")
        .where("email", isEqualTo: email)
        .get();
    if (checkUser.docs.isEmpty || checkUser.docs[0].data()["email"] != email) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await _instance.collection("Users").add({
          "email": email,
          "name": name,
          "image_link": imageLink,
          "favorites": {},
          "orderList": {},
          "phoneNumber": phoneNumber,
          "password": password,
        });

        // de userCredentail phuc vu cho
        //viec xu ly cac exception

        return "Success";
      } on FirebaseException catch (e) {
        return e.code;
      }
    } else {
      return "Your email has exists";
    }
  }

  updateInfo(String uid, String field, dynamic data) {
    _instance.collection("Users").doc(uid).update({field: data});
  }

  Future<String> uploadImage(File imageFile) async {
    {
      try {
        final fileName = basename(imageFile.path);
        final ref = _ref.ref().child('users_images/$fileName');
        await ref.putFile(imageFile);
        String getdownloadUrl = await ref.getDownloadURL();
        return getdownloadUrl;
      } catch (e) {
        return "Upload Error";
      }
    }
  }

  getUser(String email) async {
    var userSnapshots = await _instance
        .collection("Users")
        .where("email", isEqualTo: email)
        .get();

    return userSnapshots.docs[0].id;
  }
}
