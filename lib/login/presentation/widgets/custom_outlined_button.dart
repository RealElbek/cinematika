import 'package:flutter/material.dart';


/// A customizable outlined button with configurable text, styles, and dimensions.
///
/// This button provides an outlined appearance with border and allows for
/// customization of text, colors, border properties, and dimensions.
class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    Key? key,
    this.decoration,
    this.padding,
    this.borderDecoration,
    this.onPressed,
    this.alignment,
    this.text = "",
    this.margin,
    this.width,
    this.height,
    this.buttonStyle,
    this.buttonTextStyle,
    this.isDisabled = false,
  }) : super(key: key);

  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;
  final BoxDecoration? borderDecoration;
  final VoidCallback? onPressed;
  final Alignment? alignment;
  final String text;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final ButtonStyle? buttonStyle;
  final TextStyle? buttonTextStyle;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
      alignment: alignment ?? Alignment.center,
      child: buildOutlinedButtonWidget(context),
    )
        : buildOutlinedButtonWidget(context);
  }

  Widget buildOutlinedButtonWidget(BuildContext context) {
    return Container(
      width: width ?? double.maxFinite,
      height: height ?? 50,
      margin: margin,
      decoration: decoration,
      child: OutlinedButton(
        style:
        buttonStyle ??
            OutlinedButtonTheme.of(context).style ??
            OutlinedButton.styleFrom(
              side: BorderSide(color: Color(0xFF2AB156), width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.zero,
            ),
        onPressed: isDisabled ? null : onPressed,
        child: Container(
          width: double.maxFinite,
          padding: padding,
          decoration: borderDecoration,
          child: Center(
            child: Text(
              text,
              style:
              buttonTextStyle ?? TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2AB156),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
