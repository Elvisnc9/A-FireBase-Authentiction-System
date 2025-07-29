import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
  signInWithGoogle() async {

    //begin interactive sign in process 
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();


    //obtain auth details from request

    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    //create a new crendential for user 
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
    
  }
}