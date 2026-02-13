import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../design_system/design_system.dart';
import '../extensions/context_extensions.dart';

/// A segment option with value and label.
class AppSegment<T> {
  const AppSegment({required this.value, required this.label, this.icon});

  final T value;
  final String label;
  final IconData? icon;
}

/// Adaptive segmented control for tab-like selection (2-5 options).
///
/// Uses [CupertinoSlidingSegmentedControl] on iOS and [SegmentedButton] on Android.
class AppSegmentedControl<T extends Object> extends StatelessWidget {
  const AppSegmentedControl({
    super.key,
    required this.value,
    required this.onChanged,
    required this.segments,
    this.enabled = true,
  });

  final T value;
  final ValueChanged<T> onChanged;
  final List<AppSegment<T>> segments;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (context.isApplePlatform) {
      return _buildCupertino();
    }
    return _buildMaterial();
  }

  Widget _buildMaterial() {
    return SegmentedButton<T>(
      segments: segments
          .map((s) => ButtonSegment<T>(
                value: s.value,
                label: Text(s.label),
                icon: s.icon != null ? Icon(s.icon) : null,
              ))
          .toList(),
      selected: {value},
      onSelectionChanged: enabled
          ? (Set<T> selected) => onChanged(selected.first)
          : null,
    );
  }

  Widget _buildCupertino() {
    return CupertinoSlidingSegmentedControl<T>(
      groupValue: value,
      onValueChanged: (val) {
        if (enabled && val != null) onChanged(val);
      },
      children: {
        for (final s in segments)
          s.value: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.sm, vertical: Spacing.xs),
            child: s.icon != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(s.icon, size: 16),
                      const SizedBox(width: Spacing.xs),
                      Text(s.label),
                    ],
                  )
                : Text(s.label),
          ),
      },
    );
  }
}
