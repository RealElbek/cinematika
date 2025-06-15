// widgets/error_modal.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ErrorModal extends StatelessWidget {
  final String errorMessage;
  final String buttonText;
  final VoidCallback onPressed;
  final String svgAssetPath;

  const ErrorModal({
    super.key,
    required this.errorMessage,
    required this.onPressed,
    this.buttonText = 'Okay',
    this.svgAssetPath = 'assets/icons/error_icon.svg',
  });

  @override
  Widget build(BuildContext context) {
    print("Error for registration: ${errorMessage}");
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        padding: const EdgeInsets.all(50),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              svgAssetPath,
              width: 100,
              height: 87,
            ),
            const SizedBox(height: 24),
            Text(
              'Error...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2AB156),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}