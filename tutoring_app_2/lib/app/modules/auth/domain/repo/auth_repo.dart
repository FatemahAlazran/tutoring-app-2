import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepo {
  AuthRepo(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  User? get currectUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanged => _firebaseAuth.authStateChanges();

  Future<User?> createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String userName}) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // await saveUserInfoToFirebase(
      //   userCredential.user?.uid,

      //   userCredential.user?.email,
      //   userCredential.user?.photoURL,
      // );
      return userCredential.user;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();

      if (googleSignInAccount == null) return null;

      final googleAuth = await googleSignInAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      if (userCredential.user != null) {
        await saveUserInfoToFirebase(
            userCredential.user!.uid.toString(),
            userCredential.user!.displayName.toString(),
            userCredential.user!.email.toString());
      }

      return userCredential.user;
    } catch (e) {
      throw e.toString();
    }
  }

  saveUserInfoToFirebase(String? uid, String? userName, String? email) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(uid).set({
        "username": userName,
        "email": email,
        "id": uid,
        "userLocation": null
      });
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw e.toString();
    }
  }
}

class AuthException implements Exception {
  AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}
