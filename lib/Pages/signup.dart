import 'package:flutter/material.dart';
import 'package:quicklo_app/Constants/color.dart';
import 'package:quicklo_app/Widget/edge-to-edge.dart';
import 'package:quicklo_app/Widget/submitButton.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return EdgeToEdgeWrapperWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.dark,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: 10.h,
              bottom: 2.h,
              left: 4.w,
              right: 4.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login to your\naccount',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),

                SizedBox(height: 5.h),

                Text(
                  'Your number & email address',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontSize: 12.sp,
                    color: AppColors.grey,
                  ),
                ),

                SizedBox(height: 1.h),

                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 4.h),

                Text(
                  'Enter Your Password',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontSize: 12.sp,
                    color: AppColors.grey,
                  ),
                ),
                SizedBox(height: 1.h),

                // Password Field
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  obscureText: true,
                ),

                SizedBox(height: 1.h),
                //Remember Me And A Forgotten Password Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      checkColor: Colors.black,
                      activeColor: AppColors.yellow,
                      value: rememberMe,
                      onChanged: (bool? value) {
                        setState(() {
                          rememberMe = value!;
                        });
                      },
                    ),

                    Text(
                      'Remember Me',
                      style: Theme.of(
                        context,
                      ).textTheme.labelMedium?.copyWith(fontSize: 11.sp),
                    ),

                    Spacer(),

                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgotten Password',
                        style: Theme.of(
                          context,
                        ).textTheme.labelMedium?.copyWith(
                          fontSize: 10.sp,
                          color: AppColors.yellow,
                        ),
                      ),
                    ),
                  ],
                ),

                //LOGIN BUTTON
                SubmitButton(name: 'Log in', push: () {}),

                SizedBox(height: 1.h),

                //Divider
                Row(
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
                ),

                SizedBox(height: 2.h),

                Socials(
                  image: 'assets/Icons/google.png',
                  name: ' Sign Up with Google',
                ),
                Socials(
                  image: 'assets/Icons/facebook.png',
                  name: 'Sign Up with Facebook',
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: Theme.of(
                        context,
                      ).textTheme.labelMedium?.copyWith(fontSize: 12.sp),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Create an account',
                        style: Theme.of(
                          context,
                        ).textTheme.labelMedium?.copyWith(
                          fontSize: 12.sp,
                          color: AppColors.yellow,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Socials extends StatelessWidget {
  const Socials({super.key, required this.image, required this.name});
  final String image;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
    );
  }
}
