import 'package:flutter/material.dart';

import '../design_system/design_system.dart';

/// Section header for list groups (e.g., "Personal Info", "Notifications").
///
/// Displays a title with optional trailing action (e.g., "See All") and divider.
class AppSectionHeader extends StatelessWidget {
  const AppSectionHeader({
    super.key,
    required this.title,
    this.trailing,
    this.padding,
    this.showDivider = false,
  });

  final String title;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showDivider)
          Divider(
            height: 1,
            color: theme.colorScheme.outlineVariant,
          ),
        Padding(
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: Spacing.md,
                vertical: Spacing.sm,
              ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title.toUpperCase(),
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ],
    );
  }
}
