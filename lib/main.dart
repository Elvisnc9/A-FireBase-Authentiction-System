import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quicklo_app/Constants/color.dart';
import 'package:quicklo_app/Constants/theme.dart';
import 'package:quicklo_app/Pages/login.dart';
import 'package:quicklo_app/Pages/onboarding.dart';
import 'package:quicklo_app/Pages/signup.dart';
import 'package:quicklo_app/Services/google_auth.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    TheResponsiveBuilder(
      builder: (context, orientation, screenType) {
        return const MyApp();
      }
    ));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      title: 'Authentication System',
  
      routes: {
        '/Onboarding' : (context) => Onboarding(),
        '/LogIn' : (context) => LogInScreen(),
        '/SignUp' : (context) => SignUpScreen(),
      },
      home: StreamBuilder(
        stream: AuthService().authChanges
      , builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return  Center(child: CircularProgressIndicator(
            color:  AppColors.yellow ,
          ));
        }
        if(snapshot.hasData ){
          return const Onboarding();
        }else{
          return const SignUpScreen();
        }
      })    );
  }
}

 