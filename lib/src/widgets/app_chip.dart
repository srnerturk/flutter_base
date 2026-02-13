import 'package:flutter/material.dart';

/// A styled chip that can be selectable and/or deletable.
class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onSelected,
    this.onDeleted,
    this.avatar,
  });

  final String label;
  final bool isSelected;
  final ValueChanged<bool>? onSelected;
  final VoidCallback? onDeleted;
  final Widget? avatar;

  @override
  Widget build(BuildContext context) {
    if (onSelected != null) {
      return FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: onSelected,
        avatar: avatar,
        onDeleted: onDeleted,
      );
    }

    return Chip(
      label: Text(label),
      avatar: avatar,
      onDeleted: onDeleted,
    );
  }
}
