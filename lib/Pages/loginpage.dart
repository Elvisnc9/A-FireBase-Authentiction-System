import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zoom'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            const Text('Start or Join a Meeting'),
            SizedBox(
              height:200,
              width: double.infinity,
              child: Image.asset('assets/Images/onboarding.jpg')),
        
            ElevatedButton(
              onPressed: () {
              
               
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}