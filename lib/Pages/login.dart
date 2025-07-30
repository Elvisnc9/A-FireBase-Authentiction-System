import 'package:flutter/material.dart';
import 'package:quicklo_app/Pages/authForm.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthForm(
      isSignUp: false,
    ) ;
  }
}