import 'package:flutter/material.dart';

import '../design_system/design_system.dart';

/// Adaptive switch with optional label and subtitle.
///
/// Uses [Switch.adaptive] to render platform-appropriate switch.
/// The entire row is tappable when a label is provided.
class AppSwitch extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.subtitle,
    this.enabled = true,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final String? subtitle;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final switchWidget = Switch.adaptive(
      value: value,
      onChanged: enabled ? onChanged : null,
    );

    if (label == null) return switchWidget;

    final theme = Theme.of(context);

    return GestureDetector(
      onTap: enabled ? () => onChanged?.call(!value) : null,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Spacing.sm),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label!,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: enabled
                          ? theme.colorScheme.onSurface
                          : theme.colorScheme.onSurface.withValues(alpha: 0.38),
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: Spacing.xs),
                    Text(
                      subtitle!,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: Spacing.md),
            switchWidget,
          ],
        ),
      ),
    );
  }
}
