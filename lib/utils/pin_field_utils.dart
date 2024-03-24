import 'package:flutter/material.dart';

class PinFieldUtils {
  static void handlePinFieldChange(String value, int index, List<FocusNode> focusNodes, int codeLength, BuildContext context) {
    if (value.isNotEmpty && index + 1 < codeLength) {
      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
    } else if (value.isEmpty && index - 1 >= 0) {
      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
    }
  }
}
