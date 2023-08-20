import 'package:flutter/material.dart';
import '../utils/validators.dart' as valid;

/// Generate padded textform widgets with default padding parameters
/// to avoid unnecessary duplicating
Widget getPaddedText(String label,
    {required TextEditingController controller,
    double px = 8,
    double py = 16,
    bool outlineborder = true}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: px, vertical: py),
    child: TextFormField(
      controller: controller,
      validator: valid.isShort,
      decoration: InputDecoration(
        border: outlineborder ? const OutlineInputBorder() : null,
        labelText: label,
      ),
    ),
  );
}
