import 'package:flutter/material.dart';

/// Centered loading indicator. Use in place of content while loading.
///
/// Uses [CircularProgressIndicator.adaptive] which renders
/// [CupertinoActivityIndicator] on Apple platforms and
/// [CircularProgressIndicator] on others.
class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key, this.size = 32});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: const CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
