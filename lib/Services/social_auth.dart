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
    bool _isloading = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Socials(
          image: 'assets/Icons/google.png',
          name: widget.widget.isSignUp? 'Sign Up with Google' : 'Log In with Google',
          onTap: () async {
           setState(() {
              _isloading = true;
            });
            bool res = await _authMethod.signInWithGoogle(context);

            if (res) {
              // Wait for a duration before navigating
              await Future.delayed(const Duration(seconds: 2)); // Set duration here
              setState(() {
                _isloading = false;
              });
              Navigator.pushNamed(context, '/Home');
            } else {
              setState(() {
                _isloading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Login failed, please try again')),
              );
            }
          },
          child: _isloading
              ? CircularProgressIndicator(color: AppColors.yellow)
              : null,
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
