import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialSignInButton extends StatelessWidget {
  final String assetName;
  final String label;
  final VoidCallback onPressed;

  const SocialSignInButton({
    super.key,
    required this.assetName,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
    width: 150,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: const Color(0xFFE5E7EB)),
      color: Colors.white,
    ),
    child: TextButton(
      onPressed: () {
        // Handle social sign-in logic
      },
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(assetName, width: 24, height: 24),
          if (label.isNotEmpty) ...[
            const SizedBox(width: 10),
          ],
        ],
      ),
    ),
  );
  }
}
