import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:quicklo_app/Constants/color.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocalAuthentication auth  =  LocalAuthentication();
  bool isLoading = false;
  bool biometricAvailable = false ;

  @override
  void initState() {
    super.initState();
    _checkBiometericAvailability().then((_){
      _biometricAuthentication();
    });
  
  }

  
  
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(

        child: Padding(
          padding:  EdgeInsets.only(top: 20.h),
          child: Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 2,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: AppColors.mygradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Welcome to Home Screen',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize: 3.h,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
  
  Future<void> _checkBiometericAvailability() async {
    try {
      bool available = await auth.canCheckBiometrics;
    setState(() {
      biometricAvailable = available;
    });
      
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      
    }

  }



  Future<void> _biometricAuthentication() async {
    if(!biometricAvailable){
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      bool authenticate = await auth.authenticate(
        localizedReason: 'Use fingerprint to login faster next time?',
        options: AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true
        ));

        if(authenticate){
          return;
        }

    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
