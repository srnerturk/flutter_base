import 'package:flutter/material.dart';

import '../design_system/design_system.dart';

/// Linear progress bar with optional label and percentage display.
///
/// Wraps [LinearProgressIndicator] with design system tokens.
class AppProgressBar extends StatelessWidget {
  const AppProgressBar({
    super.key,
    required this.value,
    this.label,
    this.showPercentage = false,
    this.color,
    this.height = 8,
  });

  /// Progress value between 0.0 and 1.0.
  final double value;
  final String? label;
  final bool showPercentage;
  final Color? color;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasHeader = label != null || showPercentage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hasHeader)
          Padding(
            padding: const EdgeInsets.only(bottom: Spacing.xs),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (label != null)
                  Text(label!, style: theme.textTheme.labelLarge),
                if (showPercentage)
                  Text(
                    '${(value * 100).round()}%',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
        ClipRRect(
          borderRadius: BorderRadius.circular(height / 2),
          child: LinearProgressIndicator(
            value: value.clamp(0.0, 1.0),
            minHeight: height,
            color: color,
            backgroundColor:
                theme.colorScheme.onSurface.withValues(alpha: 0.08),
          ),
        ),
      ],
    );
  }
}
