// ignore_for_file: no_logic_in_create_state, dead_code

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicklo_app/Constants/color.dart';
import 'package:quicklo_app/Services/social_auth.dart';
import 'package:quicklo_app/Widget/divider.dart';
import 'package:quicklo_app/Widget/edge-to-edge.dart';
import 'package:quicklo_app/Widget/submitButton.dart';
import 'package:quicklo_app/Widget/theme_switch.dart';
import 'package:quicklo_app/Widget/title.dart';
import 'package:quicklo_app/provider/auth_provider.dart';
import 'package:quicklo_app/provider/theme_provider.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

class AuthForm extends ConsumerStatefulWidget {
  final bool isSignUp;
  const AuthForm({super.key, required this.isSignUp});

  @override
  ConsumerState<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends ConsumerState<AuthForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  bool rememberMe = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(authFormProvider);
    final themeMode = ref.watch(themeProvider);
    final isLightMode = themeMode == ThemeMode.light;
    final formNotifier = ref.read(authFormProvider.notifier);

    return EdgeToEdgeWrapperWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Headtitle(widget: widget),
                        ThemeSwitch(
                          isLightMode: isLightMode,
                          themeMode: themeMode,
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    EmailField(
                      formState: formState,
                      onChanged: formNotifier.updateEmail,
                      Controller: emailController,
                    ),

                    SizedBox(height: 1.h),
                    PasswordForm(
                      formState: formState,
                      onChanged: formNotifier.updatePassword,
                      Controller: passwordController,
                    ),
                    widget.isSignUp
                        ? updatePasswordForm(
                          formState: formState,
                          onchanged: formNotifier.updateConfirmPassword,
                          controller: confirmPasswordController,
                          passwordController: passwordController.text,
                        )
                        : SizedBox(height: 1.5.h),

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
                                  onChanged: (bool? value) {},
                                ),
                                Text(
                                  'Remember Me',
                                  style: Theme.of(context).textTheme.labelMedium
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
                          formState.isLoading
                              ? null // disables button when loading
                              : () async {
                                if (widget.isSignUp) {
                                  await formNotifier.signUp(context);
                                } else {
                                  await formNotifier.login(context);
                                }
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
                          style: Theme.of(context).textTheme.displayMedium,
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
            if (formState.isLoading)
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

class updatePasswordForm extends ConsumerStatefulWidget {
  final AuthFormState formState;
  final ValueChanged<String> onchanged;
  final TextEditingController controller;
  final String passwordController;
  const updatePasswordForm({
    super.key,
    required this.formState,
    required this.onchanged,
    required this.controller,
    required this.passwordController,
  });

  @override
  ConsumerState<updatePasswordForm> createState() => _updatePasswordFormState();
}

class _updatePasswordFormState extends ConsumerState<updatePasswordForm> {
  bool PasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 1.h),
        Text(
          'Confirm Password',
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(fontSize: 12.sp),
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: widget.controller,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            errorText: widget.formState.confirmPasswordError,
            hintText: '8 characters minimum',
            hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
            filled: true,
            fillColor: AppColors.lightbox.withOpacity(0.2),

            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  PasswordVisible = !PasswordVisible;
                });
              },
              icon: Icon(
                PasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: AppColors.lightbox,
              ),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          ),
          obscureText: !PasswordVisible,
          onChanged: widget.onchanged,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please confirm your password';
            }
            if (value != widget.passwordController) {
              return 'Passwords do not match';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class PasswordForm extends ConsumerStatefulWidget {
  final AuthFormState formState;
  final ValueChanged<String> onChanged;
  final TextEditingController Controller;
  const PasswordForm({
    super.key,
    required this.formState,
    required this.onChanged,
    required this.Controller,
  });

  @override
  ConsumerState<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends ConsumerState<PasswordForm> {
  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter Your Password',
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(fontSize: 12.sp),
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: widget.Controller,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            errorText: widget.formState.passwordError,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              },
              icon: Icon(
                passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: AppColors.lightbox,
              ),
            ),
            hintText: '8 characters minimum',
            hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
            filled: true,
            fillColor: AppColors.lightbox.withOpacity(0.2),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          ),

          obscureText: !passwordVisible,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}

class EmailField extends StatelessWidget {
  final AuthFormState formState;
  final ValueChanged<String> onChanged;
  final TextEditingController Controller;
  const EmailField({
    super.key,
    required this.formState,
    required this.onChanged,
    required this.Controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your number & email address',
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(fontSize: 12.sp),
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: Controller,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),

          decoration: InputDecoration(
            hintText: 'yourName@gmail.com',
            hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
            filled: true,
            fillColor: AppColors.lightbox.withOpacity(0.2),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            errorText: formState.emailError,
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


