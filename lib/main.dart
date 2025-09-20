import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicklo_app/Constants/theme.dart';
import 'package:quicklo_app/Pages/home.dart';
import 'package:quicklo_app/Pages/login.dart';
import 'package:quicklo_app/Pages/onboarding.dart';
import 'package:quicklo_app/Pages/signup.dart';
import 'package:quicklo_app/provider/theme_provider.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(
    ProviderScope(
      child: TheResponsiveBuilder(
        builder: (context, orientation, screenType) {
          return const MyApp();
        },
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final themeMode =ref.watch(themeProvider);

    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      title: 'Authentication System',

      routes: {
        '/Onboarding': (context) => Onboarding(),
        '/LogIn': (context) => LogInScreen(),
        '/SignUp': (context) => SignUpScreen(),
        '/Home': (context) => HomeScreen(),
      },
       initialRoute: '/Onboarding',
      // StreamBuilder(
      //   stream: AuthService().authChanges,
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(
      //         child: CircularProgressIndicator(color: AppColors.yellow),
      //       );
      //     }
      //     if (snapshot.hasData) {
      //       return const ;
      //     } else {
      //       return const LogInScreen();
      //     }
      //   },
      // ),
    );
  }
}
