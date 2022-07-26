import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class FireStoreService {
  // instance de mo firestore
  //ref de mo image storage
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  final FirebaseStorage _ref = FirebaseStorage.instance;

  Future<String> addNewUser(
      String email, String name, String password, String imageLink) async {
    await _instance.collection("Users").add({
      "email": email,
      "name": name,
      "image_link": imageLink,
      "favorites": {},
      "orderList": {}
    });
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: name,
        password: password,
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "weak password";
      } else if (e.code == 'email-already-in-use') {
        return "email-already-in-use";
      }
    } catch (e) {
      return "Some Error happend";
    } finally {
      // ignore: control_flow_in_finally
      return "Done";
    }
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
}
