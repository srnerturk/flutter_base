import 'package:flutter/material.dart';

import 'skeleton_loader.dart';

/// Versatile image widget with network/asset support, loading skeleton,
/// and error fallback.
///
/// Uses [SkeletonLoader] as loading placeholder and an icon as error fallback.
class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    this.url,
    this.assetPath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.borderRadius,
  }) : assert(
          url != null || assetPath != null,
          'Either url or assetPath must be provided',
        );

  final String? url;
  final String? assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    Widget image;

    if (url != null) {
      image = Image.network(
        url!,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return placeholder ??
              SkeletonLoader(
                width: width,
                height: height ?? 100,
                borderRadius: borderRadius?.topLeft.x ?? 0,
              );
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildError(context);
        },
      );
    } else {
      image = Image.asset(
        assetPath!,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return _buildError(context);
        },
      );
    }

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: image,
      );
    }

    return image;
  }

  Widget _buildError(BuildContext context) {
    final theme = Theme.of(context);
    return errorWidget ??
        Container(
          width: width,
          height: height,
          color: theme.colorScheme.surfaceContainerHighest,
          child: Icon(
            Icons.broken_image_outlined,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        );
  }
}
