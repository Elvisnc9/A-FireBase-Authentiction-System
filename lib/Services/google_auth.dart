import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quicklo_app/utl/utl.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  
  Stream<User?> get authChanges => _auth.authStateChanges();
  
  Future<bool>signInWithGoogle(BuildContext context) async {
    bool res = false;
    try{
    
    //begin interactive sign in process 
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();


    //obtain auth details from request

    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    //create a new crendential for user 
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential = await _auth.signInWithCredential(credential);
    User? user = userCredential.user;

    if(user!=null){
      if(userCredential.additionalUserInfo!.isNewUser){

     await  _firebaseFirestore.collection('users').doc(user.uid).set({
        'username': user.displayName,
        'uid': user.uid,
        'profilePhoto': user.photoURL,

      } );
        
      }
       res = true;
    }

    } on FirebaseAuthException catch(e){ 
      showSnackBar(context, e.message!);
    }
    return res;

    
  }
} 