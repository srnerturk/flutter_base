import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';

/// Visual variant for [AppIconButton].
enum IconButtonVariant { standard, filled, outlined, tonal }

/// Adaptive icon button with Material 3 variants.
///
/// Uses [CupertinoButton] on Apple platforms and Material [IconButton]
/// variants on others. Tooltip is encouraged for accessibility.
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.variant = IconButtonVariant.standard,
    this.size,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final IconButtonVariant variant;
  final double? size;

  @override
  Widget build(BuildContext context) {
    if (context.isApplePlatform) {
      return _buildCupertino(context);
    }
    return _buildMaterial();
  }

  Widget _buildMaterial() {
    final iconWidget = Icon(icon, size: size);

    Widget button;
    switch (variant) {
      case IconButtonVariant.filled:
        button = IconButton.filled(
          icon: iconWidget,
          onPressed: onPressed,
          tooltip: tooltip,
        );
      case IconButtonVariant.outlined:
        button = IconButton.outlined(
          icon: iconWidget,
          onPressed: onPressed,
          tooltip: tooltip,
        );
      case IconButtonVariant.tonal:
        button = IconButton.filledTonal(
          icon: iconWidget,
          onPressed: onPressed,
          tooltip: tooltip,
        );
      case IconButtonVariant.standard:
        button = IconButton(
          icon: iconWidget,
          onPressed: onPressed,
          tooltip: tooltip,
        );
    }

    return button;
  }

  Widget _buildCupertino(BuildContext context) {
    final theme = Theme.of(context);

    Widget button = CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Icon(
        icon,
        size: size ?? 24,
        color: onPressed != null
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurface.withValues(alpha: 0.38),
      ),
    );

    if (tooltip != null) {
      button = Tooltip(message: tooltip!, child: button);
    }

    return button;
  }
}
