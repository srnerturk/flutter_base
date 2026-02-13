import 'package:flutter/material.dart';

/// Border radius scale constants for the design system.
abstract final class AppRadius {
  AppRadius._();

  // Raw double values
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double full = 9999;

  // Pre-built BorderRadius (all corners, const)
  static const BorderRadius allXs = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius allSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius allMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius allLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius allFull = BorderRadius.all(Radius.circular(full));
}
