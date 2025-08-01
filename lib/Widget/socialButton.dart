import 'package:flutter/material.dart';
import 'package:quicklo_app/Constants/color.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

class Socials extends StatelessWidget {
  const Socials({super.key, required this.image,
   required this.name,
    this.onTap, CircularProgressIndicator? child});
  final String image;
  final String name;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 7.5.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.darkbox,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: SizedBox(height: 2.5.h, child: Image.asset(image)),
              ),
        
              Text(
                name,
                style: Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(fontSize: 12.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
