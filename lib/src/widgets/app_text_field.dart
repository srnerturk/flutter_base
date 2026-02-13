import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../design_system/design_system.dart';
import '../extensions/context_extensions.dart';

/// Styled text field with optional error text and validator hook.
///
/// Renders [CupertinoTextField] on Apple platforms and
/// [TextFormField] on others. Both variants integrate with [Form]
/// for validation.
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.enabled = true,
    this.maxLines = 1,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String?)? validator;
  final bool enabled;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    if (context.isApplePlatform) {
      return _buildCupertino(context);
    }
    return _buildMaterial();
  }

  Widget _buildMaterial() {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        errorText: errorText,
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      validator: validator,
      enabled: enabled,
      maxLines: maxLines,
    );
  }

  Widget _buildCupertino(BuildContext context) {
    return FormField<String>(
      initialValue: controller?.text ?? '',
      validator: validator,
      builder: (FormFieldState<String> field) {
        final effectiveError = field.errorText ?? errorText;

        final theme = Theme.of(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (label != null)
              Padding(
                padding: const EdgeInsets.only(bottom: Spacing.xs),
                child: Text(
                  label!,
                  style: theme.textTheme.labelLarge,
                ),
              ),
            CupertinoTextField(
              controller: controller,
              placeholder: hint,
              obscureText: obscureText,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              onChanged: (value) {
                field.didChange(value);
                onChanged?.call(value);
              },
              onSubmitted: onSubmitted,
              enabled: enabled,
              maxLines: maxLines,
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
        );
      },
    );
  }
}
