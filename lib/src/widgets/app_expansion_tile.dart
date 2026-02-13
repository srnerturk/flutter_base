import 'package:flutter/material.dart';

import '../design_system/design_system.dart';

/// Collapsible tile for FAQ sections, settings groups, and expandable content.
///
/// Wraps [ExpansionTile] with design system tokens.
class AppExpansionTile extends StatelessWidget {
  const AppExpansionTile({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.leading,
    this.initiallyExpanded = false,
  });

  final String title;
  final Widget child;
  final String? subtitle;
  final Widget? leading;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ExpansionTile(
      title: Text(title, style: theme.textTheme.bodyLarge),
      subtitle: subtitle != null
          ? Text(subtitle!, style: theme.textTheme.bodySmall)
          : null,
      leading: leading,
      initiallyExpanded: initiallyExpanded,
      shape: const Border(),
      collapsedShape: const Border(),
      childrenPadding: const EdgeInsets.only(
        left: Spacing.md,
        right: Spacing.md,
        bottom: Spacing.md,
      ),
      children: [child],
    );
  }
}
