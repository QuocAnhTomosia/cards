import 'package:firebase_auth/firebase_auth.dart';
import 'package:yugi_oh_cards/services/firebase_firestore_service.dart';

class FirebaseAuthService {
  final _instance = FirebaseAuth.instance;

  Future<String> emailSignIn(String email, String password) async {
    try {
      final UserCredential userCredential = await _instance
          .signInWithEmailAndPassword(email: email, password: password);
      return FireStoreService().getUser(email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    } catch (e) {
      return "some error happend";
    } finally {
      // ignore: control_flow_in_finally
      return "Done";
    }
  }
}
