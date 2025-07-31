import 'package:flutter/material.dart';
import 'package:quicklo_app/Constants/color.dart';
import 'package:quicklo_app/Pages/authForm.dart';
import 'package:quicklo_app/Services/google_auth.dart';
import 'package:quicklo_app/Widget/socialButton.dart';


class SocialAuthentications extends StatefulWidget {
  const SocialAuthentications({
    super.key,
    required this.widget,
  });

  final AuthForm widget;

  @override
  State<SocialAuthentications> createState() => _SocialAuthenticationsState();
}

class _SocialAuthenticationsState extends State<SocialAuthentications> {
    final AuthService _authMethod = AuthService();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Socials(
          image: 'assets/Icons/google.png',
          name: widget.widget.isSignUp? 'Sign Up with Google' : 'Log In with Google',
          onTap: () async {
            bool res = await _authMethod.signInWithGoogle(context);
            if(res) {
              // Navigate to the home screen if login is successful

              // ignore: use_build_context_synchronously
              Navigator.pushNamed(context, '/Home');
            } else {
              // Handle error if login fails
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Login failed, please try again')),
              );
            }
            // Handle Google login
          },
        ),
        Socials(
          image: 'assets/Icons/facebook.png',
          name: widget.widget.isSignUp? 'Sign Up with Facebook' : 'Log In with Facebook',
        onTap: () {
            // Handle Facebook login
          },
        ),
      ],
    );
  }
}
