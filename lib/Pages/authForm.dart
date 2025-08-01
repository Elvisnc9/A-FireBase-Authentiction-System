import 'package:flutter/material.dart';
import 'package:quicklo_app/Constants/color.dart';
import 'package:quicklo_app/Services/social_auth.dart';
import 'package:quicklo_app/Widget/divider.dart';
import 'package:quicklo_app/Widget/edge-to-edge.dart';
import 'package:quicklo_app/Widget/submitButton.dart';
import 'package:quicklo_app/Widget/title.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

class AuthForm extends StatefulWidget {
  final bool isSignUp;
  
  const AuthForm({super.key,
   required this.isSignUp,
   });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool rememberMe = false;

  String email = '', password = '', confirmPassword = '';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  registration(){
    
  }

  @override
  Widget build(BuildContext context) {
    return EdgeToEdgeWrapperWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.dark,
        body: SingleChildScrollView(
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
                Headtitle(widget: widget),

                SizedBox(height: 5.h),

                PureForm(),

                //ADD CONFIRM PASSWORD FIELD IF SIGN UP
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
                          decoration: InputDecoration(
                            hintText: '8 characters minimum',
                    hintStyle: TextStyle(
                     fontWeight: FontWeight.bold,
                     
                    ),
                            filled: true,
                  fillColor: AppColors.lightbox.withOpacity(0.2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          obscureText: true,
                        ),
                      ],
                    )
                    : SizedBox(height: 1.h,),

                    
               
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
                Submit(widget: widget),

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
                      widget.isSignUp? 'Already have an account?' : 'Don\'t have an account?',
                      style: Theme.of(
                        context,
                      ).textTheme.labelMedium?.copyWith(fontSize: 12.sp),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.isSignUp? Navigator.pushNamed(context, '/LogIn') :
                        Navigator.pushNamed(context, '/SignUp');
                      },
                      child: Text(
                        widget.isSignUp? 'Log In' : 'Create an account',
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











/////////WIDGETS BELOW ARE FOR THE AUTH FORM

//PureForm is the main form that contains the email and password fields
class PureForm extends StatelessWidget {
  const PureForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            hintText: 'angelia@yahoo.com',
            hintStyle: TextStyle(
             fontWeight: FontWeight.bold,
             
            ),
            filled: true,
          fillColor: AppColors.lightbox.withOpacity(0.2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
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
        
        // Password Field
        TextFormField(
                      
          decoration: InputDecoration(
            hintText: '8 characters minimum',
            hintStyle: TextStyle(
             fontWeight: FontWeight.bold,
             
            ),
           
          filled: true,
          fillColor: AppColors.lightbox.withOpacity(0.2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          obscureText: true,
        ),
      ],
    );
  }
}

// Title widget for the AuthPages


// Submit button widget that handles navigation based on the form type
class Submit extends StatelessWidget {
  const Submit({
    super.key,
    required this.widget,
  });

  final AuthForm widget;

  @override
  Widget build(BuildContext context) {
    return SubmitButton(name: widget.isSignUp? 'Sign Up' : 'Log In',
    
     push: () {
      widget.isSignUp
          ? Navigator.pushNamed(context, '/LogIn')
          : Navigator.pushNamed(context, '/Onboarding');
     });
  }
}


