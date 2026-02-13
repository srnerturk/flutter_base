import 'package:flutter/material.dart';

import '../design_system/design_system.dart';

/// Badge overlay for notifications, counters, and status indicators.
///
/// Wraps a [child] widget with a positioned badge.
/// Shows a dot badge when no [label] is provided.
/// Animates show/hide with [AnimatedOpacity].
class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.child,
    this.label,
    this.show = true,
    this.backgroundColor,
    this.alignment = Alignment.topRight,
  });

  final Widget child;
  final String? label;
  final bool show;
  final Color? backgroundColor;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = backgroundColor ?? theme.colorScheme.error;
    final fgColor = theme.colorScheme.onError;

    final isDot = label == null;

    final badge = AnimatedOpacity(
      opacity: show ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: Container(
        padding: isDot
            ? EdgeInsets.zero
            : const EdgeInsets.symmetric(
                horizontal: Spacing.xs + 2,
                vertical: 1,
              ),
        constraints: BoxConstraints(
          minWidth: isDot ? 8 : 16,
          minHeight: isDot ? 8 : 16,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: isDot ? AppRadius.allXs : AppRadius.allSm,
        ),
        child: isDot
            ? null
            : Text(
                label!,
                style: TextStyle(
                  color: fgColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
      ),
    );

    // Calculate offset based on alignment
    final isTop = alignment.y <= 0;
    final isRight = alignment.x >= 0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: isTop ? -4 : null,
          bottom: isTop ? null : -4,
          right: isRight ? -4 : null,
          left: isRight ? null : -4,
          child: badge,
        ),
      ],
    );
  }
}
