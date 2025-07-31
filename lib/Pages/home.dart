import 'package:flutter/material.dart';
import 'package:quicklo_app/Constants/color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.orange,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Welcome to Home Screen',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ],
        )
      )
    );
  }
}