import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../design_system/design_system.dart';
import '../extensions/context_extensions.dart';

/// Standard app dialog with title, content, and actions.
///
/// Uses [AlertDialog.adaptive] which renders [CupertinoAlertDialog]
/// on Apple platforms and [AlertDialog] on others.
class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.title,
    this.content,
    this.confirmLabel = 'OK',
    this.cancelLabel = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.customContent,
  });

  final String title;
  final String? content;
  final String confirmLabel;
  final String cancelLabel;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final Widget? customContent;

  /// Shows this dialog using [showAdaptiveDialog].
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    String? content,
    String confirmLabel = 'OK',
    String cancelLabel = 'Cancel',
    Widget? customContent,
  }) {
    return showAdaptiveDialog<bool>(
      context: context,
      builder: (_) => AppDialog(
        title: title,
        content: content,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        customContent: customContent,
        onConfirm: () => Navigator.of(context).pop(true),
        onCancel: () => Navigator.of(context).pop(false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isApple = context.isApplePlatform;

    return AlertDialog.adaptive(
      title: Text(title),
      content: customContent ?? (content != null ? Text(content!) : null),
      actions: isApple
          ? [
              CupertinoDialogAction(
                onPressed:
                    onCancel ?? () => Navigator.of(context).pop(false),
                child: Text(cancelLabel),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed:
                    onConfirm ?? () => Navigator.of(context).pop(true),
                child: Text(confirmLabel),
              ),
            ]
          : [
              TextButton(
                onPressed:
                    onCancel ?? () => Navigator.of(context).pop(false),
                child: Text(cancelLabel),
              ),
              FilledButton(
                onPressed:
                    onConfirm ?? () => Navigator.of(context).pop(true),
                child: Text(confirmLabel),
              ),
            ],
      actionsPadding: const EdgeInsets.all(Spacing.md),
    );
  }
}
