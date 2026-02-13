import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../design_system/design_system.dart';
import '../extensions/context_extensions.dart';

/// A dropdown item with a value and display label.
class AppDropdownItem<T> {
  const AppDropdownItem({required this.value, required this.label});

  final T value;
  final String label;
}

/// Adaptive dropdown selector.
///
/// On Android, renders [DropdownButtonFormField].
/// On iOS, opens a [CupertinoPicker] in a bottom sheet.
/// Supports form validation and integrates with [Form].
class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.label,
    this.hint,
    this.errorText,
    this.validator,
    this.enabled = true,
  });

  final T? value;
  final List<AppDropdownItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final String? hint;
  final String? errorText;
  final String? Function(T?)? validator;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (context.isApplePlatform) {
      return _buildCupertino(context);
    }
    return _buildMaterial(context);
  }

  Widget _buildMaterial(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        errorText: errorText,
      ),
      items: items
          .map((item) => DropdownMenuItem<T>(
                value: item.value,
                child: Text(item.label),
              ))
          .toList(),
      onChanged: enabled ? onChanged : null,
      validator: validator,
    );
  }

  Widget _buildCupertino(BuildContext context) {
    final theme = Theme.of(context);
    final selectedLabel =
        items.where((i) => i.value == value).map((i) => i.label).firstOrNull;

    return FormField<T>(
      initialValue: value,
      validator: validator,
      builder: (field) {
        final effectiveError = field.errorText ?? errorText;

        return GestureDetector(
          onTap: enabled
              ? () => _showCupertinoPicker(context, field)
              : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (label != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: Spacing.xs),
                  child: Text(label!, style: theme.textTheme.labelLarge),
                ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.md,
                  vertical: Spacing.md,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: effectiveError != null
                        ? theme.colorScheme.error
                        : theme.colorScheme.outline,
                  ),
                  borderRadius: AppRadius.allSm,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        selectedLabel ?? hint ?? '',
                        style: selectedLabel != null
                            ? theme.textTheme.bodyLarge
                            : theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                      ),
                    ),
                    Icon(
                      CupertinoIcons.chevron_down,
                      size: 16,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
              if (effectiveError != null)
                Padding(
                  padding: const EdgeInsets.only(top: Spacing.xs),
                  child: Text(
                    effectiveError,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _showCupertinoPicker(BuildContext context, FormFieldState<T> field) {
    final initialIndex =
        items.indexWhere((i) => i.value == value).clamp(0, items.length - 1);
    var selectedIndex = initialIndex;

    showCupertinoModalPopup<void>(
      context: context,
      builder: (_) => Container(
        height: 260,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.pop(context),
                ),
                CupertinoButton(
                  child: const Text('Done'),
                  onPressed: () {
                    final selected = items[selectedIndex].value;
                    field.didChange(selected);
                    onChanged?.call(selected);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Expanded(
              child: CupertinoPicker(
                itemExtent: 36,
                scrollController:
                    FixedExtentScrollController(initialItem: initialIndex),
                onSelectedItemChanged: (index) => selectedIndex = index,
                children: items
                    .map((item) => Center(child: Text(item.label)))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
