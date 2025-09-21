

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quicklo_app/Constants/color.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.dark,
  primaryColor: AppColors.darkbox,
  textTheme: TextTheme(
  titleLarge: GoogleFonts.poppins(
    fontSize:26.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.light,
    height: 1.5
  ),

  labelSmall: GoogleFonts.poppins(
    fontSize:12.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.lightbox
  ),

    labelMedium:  GoogleFonts.poppins(
    fontSize:16.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.light,
  ),
  
   displayMedium: GoogleFonts.poppins(
    fontSize:12.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.lightbox
  ),


  headlineLarge: GoogleFonts.poppins(
    fontSize: 25.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.light
  ),

  displaySmall: GoogleFonts.poppins(
    fontSize:15.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.lightbox
  ),

),

   colorScheme:ColorScheme.fromSeed(seedColor: AppColors.yellow),
   useMaterial3: true,
   brightness: Brightness.light
);




final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.light,
    primaryColor: AppColors.lightbox,
    textTheme: TextTheme(
  titleLarge: GoogleFonts.poppins(
    fontSize:26.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.dark,
    height: 1.5
  ),

  labelSmall: GoogleFonts.poppins(
    fontSize:12.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.lightbox
  ),

    labelMedium:  GoogleFonts.poppins(
    fontSize:16.sp,
    fontWeight: FontWeight.bold,
     color: AppColors.dark,
  ),

  headlineLarge: GoogleFonts.poppins(
    fontSize: 25.sp,
    fontWeight: FontWeight.w500,
     color: AppColors.dark,
  ),

  displaySmall: GoogleFonts.poppins(
    fontSize:15.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.lightbox
  ),
 displayMedium: GoogleFonts.poppins(
    fontSize:12.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.darkbox
  ),

),
    colorScheme:ColorScheme.fromSeed(seedColor: AppColors.yellow),
    useMaterial3: true,
     brightness: Brightness.light
);
