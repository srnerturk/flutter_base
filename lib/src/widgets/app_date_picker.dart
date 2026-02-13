import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../design_system/design_system.dart';
import '../extensions/context_extensions.dart';

/// Adaptive date picker field.
///
/// Tapping opens [CupertinoDatePicker] in a bottom sheet on iOS
/// and [showDatePicker] on Android. Integrates with [Form] for validation.
class AppDatePicker extends StatelessWidget {
  const AppDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    this.firstDate,
    this.lastDate,
    this.label,
    this.hint,
    this.errorText,
    this.validator,
    this.dateFormat,
    this.enabled = true,
  });

  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? label;
  final String? hint;
  final String? errorText;
  final String? Function(DateTime?)? validator;

  /// Custom formatter for display. Defaults to dd/MM/yyyy.
  final String Function(DateTime)? dateFormat;
  final bool enabled;

  String _formatDate(DateTime date) {
    if (dateFormat != null) return dateFormat!(date);
    final d = date.day.toString().padLeft(2, '0');
    final m = date.month.toString().padLeft(2, '0');
    final y = date.year.toString();
    return '$d/$m/$y';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FormField<DateTime>(
      initialValue: selectedDate,
      validator: validator,
      builder: (field) {
        final effectiveError = field.errorText ?? errorText;

        return GestureDetector(
          onTap: enabled
              ? () => _showPicker(context, field)
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
              InputDecorator(
                decoration: InputDecoration(
                  hintText: hint ?? 'Select date',
                  errorText: effectiveError,
                  suffixIcon: const Icon(Icons.calendar_today, size: 20),
                  enabled: enabled,
                ),
                child: selectedDate != null
                    ? Text(
                        _formatDate(selectedDate!),
                        style: theme.textTheme.bodyLarge,
                      )
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showPicker(
      BuildContext context, FormFieldState<DateTime> field) async {
    final now = DateTime.now();
    final first = firstDate ?? DateTime(1900);
    final last = lastDate ?? DateTime(2100);
    final initial = selectedDate ?? now;

    if (context.isApplePlatform) {
      var picked = initial;
      await showCupertinoModalPopup<void>(
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
                      field.didChange(picked);
                      onDateSelected(picked);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: initial,
                  minimumDate: first,
                  maximumDate: last,
                  onDateTimeChanged: (date) => picked = date,
                ),
              ),
            ],
          ),
        ),
      );
      return;
    }

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: first,
      lastDate: last,
    );

    if (picked != null) {
      field.didChange(picked);
      onDateSelected(picked);
    }
  }
}
