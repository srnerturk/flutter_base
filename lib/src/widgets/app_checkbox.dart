import 'package:flutter/material.dart';

import '../design_system/design_system.dart';

/// Adaptive checkbox with optional tappable label.
///
/// Uses [Checkbox.adaptive] for platform-appropriate rendering.
/// Supports tristate for "select all" patterns.
class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.tristate = false,
    this.enabled = true,
  });

  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final String? label;
  final bool tristate;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final checkbox = Checkbox.adaptive(
      value: value,
      onChanged: enabled ? onChanged : null,
      tristate: tristate,
    );

    if (label == null) return checkbox;

    final theme = Theme.of(context);

    return GestureDetector(
      onTap: enabled
          ? () {
              if (tristate) {
                onChanged?.call(value == null
                    ? true
                    : value == true
                        ? false
                        : null);
              } else {
                onChanged?.call(!(value ?? false));
              }
            }
          : null,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Spacing.xs),
        child: Row(
          children: [
            checkbox,
            const SizedBox(width: Spacing.sm),
            Expanded(
              child: Text(
                label!,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: enabled
                      ? theme.colorScheme.onSurface
                      : theme.colorScheme.onSurface.withValues(alpha: 0.38),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
