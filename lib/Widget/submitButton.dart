import 'package:flutter/material.dart';
import 'package:quicklo_app/Constants/color.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback push;
  final String name;
  const SubmitButton({
    super.key, required this.push, required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric( vertical: 2.h),
      child: GestureDetector(
       onTap: push,
        child: Container(
          height: 7.h,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: AppColors.mygradient,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Center(
            child: Text(
             name,
              style: Theme.of(context).textTheme.labelMedium
            ),
          )
        ),
      ),
    );
  }
}
