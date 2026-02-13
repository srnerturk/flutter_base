import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../design_system/design_system.dart';
import '../extensions/context_extensions.dart';

/// Standard bottom sheet with drag handle and optional title.
///
/// Uses [showCupertinoModalPopup] on Apple platforms and
/// [showModalBottomSheet] on others.
class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    super.key,
    this.title,
    required this.child,
  });

  final String? title;
  final Widget child;

  /// Shows this bottom sheet using platform-adaptive presentation.
  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    required Widget child,
    bool isScrollControlled = true,
  }) {
    if (context.isApplePlatform) {
      return showCupertinoModalPopup<T>(
        context: context,
        builder: (_) => AppBottomSheet(title: title, child: child),
      );
    }

    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.md)),
      ),
      builder: (_) => AppBottomSheet(title: title, child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (context.isApplePlatform) {
      return _buildCupertino(context);
    }
    return _buildMaterial(context);
  }

  Widget _buildMaterial(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurfaceVariant
                    .withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            if (title != null) ...[
              const SizedBox(height: Spacing.md),
              Text(
                title!,
                style: theme.textTheme.titleMedium,
              ),
            ],
            const SizedBox(height: Spacing.md),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildCupertino(BuildContext context) {
    final theme = Theme.of(context);
    return CupertinoPopupSurface(
      child: Material(
        type: MaterialType.transparency,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(Spacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36,
                  height: 5,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurfaceVariant
                        .withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
                if (title != null) ...[
                  const SizedBox(height: Spacing.md),
                  Text(
                    title!,
                    style: theme.textTheme.headlineMedium,
                  ),
                ],
                const SizedBox(height: Spacing.md),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
