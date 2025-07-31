import 'package:flutter/material.dart';
import 'package:quicklo_app/Pages/authForm.dart';

class Headtitle extends StatelessWidget {
  const Headtitle({
    super.key,
    required this.widget,
  });

  final AuthForm widget;

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.isSignUp? 'Create your account' : 'Login to your account',
      textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }
}
