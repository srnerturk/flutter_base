import 'package:flutter/material.dart';

import '../design_system/design_system.dart';

/// Snack bar variant type.
enum SnackBarVariant { success, error, warning, info }

/// Styled snack bar with success/error/warning/info variants.
abstract final class AppSnackBar {
  AppSnackBar._();

  static void show(
    BuildContext context, {
    required String message,
    SnackBarVariant variant = SnackBarVariant.info,
    Duration duration = const Duration(seconds: 4),
    SnackBarAction? action,
  }) {
    final theme = Theme.of(context);
    final (Color bg, Color fg, IconData icon) = switch (variant) {
      SnackBarVariant.success => (
          const Color(0xFF16A34A),
          Colors.white,
          Icons.check_circle_outline,
        ),
      SnackBarVariant.error => (
          theme.colorScheme.error,
          theme.colorScheme.onError,
          Icons.error_outline,
        ),
      SnackBarVariant.warning => (
          const Color(0xFFF59E0B),
          Colors.black87,
          Icons.warning_amber_outlined,
        ),
      SnackBarVariant.info => (
          theme.colorScheme.primary,
          theme.colorScheme.onPrimary,
          Icons.info_outline,
        ),
    };

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: bg,
        duration: duration,
        action: action,
        content: Row(
          children: [
            Icon(icon, color: fg, size: 20),
            const SizedBox(width: Spacing.sm),
            Expanded(
              child: Text(message, style: TextStyle(color: fg)),
            ),
          ],
        ),
      ),
    );
  }
}
