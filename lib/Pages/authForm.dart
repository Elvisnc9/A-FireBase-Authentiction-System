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
  
  const AuthForm({super.key,
   required this.isSignUp,
   });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool rememberMe = false;
  final formKey = GlobalKey<FormState>();
  String? emailError , passwordError, confirmPasswordError;


  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();



  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  String? emailValidator(String? value){
    if(value == null || value.isEmpty){
      return 'Email is Required';
      
    }

    }
    return null;
  }

  String? passwordValidator(String? value){
    if(value == null || value.isEmpty){
      return 'Password is required';
    }
    if(value.length < 8){
      return 'Password must be at least 8 Characters';
    }
    return null;
  }

  String? confirmPasswordValidator(String? value){
    if(value == null || value.isEmpty){
      return 'Confirm your Password';
    }
    if(value != passwordController.text){
      return 'Password Doesnt Match';
    }
    return null;
  }

  void onSignUp(){
    setState((){
      emailError = emailValidator(emailController.text);
      passwordError = passwordValidator(passwordController.text);
      confirmPasswordError = confirmPasswordValidator(confirmPasswordController.text);
    });

    if(formKey.currentState!.validate()){
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('SignUp Form is valid!')),
      );
    }
  }

 
 void  onLogin(){
  setState(() {
    emailError = emailValidator(emailController.text);
      passwordError = passwordValidator(passwordController.text);

  });
  if (formKey.currentState!.validate()){
     ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Form is valid!')),
      );
  }

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
            child: SizedBox(
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
                      validator: emailValidator,
                      onChanged: (value) {
                        setState(() {
                          emailError = emailValidator(value);
                        });
                      },
                    ),
                    
                    if (emailError !=null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        emailError!,
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    
                    
                    //PASSWORD
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
                              validator: confirmPasswordValidator,
                    onChanged: (val) {
                      setState(() {
                        confirmPasswordError = confirmPasswordValidator(val);
                      });
                    },
                  ),
                  if (confirmPasswordError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4, left: 4),
                      child: Text(
                        confirmPasswordError!,
                        style: const TextStyle(color: Colors.red, fontSize: 13),
                      ),
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
                   SubmitButton(push: (){
                    widget.isSignUp? onSignUp() : onLogin();
              
                   }, name: widget.isSignUp? 'Sign Up': 'Log In'),
                
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
        ),
      ),
    );
  }
}











/////////WIDGETS BELOW ARE FOR THE AUTH FORM

//PureForm is the main form that contains the email and password fields

// Title widget for the AuthPages


// Submit button widget that handles navigation based on the form type
