import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quicklo_app/Constants/color.dart';
import 'package:quicklo_app/Widget/edge-to-edge.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

class Onboarding  extends StatelessWidget {
  const Onboarding ({super.key});
  @override
  Widget build(BuildContext context) {
    return EdgeToEdgeWrapperWidget(
      child: Scaffold(
        backgroundColor: AppColors.dark,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 8.h, left: 5.w, right: 5.w, bottom: 2.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
          
              SizedBox(
                height: 14.h

              ),
          
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: GestureDetector(
                    onTap: (){
                        Navigator.of(context).pushNamed('/SignUp');
                    },
                    child: Container(
                      height: 7.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: AppColors.mygradient,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(
                        child: Text(
                          'Get Started',
                          style: Theme.of(context).textTheme.labelMedium
                        ),
                      )
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
