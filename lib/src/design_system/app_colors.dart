import 'package:flutter/material.dart';

/// Semantic and raw color palette. Use these in theme; no hardcoded hex in app code.
abstract final class AppColors {
  AppColors._();

  // Primary
  static const Color primary = Color(0xFF2563EB);
  static const Color primaryContainer = Color(0xFFDBEAFE);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFF1E3A8A);

  // Secondary
  static const Color secondary = Color(0xFF64748B);
  static const Color secondaryContainer = Color(0xFFF1F5F9);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSecondaryContainer = Color(0xFF334155);

  // Surface & background
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceContainer = Color(0xFFF8FAFC);
  static const Color onSurface = Color(0xFF0F172A);
  static const Color onSurfaceVariant = Color(0xFF64748B);
  static const Color outline = Color(0xFFE2E8F0);
  static const Color outlineVariant = Color(0xFFCBD5E1);

  // Error & success
  static const Color error = Color(0xFFDC2626);
  static const Color errorContainer = Color(0xFFFEE2E2);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color onErrorContainer = Color(0xFF991B1B);
  static const Color success = Color(0xFF16A34A);
  static const Color onSuccess = Color(0xFFFFFFFF);

  // Dark theme overrides
  static const Color surfaceDark = Color(0xFF0F172A);
  static const Color surfaceContainerDark = Color(0xFF1E293B);
  static const Color onSurfaceDark = Color(0xFFF8FAFC);
  static const Color onSurfaceVariantDark = Color(0xFF94A3B8);
  static const Color outlineDark = Color(0xFF334155);
  static const Color outlineVariantDark = Color(0xFF475569);
  static const Color primaryDark = Color(0xFF93C5FD);
  static const Color primaryContainerDark = Color(0xFF1E3A8A);
  static const Color onPrimaryDark = Color(0xFF1E293B);
  static const Color onPrimaryContainerDark = Color(0xFFDBEAFE);
  static const Color onSecondaryContainerDark = Color(0xFFE2E8F0);
  static const Color errorDark = Color(0xFFFCA5A5);
  static const Color errorContainerDark = Color(0xFF7F1D1D);
  static const Color onErrorDark = Color(0xFF450A0A);
  static const Color onErrorContainerDark = Color(0xFFFEE2E2);
}
