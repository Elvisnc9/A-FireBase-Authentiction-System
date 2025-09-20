import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quicklo_app/Constants/color.dart';
import 'package:quicklo_app/Widget/edge-to-edge.dart';
import 'package:quicklo_app/Widget/submitButton.dart';
import 'package:quicklo_app/Widget/theme_switch.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});
  @override
  Widget build(BuildContext context) {
    return EdgeToEdgeWrapperWidget(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: 1.h,
              left: 5.w,
              right: 5.w,
              bottom: 2.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Align(
                  alignment: Alignment.topRight,
                  child: ThemeSwitchButton()),
                

                SizedBox(
                  height: 40.h,
                  child: Lottie.asset('assets/anim/Controller.json'),
                ),

                Text(
                  ' Discover new passions & start your journey your future awaits.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                SizedBox(height: 2.h),

                Text(
                  'Start Your Career Journey and Unlock new opportunities',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelSmall,
                ),

                SizedBox(height: 14.h),
                SubmitButton(
                  name: 'Get Started',
                  push: () {
                    Navigator.of(context).pushNamed('/SignUp');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
