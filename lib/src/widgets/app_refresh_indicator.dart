import 'package:flutter/material.dart';

/// Adaptive pull-to-refresh wrapper.
///
/// Uses [RefreshIndicator.adaptive] for platform-appropriate rendering.
class AppRefreshIndicator extends StatelessWidget {
  const AppRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
    this.color,
  });

  final Future<void> Function() onRefresh;
  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: onRefresh,
      color: color ?? Theme.of(context).colorScheme.primary,
      child: child,
    );
  }
}
