import 'package:flutter/material.dart';
import 'package:quicklo_app/Constants/color.dart';
import 'package:quicklo_app/Widget/edge-to-edge.dart';
import 'package:quicklo_app/Widget/submitButton.dart';
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
                Title(widget: widget),

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
class Title extends StatelessWidget {
  const Title({
    super.key,
    required this.widget,
  });

  final AuthForm widget;

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.isSignUp? 'Create your account' : 'Login to your account',
      textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }
}


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


// Divider widget to separate the social authentication buttons
class Dividerz extends StatelessWidget {
  const Dividerz({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}


// Social authentication buttons
class SocialAuthentications extends StatelessWidget {
  const SocialAuthentications({
    super.key,
    required this.widget,
  });

  final AuthForm widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Socials(
          image: 'assets/Icons/google.png',
          name: widget.isSignUp? 'Sign Up with Google' : 'Log In with Google',
        ),
        Socials(
          image: 'assets/Icons/facebook.png',
          name: widget.isSignUp? 'Sign Up with Facebook' : 'Log In with Facebook',
        ),
      ],
    );
  }
}


// Socials widget to display individual social authentication buttons
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
