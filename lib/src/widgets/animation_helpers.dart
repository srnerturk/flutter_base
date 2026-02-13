import 'package:flutter/material.dart';

/// Standard animation durations.
abstract final class AnimationDurations {
  AnimationDurations._();

  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
}

/// Standard animation curves.
abstract final class AnimationCurves {
  AnimationCurves._();

  static const Curve standard = Curves.easeInOut;
  static const Curve enter = Curves.easeOut;
  static const Curve exit = Curves.easeIn;
}

/// Animated visibility wrapper that fades in/out its child.
class AnimatedVisibility extends StatelessWidget {
  const AnimatedVisibility({
    super.key,
    required this.visible,
    required this.child,
    this.duration,
    this.curve,
  });

  final bool visible;
  final Widget child;
  final Duration? duration;
  final Curve? curve;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: duration ?? AnimationDurations.normal,
      curve: curve ?? AnimationCurves.standard,
      child: visible ? child : const SizedBox.shrink(),
    );
  }
}
