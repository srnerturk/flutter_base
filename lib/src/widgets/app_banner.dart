import 'package:flutter/material.dart';

import '../design_system/design_system.dart';

/// Semantic variant for [AppBanner].
enum BannerVariant { success, error, warning, info }

/// Persistent banner for informational or warning messages.
///
/// Displays at the top of content with semantic color variants
/// and optional action and dismiss button.
class AppBanner extends StatelessWidget {
  const AppBanner({
    super.key,
    required this.message,
    this.variant = BannerVariant.info,
    this.action,
    this.onDismiss,
  });

  final String message;
  final BannerVariant variant;
  final Widget? action;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = _resolveColors(theme);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.md,
        vertical: Spacing.sm + Spacing.xs,
      ),
      decoration: BoxDecoration(
        color: colors.$1,
        borderRadius: AppRadius.allSm,
      ),
      child: Row(
        children: [
          Icon(_resolveIcon(), size: 20, color: colors.$2),
          const SizedBox(width: Spacing.sm),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.$2,
              ),
            ),
          ),
          if (action != null) ...[
            const SizedBox(width: Spacing.sm),
            action!,
          ],
          if (onDismiss != null) ...[
            const SizedBox(width: Spacing.xs),
            GestureDetector(
              onTap: onDismiss,
              child: Icon(Icons.close, size: 18, color: colors.$2),
            ),
          ],
        ],
      ),
    );
  }

  IconData _resolveIcon() {
    switch (variant) {
      case BannerVariant.success:
        return Icons.check_circle_outline;
      case BannerVariant.error:
        return Icons.error_outline;
      case BannerVariant.warning:
        return Icons.warning_amber_rounded;
      case BannerVariant.info:
        return Icons.info_outline;
    }
  }

  (Color background, Color foreground) _resolveColors(ThemeData theme) {
    switch (variant) {
      case BannerVariant.success:
        return (const Color(0xFF16A34A).withValues(alpha: 0.12), const Color(0xFF16A34A));
      case BannerVariant.error:
        return (theme.colorScheme.error.withValues(alpha: 0.12), theme.colorScheme.error);
      case BannerVariant.warning:
        return (const Color(0xFFF59E0B).withValues(alpha: 0.12), const Color(0xFFB45309));
      case BannerVariant.info:
        return (theme.colorScheme.primary.withValues(alpha: 0.12), theme.colorScheme.primary);
    }
  }
}
