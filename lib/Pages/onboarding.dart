// ignore_for_file: unused_import

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:quicklo_app/Constants/color.dart';
import 'package:quicklo_app/Widget/edge-to-edge.dart';
import 'package:quicklo_app/Widget/submitButton.dart';
import 'package:quicklo_app/Widget/theme_switch.dart';
import 'package:quicklo_app/provider/theme_provider.dart';
import 'package:rive/rive.dart' show RiveAnimation;
// import 'package:rive/rive.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

class Onboarding extends ConsumerWidget {
  const Onboarding({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isLightMode = themeMode == ThemeMode.light;
    return EdgeToEdgeWrapperWidget(
      child: Scaffold(
        body: Stack(
          children: [
             

            SafeArea(
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
                    ThemeSwitch(isLightMode: isLightMode, themeMode: themeMode),
                  
                   SizedBox(height: 20.h),
                  
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
                  
                    SizedBox(height: 20.h),
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
          ],
        ),
      ),
    );
  }
}

