import 'package:flutter/material.dart';

import '../design_system/design_system.dart';

/// Standard card with consistent styling.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.elevation,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    final card = Card(
      elevation: elevation ?? 0,
      margin: margin ?? EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.allSm,
        side: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(Spacing.md),
        child: child,
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: AppRadius.allSm,
        child: card,
      );
    }

    return card;
  }
}
