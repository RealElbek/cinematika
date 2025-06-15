import 'package:flutter/material.dart';

import '../../../core/themes/theme_helper.dart';
import './custom_image_view.dart';

/// A customizable icon button widget with configurable size, decoration, and behavior.
///
/// This widget allows for creating icon buttons with different appearances, padding,
/// and interaction behaviors.
class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    this.height,
    this.width,
    this.padding,
    this.decoration,
    this.alignment,
    this.margin,
    this.onTap,
    required this.imagePath,
    this.imageHeight,
    this.imageWidth,
  }) : super(key: key);

  /// Height of the icon button.
  final double? height;

  /// Width of the icon button.
  final double? width;

  /// Padding around the icon.
  final EdgeInsetsGeometry? padding;

  /// Decoration for the icon button.
  final BoxDecoration? decoration;

  /// Alignment of the icon button within its parent.
  final Alignment? alignment;

  /// Margin around the icon button.
  final EdgeInsetsGeometry? margin;

  /// Callback function when the button is tapped.
  final VoidCallback? onTap;

  /// Path to the icon image.
  final String imagePath;

  /// Height of the icon image.
  final double? imageHeight;

  /// Width of the icon image.
  final double? imageWidth;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildIconButtonWidget,
          )
        : _buildIconButtonWidget;
  }

  Widget get _buildIconButtonWidget {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Material(
        color: appTheme.transparentCustom,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: height ?? 24,
            width: width ?? 24,
            padding: padding ?? EdgeInsets.zero,
            decoration: decoration,
            child: CustomImageView(
              imagePath: imagePath,
              height: imageHeight ?? 24,
              width: imageWidth ?? 24,
            ),
          ),
        ),
      ),
    );
  }
}
