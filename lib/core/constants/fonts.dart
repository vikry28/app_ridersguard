import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class AppFonts {
  static TextStyle get defaultFont => GoogleFonts.poppins();

  static TextStyle get headingFont => GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: 24.sp,
      );

  static TextStyle get bodyFont => GoogleFonts.poppins(
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
      );

  static TextStyle get captionFont => GoogleFonts.poppins(
        fontWeight: FontWeight.w300,
        fontSize: 12.sp,
      );

  static TextStyle get buttonFont => GoogleFonts.poppins(
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
      );
  static TextStyle get subtitleFont => GoogleFonts.poppins(
        fontWeight: FontWeight.w400,
        fontSize: 18.sp,
      );
  static TextStyle get overlineFont => GoogleFonts.poppins(
        fontWeight: FontWeight.w300,
        fontSize: 10.sp,
      );
  static TextStyle get titleFont => GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: 20.sp,
      );
  static TextStyle get displayFont => GoogleFonts.poppins(
        fontWeight: FontWeight.w700,
        fontSize: 32.sp,
      );
  static TextStyle get smallFont => GoogleFonts.poppins(
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
      );
  static TextStyle get largeFont => GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: 28.sp,
      );
  static TextStyle get extraLargeFont => GoogleFonts.poppins(
        fontWeight: FontWeight.w700,
        fontSize: 36.sp,
      );
  static TextStyle get extraSmallFont => GoogleFonts.poppins(
        fontWeight: FontWeight.w300,
        fontSize: 8.sp,
      );
}
