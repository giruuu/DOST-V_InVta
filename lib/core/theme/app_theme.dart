import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Add this import

class AppTheme {
  static const Color primaryBlue = Color(0xFF00AEEF);
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color cardWhite = Colors.white;
  static const Color textDark = Color(0xFF2D2D2D);
  static const Color textLightGray = Color(0xFF8E8E93);
  static const Color alertRed = Color(0xFFFF3B30);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundLight,
      primaryColor: primaryBlue,

      // Apply Poppins with responsive font sizes (.sp)
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        displayLarge: GoogleFonts.poppins(
          color: textDark,
          fontWeight: FontWeight.bold,
          fontSize: 32.sp, // Responsive font size
        ),
        titleLarge: GoogleFonts.poppins(
          color: primaryBlue,
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
        ),
        bodyLarge: GoogleFonts.poppins(
          color: textDark,
          fontSize: 16.sp,
        ),
        bodyMedium: GoogleFonts.poppins(
          color: textLightGray,
          fontSize: 14.sp,
        ),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: backgroundLight,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: primaryBlue),
        titleTextStyle: GoogleFonts.poppins(
          color: primaryBlue,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r), // Responsive radius
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          textStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
      ),

      cardTheme: CardThemeData(
        color: cardWhite,
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r), // Responsive radius
        ),
      ),
    );
  }
}