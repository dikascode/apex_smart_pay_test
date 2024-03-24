import 'package:flutter/material.dart';

// Button text style
const TextStyle customButtonBoldTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

const TextStyle customSubtitleTextStyle =
    TextStyle(fontSize: 16, color: Color(0xFF6B7280));

ButtonStyle activeButtonStyle(bool isButtonActive) {
  return ElevatedButton.styleFrom(
    backgroundColor: isButtonActive ? const Color(0xFF111827) : Colors.grey[400],
    foregroundColor: Colors.white,
    minimumSize: const Size(double.infinity, 50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    padding: const EdgeInsets.all(16),
  );
}

InputDecoration customInputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    filled: true,
    fillColor: const Color(0xFFF9FAFB),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: Color(0xFF2FA2B9),
        width: 1,
      ),
    ),
    hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
  );
}
