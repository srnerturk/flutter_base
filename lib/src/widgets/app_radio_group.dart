import 'package:flutter/material.dart';

import '../design_system/design_system.dart';

/// A radio option with value, label and optional description.
class AppRadioOption<T> {
  const AppRadioOption({
    required this.value,
    required this.label,
    this.description,
  });

  final T value;
  final String label;
  final String? description;
}

/// Adaptive radio button group.
///
/// Uses [Radio.adaptive] for platform-appropriate rendering.
/// Supports vertical and horizontal layouts.
class AppRadioGroup<T> extends StatelessWidget {
  const AppRadioGroup({
    super.key,
    required this.value,
    required this.onChanged,
    required this.options,
    this.label,
    this.direction = Axis.vertical,
    this.enabled = true,
  });

  final T? value;
  final ValueChanged<T?>? onChanged;
  final List<AppRadioOption<T>> options;
  final String? label;
  final Axis direction;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final radioWidgets = options.map((option) {
      return GestureDetector(
        onTap: enabled ? () => onChanged?.call(option.value) : null,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: direction == Axis.vertical
              ? const EdgeInsets.symmetric(vertical: Spacing.xs)
              : const EdgeInsets.only(right: Spacing.md),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<T>.adaptive(
                value: option.value,
                groupValue: value,
                onChanged: enabled ? onChanged : null,
              ),
              const SizedBox(width: Spacing.xs),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      option.label,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: enabled
                            ? theme.colorScheme.onSurface
                            : theme.colorScheme.onSurface
                                .withValues(alpha: 0.38),
                      ),
                    ),
                    if (option.description != null)
                      Text(
                        option.description!,
                        style: theme.textTheme.bodySmall,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(label!, style: theme.textTheme.labelLarge),
          const SizedBox(height: Spacing.sm),
        ],
        if (direction == Axis.vertical)
          ...radioWidgets
        else
          Wrap(children: radioWidgets),
      ],
    );
  }
}
