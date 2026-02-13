import 'package:flutter/material.dart';

import '../design_system/design_system.dart';

/// Semantic variant for [AppTag].
enum TagVariant { success, error, warning, info, neutral }

/// Non-interactive status label with semantic color variants.
///
/// Unlike [AppChip], this is a read-only label for status indication
/// (e.g., "New", "Sale", "Premium", "Draft").
class AppTag extends StatelessWidget {
  const AppTag({
    super.key,
    required this.label,
    this.variant = TagVariant.neutral,
    this.small = false,
    this.icon,
  });

  final String label;
  final TagVariant variant;
  final bool small;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = _resolveColors(theme);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? Spacing.xs + 2 : Spacing.sm,
        vertical: small ? 2 : Spacing.xs,
      ),
      decoration: BoxDecoration(
        color: colors.$1,
        borderRadius: small ? AppRadius.allXs : AppRadius.allSm,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: small ? 10 : 14, color: colors.$2),
            SizedBox(width: small ? 2 : Spacing.xs),
          ],
          Text(
            label,
            style: TextStyle(
              color: colors.$2,
              fontSize: small ? 10 : 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  (Color background, Color foreground) _resolveColors(ThemeData theme) {
    switch (variant) {
      case TagVariant.success:
        return (const Color(0xFF16A34A).withValues(alpha: 0.12), const Color(0xFF16A34A));
      case TagVariant.error:
        return (theme.colorScheme.error.withValues(alpha: 0.12), theme.colorScheme.error);
      case TagVariant.warning:
        return (const Color(0xFFF59E0B).withValues(alpha: 0.12), const Color(0xFFB45309));
      case TagVariant.info:
        return (theme.colorScheme.primary.withValues(alpha: 0.12), theme.colorScheme.primary);
      case TagVariant.neutral:
        return (
          theme.colorScheme.onSurface.withValues(alpha: 0.08),
          theme.colorScheme.onSurfaceVariant,
        );
    }
  }
}
