import 'package:flutter/material.dart';

import '../design_system/design_system.dart';

/// Adaptive slider with optional value display.
///
/// Uses [Slider.adaptive] for platform-appropriate rendering.
/// Supports custom value formatting (e.g., currency, percentage).
class AppSlider extends StatelessWidget {
  const AppSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
    this.showValue = false,
    this.valueFormatter,
    this.enabled = true,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;
  final String? label;
  final bool showValue;

  /// Custom formatter for value display. Receives current value.
  final String Function(double)? valueFormatter;
  final bool enabled;

  String _formatValue(double val) {
    if (valueFormatter != null) return valueFormatter!(val);
    return val.toStringAsFixed(divisions != null ? 0 : 1);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null || showValue)
          Padding(
            padding: const EdgeInsets.only(bottom: Spacing.xs),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (label != null)
                  Text(label!, style: theme.textTheme.labelLarge),
                if (showValue)
                  Text(
                    _formatValue(value),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
        Slider.adaptive(
          value: value,
          onChanged: enabled ? onChanged : null,
          min: min,
          max: max,
          divisions: divisions,
          label: showValue ? _formatValue(value) : null,
        ),
      ],
    );
  }
}
