import 'package:flutter/material.dart';

/// Predefined text styles that map to [TextTheme].
abstract final class AppTextStyle {
  AppTextStyle._();

  static TextStyle _base({required double fontSize, FontWeight? fontWeight}) =>
      TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.w400,
        letterSpacing: -0.25,
      );

  static TextStyle get heading1 => _base(fontSize: 32, fontWeight: FontWeight.w700);
  static TextStyle get heading2 => _base(fontSize: 24, fontWeight: FontWeight.w600);
  static TextStyle get heading3 => _base(fontSize: 20, fontWeight: FontWeight.w600);
  static TextStyle get title => _base(fontSize: 18, fontWeight: FontWeight.w600);
  static TextStyle get body => _base(fontSize: 16);
  static TextStyle get bodySmall => _base(fontSize: 14);
  static TextStyle get caption => _base(fontSize: 12);
  static TextStyle get label => _base(fontSize: 14, fontWeight: FontWeight.w500);
}

/// Builds a [TextTheme] from [AppTextStyle] and [Color]s.
TextTheme buildAppTextTheme(Color onSurface, Color onSurfaceVariant) {
  return TextTheme(
    displayLarge: AppTextStyle.heading1.copyWith(color: onSurface),
    displayMedium: AppTextStyle.heading2.copyWith(color: onSurface),
    displaySmall: AppTextStyle.heading3.copyWith(color: onSurface),
    headlineMedium: AppTextStyle.title.copyWith(color: onSurface),
    bodyLarge: AppTextStyle.body.copyWith(color: onSurface),
    bodyMedium: AppTextStyle.bodySmall.copyWith(color: onSurface),
    bodySmall: AppTextStyle.caption.copyWith(color: onSurfaceVariant),
    labelLarge: AppTextStyle.label.copyWith(color: onSurface),
  );
}
