import 'package:flutter/material.dart';

/// Extensions on [num] for spacing (padding, margin, gap). e.g. 8.horizontal, 16.all
extension SpacingExtension on num {
  EdgeInsets get horizontal => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets get vertical => EdgeInsets.symmetric(vertical: toDouble());
  EdgeInsets get all => EdgeInsets.all(toDouble());
  EdgeInsets get horizontalVertical => EdgeInsets.symmetric(
        horizontal: toDouble(),
        vertical: toDouble(),
      );

  SizedBox get width => SizedBox(width: toDouble());
  SizedBox get height => SizedBox(height: toDouble());
  SizedBox get square => SizedBox(width: toDouble(), height: toDouble());
}
