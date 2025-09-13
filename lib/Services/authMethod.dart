
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


ValueNotifier<AuthMethod> authMethod = ValueNotifier(AuthMethod());

class AuthMethod {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => firebaseAuth.currentUser;

  Stream<User?> get authStateChange => firebaseAuth.authStateChanges();


//SignIN
  Future<UserCredential> signIn({
    required String email,
    required String password,
  })async {
    return  await firebaseAuth.signInWithEmailAndPassword(
      email: email, password: password);
  }

  //CreateAccount
  Future<UserCredential> createAccount({
    required String email,
    required String password,
  })async{
    return await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  //SignOUT
  Future<void> signOut()async {
    await firebaseAuth.signOut();
  }

  //resetPASSWORD
  Future<void> resetPassword({
    required String email,
  })async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

 
}