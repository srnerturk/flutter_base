import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../design_system/design_system.dart';
import '../extensions/context_extensions.dart';

/// Primary action button with optional loading state.
///
/// Renders [CupertinoButton.filled] on Apple platforms and
/// [ElevatedButton] on others.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.isLoading = false,
    this.icon,
  });

  final VoidCallback? onPressed;
  final String label;
  final bool isLoading;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final isApple = context.isApplePlatform;

    final child = isLoading
        ? SizedBox(
            height: 24,
            width: 24,
            child: isApple
                ? const CupertinoActivityIndicator(
                    color: CupertinoColors.white,
                  )
                : const CircularProgressIndicator(strokeWidth: 2),
          )
        : icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon!,
                  const SizedBox(width: Spacing.sm),
                  Text(label),
                ],
              )
            : Text(label);

    if (isApple) {
      return SizedBox(
        width: double.infinity,
        child: CupertinoButton.filled(
          onPressed: isLoading ? null : onPressed,
          child: child,
        ),
      );
    }

    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: child,
      ),
    );
  }
}
