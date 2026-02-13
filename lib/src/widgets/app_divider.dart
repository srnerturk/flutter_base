import 'package:flutter/material.dart';

import '../design_system/design_system.dart';

/// Design-system-consistent divider with optional center label.
///
/// Supports horizontal and vertical orientations.
/// When [label] is provided, renders a line–text–line divider.
class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    this.height,
    this.vertical = false,
    this.margin,
    this.color,
    this.thickness = 1,
    this.label,
  });

  /// Total height (horizontal) or width (vertical) including margin.
  final double? height;
  final bool vertical;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final double thickness;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dividerColor = color ?? theme.colorScheme.outlineVariant;

    if (vertical) {
      return Container(
        margin: margin,
        width: thickness,
        height: height ?? 24,
        color: dividerColor,
      );
    }

    if (label != null) {
      return Padding(
        padding: margin ?? const EdgeInsets.symmetric(vertical: Spacing.md),
        child: Row(
          children: [
            Expanded(child: Divider(color: dividerColor, thickness: thickness)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
              child: Text(
                label!,
                style: theme.textTheme.bodySmall,
              ),
            ),
            Expanded(child: Divider(color: dividerColor, thickness: thickness)),
          ],
        ),
      );
    }

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Divider(
        height: height ?? 1,
        color: dividerColor,
        thickness: thickness,
      ),
    );
  }
}
