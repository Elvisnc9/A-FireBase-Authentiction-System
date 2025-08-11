// ignore_for_file: no_logic_in_create_state

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quicklo_app/Constants/color.dart';
import 'package:quicklo_app/Services/authMethod.dart';
import 'package:quicklo_app/Services/social_auth.dart';
import 'package:quicklo_app/Widget/divider.dart';
import 'package:quicklo_app/Widget/edge-to-edge.dart';
import 'package:quicklo_app/Widget/submitButton.dart';
import 'package:quicklo_app/Widget/title.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

class AuthForm extends StatefulWidget {
  final bool isSignUp;

  const AuthForm({super.key, required this.isSignUp});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool rememberMe = false;
  final formKey = GlobalKey<FormState>();
  String? emailError, passwordError, confirmPasswordError;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
      
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }




  Future<void> onSignUp() async {
    setState(() {
      emailError = emailValidator(emailController.text);
      passwordError = passwordValidator(passwordController.text);
      confirmPasswordError = confirmPasswordValidator(confirmPasswordController.text);
    });

    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await authMethod.value.createAccount(
          email: emailController.text.trim(),
          password: passwordController.text,
        );
        // On success, navigate or show success UI
        // For now, clear errors
        setState(() {
          
          emailError = null;
          passwordError = null;
          confirmPasswordError = null;
        });
        Navigator.pushReplacementNamed(context, '/LogIn');
      } on FirebaseAuthException catch (e) {
        setState(() {
          switch (e.code) {
            case 'email-already-in-use':
            case 'invalid-email':
              emailError = e.message;
              break;
            case 'weak-password':
              passwordError = e.message;
              break;
            default:
              // General error (show on password field for simplicity)
              passwordError = e.message;
          }
        });
      } catch (e) {
        setState(() {
          passwordError = 'An unexpected error occurred';
        });
      }
    }
    setState(() {
      isLoading = false;
    });
  }





  Future<void> onLogin() async {
    setState(() {
      emailError = emailValidator(emailController.text);
      passwordError = passwordValidator(passwordController.text);
     
    });

    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await authMethod.value.signIn(
          email: emailController.text.trim(),
          password: passwordController.text,
        );
        setState(() {
          emailError = null;
          passwordError = null;
        });
        Navigator.pushReplacementNamed(context, '/Home');
      } on FirebaseAuthException catch (e) {
        setState(() {
          switch (e.code) {
            case 'user-not-found':
            case 'invalid-email':
              emailError = e.message;
              break;
            case 'wrong-password':
              passwordError = e.message;
              break;
            default:
              passwordError = e.message;
          }
        });
      } catch (e) {
        setState(() {
          passwordError = 'An unexpected error occurred';
        });
      }
    }
    setState(() {
      isLoading = false;
    });
  }




  @override
  Widget build(BuildContext context) {
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
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Headtitle(widget: widget),
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
                        style: TextStyle(
                          color : Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                        controller: emailController,
                        decoration: InputDecoration(
                          
                          hintText: 'yourName@gmail.com',
                          hintStyle: TextStyle(fontWeight: FontWeight.bold),
                          filled: true,
                          fillColor: AppColors.lightbox.withOpacity(0.2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        
                        validator: emailValidator,
                        onChanged: (value) {
                          setState(() {
                            emailError = emailValidator(value);
                          });
                        },
                      ),
                     
                      SizedBox(height: 1.h),
            
                      
                      Text(
                        'Enter Your Password',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              fontSize: 12.sp,
                              color: AppColors.grey,
                            ),
                      ),
                      SizedBox(height: 1.h),
                      TextFormField(
                        controller: passwordController,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                        decoration: InputDecoration(
                          hintText: '8 characters minimum',
                          hintStyle: TextStyle(fontWeight: FontWeight.bold),
                          filled: true,
                          fillColor: AppColors.lightbox.withOpacity(0.2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        obscureText: true,
                        validator: passwordValidator,
                        onChanged: (value) {
                          setState(() {
                            passwordError = passwordValidator(value);
                          });
                        },
                      ),
                      if (passwordError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4, left: 4),
                          child: Text(
                            passwordError!,
                            style: const TextStyle(color: Colors.red, fontSize: 13),
                          ),
                        ),
                      widget.isSignUp
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 1.h),
                                Text(
                                  'Confirm Password',
                                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                        fontSize: 12.sp,
                                        color: AppColors.grey,
                                      ),
                                ),
                                SizedBox(height: 1.h),
                                TextFormField(
                                  controller: confirmPasswordController,
                                  style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                                  decoration: InputDecoration(
                                    hintText: '8 characters minimum',
                                    hintStyle: TextStyle(fontWeight: FontWeight.bold),
                                    filled: true,
                                    fillColor: AppColors.lightbox.withOpacity(0.2),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  obscureText: true,
                                  validator: confirmPasswordValidator,
                                  onChanged: (val) {
                                    setState(() {
                                      confirmPasswordError = confirmPasswordValidator(val);
                                    });
                                  },
                                ),
                               
                              ],
                            )
                          : SizedBox(height: 1.h),
            
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
                         SubmitButton(
                      push: isLoading
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
              ),
              if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(child: CircularProgressIndicator()),)
          ],
        ),
        ),
    );
  }
}











/////////WIDGETS BELOW ARE FOR THE AUTH FORM

//PureForm is the main form that contains the email and password fields

// Title widget for the AuthPages


// Submit button widget that handles navigation based on the form type
