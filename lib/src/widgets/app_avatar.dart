import 'package:flutter/material.dart';

/// Avatar widget with image, initials, or icon variants.
class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.icon,
    this.radius = 20,
    this.backgroundColor,
  });

  final String? imageUrl;
  final String? initials;
  final IconData? icon;
  final double radius;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = backgroundColor ?? theme.colorScheme.primaryContainer;
    final fg = theme.colorScheme.onPrimaryContainer;

    if (imageUrl != null) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(imageUrl!),
        backgroundColor: bg,
      );
    }

    if (initials != null) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: bg,
        child: Text(
          initials!.toUpperCase(),
          style: TextStyle(
            color: fg,
            fontSize: radius * 0.8,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: bg,
      child: Icon(icon ?? Icons.person, color: fg, size: radius),
    );
  }
}
