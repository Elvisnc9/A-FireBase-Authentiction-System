// Divider widget to separate the social authentication buttons
import 'package:flutter/material.dart';
import 'package:quicklo_app/Constants/color.dart';

class Dividerz extends StatelessWidget {
  const Dividerz({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(color: AppColors.grey, thickness: 0.2),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Or',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        Expanded(
          child: Divider(color: AppColors.grey, thickness: 0.2),
        ),
      ],
    );
  }
}


