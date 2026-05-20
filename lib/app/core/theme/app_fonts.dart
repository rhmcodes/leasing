import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Centralized typography tokens for consistent text styling.
class AppFonts {
  const AppFonts._();

  static const String fontFamily = 'Inter';

  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semibold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  static TextStyle _base({
    required double fontSize,
    required FontWeight fontWeight,
    required double height,
    Color? color,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: 0,
      color: color ?? AppColors.textPrimary,
    );
  }

  static TextTheme get textTheme => GoogleFonts.interTextTheme().copyWith(
        displayLarge: title(),
        displayMedium: heroTitle(),
        displaySmall: screenTitle(),
        headlineLarge: screenTitle(),
        headlineMedium: sectionTitle(),
        headlineSmall: cardTitle(),
        titleLarge: sectionTitle(),
        titleMedium: headline(),
        titleSmall: bodySmallMedium(),
        bodyLarge: body(),
        bodyMedium: subtitle(),
        bodySmall: bodySmall(),
        labelLarge: headline(),
        labelMedium: captionMedium(),
        labelSmall: caption(),
      );

  // ---------------------------------------------------------------------------
  // Headings
  // ---------------------------------------------------------------------------
  static TextStyle title([Color? color]) =>
      _base(fontSize: 30, fontWeight: bold, height: 1.2, color: color);

  static TextStyle heroTitle([Color? color]) =>
      _base(fontSize: 26, fontWeight: semibold, height: 1.16, color: color);

  static TextStyle screenTitle([Color? color]) =>
      _base(fontSize: 21, fontWeight: semibold, height: 1.22, color: color);

  static TextStyle placeholderTitle([Color? color]) =>
      _base(fontSize: 20, fontWeight: regular, height: 1.32, color: color);

  static TextStyle sectionTitle([Color? color]) =>
      _base(fontSize: 18.5, fontWeight: semibold, height: 1.28, color: color);

  static TextStyle cardTitle([Color? color]) =>
      _base(fontSize: 17, fontWeight: semibold, height: 1.32, color: color);

  static TextStyle headline([Color? color]) =>
      _base(fontSize: 14.5, fontWeight: medium, height: 1.45, color: color);

  // ---------------------------------------------------------------------------
  // Body
  // ---------------------------------------------------------------------------
  static TextStyle body([Color? color]) =>
      _base(fontSize: 14.5, fontWeight: regular, height: 1.58, color: color);

  static TextStyle subtitle([Color? color]) => _base(
        fontSize: 14.5,
        fontWeight: regular,
        height: 1.58,
        color: color ?? AppColors.textSecondary,
      );

  static TextStyle bodySmall([Color? color]) => _base(
        fontSize: 13.5,
        fontWeight: regular,
        height: 1.5,
        color: color ?? AppColors.textSecondary,
      );

  static TextStyle bodySmallMedium([Color? color]) => _base(
        fontSize: 13.5,
        fontWeight: medium,
        height: 1.5,
        color: color ?? AppColors.textSecondary,
      );

  /// Auth screen supporting copy (login, forgot, verified, reset): 14 / 1.52.
  static TextStyle screenSubtitle([Color? color]) => _base(
        fontSize: 14,
        fontWeight: regular,
        height: 1.52,
        color: color ?? AppColors.textSecondary,
      );

  static TextStyle caption([Color? color]) => _base(
        fontSize: 12,
        fontWeight: regular,
        height: 1.35,
        color: color ?? AppColors.textMuted,
      );

  static TextStyle captionMedium([Color? color]) => _base(
        fontSize: 12,
        fontWeight: medium,
        height: 1.35,
        color: color ?? AppColors.textMuted,
      );

  static TextStyle labelStrong([Color? color]) => _base(
        fontSize: 11,
        fontWeight: semibold,
        height: 1.35,
        color: color ?? AppColors.textMuted,
      );

  static TextStyle metric([Color? color]) =>
      _base(fontSize: 26, fontWeight: bold, height: 1.14, color: color);
}
