import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quicklo_app/utl/utl.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> get authChanges => _auth.authStateChanges();

  Future<bool> signInWithGoogle(BuildContext context) async {
    bool res = false;

    try {
      // Step 1: Begin interactive sign-in
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User cancelled the sign-in flow
        return false;
      }

      // Step 2: Get auth details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Step 3: Build a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Step 4: Sign in with Firebase
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await _firebaseFirestore.collection('users').doc(user.uid).set({
            'username': user.displayName,
            'uid': user.uid,
            'profilePhoto': user.photoURL,
            'email': user.email,
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message ?? "Something went wrong");
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return res;
  }
}
