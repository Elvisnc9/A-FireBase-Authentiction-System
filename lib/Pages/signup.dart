import 'package:flutter/material.dart';
import 'package:quicklo_app/Pages/authForm.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthForm(
      isSignUp: true,
         );
}
}