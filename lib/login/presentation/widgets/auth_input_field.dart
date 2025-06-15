// widgets/auth_input_field.dart
import 'package:flutter/material.dart';

class AuthInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String title;
  final String hintText;
  final bool hasCursor;
  final bool isPassword;
  final bool isPasswordVisible;
  final VoidCallback? onToggleVisibility;
  final double? topMargin;

  const AuthInputField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.title,
    required this.hintText,
    required this.hasCursor,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.onToggleVisibility,
    this.topMargin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: topMargin ?? 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 44,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0x1E8E8E93),
                    borderRadius: BorderRadius.circular(10),
                    border: hasCursor
                        ? Border.all(color: const Color(0xFF535353))
                        : null,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextField(
                      controller: controller,
                      focusNode: focusNode,
                      obscureText: isPassword && !isPasswordVisible,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        height: 1.0,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hintText,
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 15,
                          height: 1.0,
                        ),
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                      ),
                    ),
                  ),
                ),
                if (hasCursor)
                if (isPassword && onToggleVisibility != null)
                  Positioned(
                    right: 16,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: const Color(0xFF8E8E93),
                          size: 24,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: onToggleVisibility,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}