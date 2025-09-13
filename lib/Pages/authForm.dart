// ignore_for_file: no_logic_in_create_state

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicklo_app/Constants/color.dart';
import 'package:quicklo_app/Services/authMethod.dart';
import 'package:quicklo_app/Services/social_auth.dart';
import 'package:quicklo_app/Widget/divider.dart';
import 'package:quicklo_app/Widget/edge-to-edge.dart';
import 'package:quicklo_app/Widget/submitButton.dart';
import 'package:quicklo_app/Widget/title.dart';
import 'package:quicklo_app/provider/auth_provider.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

class AuthForm extends ConsumerWidget {
  final bool isSignUp;
  const AuthForm({super.key, required this.isSignUp});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(authFormProvider);
    final formNotifier = ref.read(authFormProvider.notifier);


    return EdgeToEdgeWrapperWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.dark,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 8.h,
                  bottom: 2.h,
                  left: 4.w,
                  right: 4.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Headtitle(widget: this),
                    SizedBox(height: 5.h),
                    EmailField(formState: formState, onChanged: formNotifier,)
                    
                
                    SizedBox(height: 1.h),
                
                    Text(
                      'Enter Your Password',
                      style: Theme.of(context).textTheme.labelMedium
                          ?.copyWith(fontSize: 12.sp, color: AppColors.grey),
                    ),
                    SizedBox(height: 1.h),
                    TextFormField(
                      controller: passwordController,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                          icon: Icon(
                            passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.lightbox,
                          ),
                        ),
                        hintText: '8 characters minimum',
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        filled: true,
                        fillColor: AppColors.lightbox.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                
                      obscureText: !passwordVisible,
                    ),
                    if (passwordError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4, left: 4),
                        child: Text(
                          passwordError!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                          ),
                        ),
                      ),
                
                    widget.isSignUp
                        ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 1.h),
                            Text(
                              'Confirm Password',
                              style: Theme.of(
                                context,
                              ).textTheme.labelMedium?.copyWith(
                                fontSize: 12.sp,
                                color: AppColors.grey,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            TextFormField(
                              controller: confirmPasswordController,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                hintText: '8 characters minimum',
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                filled: true,
                                fillColor: AppColors.lightbox.withOpacity(
                                  0.2,
                                ),
                
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      confirmPasswordVisible =
                                          !confirmPasswordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    confirmPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: AppColors.lightbox,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              obscureText: !confirmPasswordVisible,
                              validator: (value) {
                                confirmPasswordValidator;
                              },
                            ),
                          ],
                        )
                        : SizedBox(height: 1.h),
                
                    //Remember Me And A Forgotten Password Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.isSignUp
                            ? Row(
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(fontSize: 11.sp),
                                ),
                              ],
                            )
                            : Spacer(),
                
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
                    SubmitButton(
                      push:
                          isLoading
                              ? null // disables button when loading
                              : () {
                                widget.isSignUp ? onSignUp() : onLogin();
                              },
                      name: widget.isSignUp ? 'Sign Up' : 'Log In',
                    ),
                
                    SizedBox(height: 1.h),
                
                    //Divider
                    Dividerz(),
                
                    SizedBox(height: 2.h),
                
                    //Social Authentication Buttons
                    SocialAuthentications(widget: widget),
                
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.isSignUp
                              ? 'Already have an account?'
                              : 'Don\'t have an account?',
                          style: Theme.of(
                            context,
                          ).textTheme.labelMedium?.copyWith(fontSize: 12.sp),
                        ),
                        TextButton(
                          onPressed: () {
                            widget.isSignUp
                                ? Navigator.pushNamed(context, '/LogIn')
                                : Navigator.pushNamed(context, '/SignUp');
                          },
                          child: Text(
                            widget.isSignUp ? 'Log In' : 'Create an account',
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
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }
}

class EmailField extends StatelessWidget {
  final AuthFormState formState;
  final ValueChanged<String> onChanged;
  const EmailField({
    super.key, required this.formState, required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
      'Your number & email address',
      style: Theme.of(context).textTheme.labelMedium
          ?.copyWith(fontSize: 12.sp, color: AppColors.grey),
    ),
    SizedBox(height: 1.h),
    TextFormField(

      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
     
      decoration: InputDecoration(
        hintText: 'yourName@gmail.com',
        hintStyle: TextStyle(fontWeight: FontWeight.bold),
        filled: true,
        fillColor: AppColors.lightbox.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        errorText:  formState.emailError
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: onChanged,
    ),
   
      ],
    );
  }
}











/////////WIDGETS BELOW ARE FOR THE AUTH FORM

//PureForm is the main form that contains the email and password fields

// Title widget for the AuthPages


// Submit button widget that handles navigation based on the form type


