

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quicklo_app/Constants/color.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.dark,
  primaryColor: AppColors.darkbox,
  textTheme: myTextTheme
);


final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.light,
    primaryColor: AppColors.lightbox,
    textTheme: myTextTheme
);



final TextTheme myTextTheme = TextTheme(
  titleLarge: GoogleFonts.poppins(
    fontSize:26.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
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
    color: AppColors.light
  ),

  headlineLarge: GoogleFonts.poppins(
    fontSize: 25.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.light
  )

);

