import 'package:flutter/material.dart';

Widget getPaddedText(String label,
    {required TextEditingController controller,
    double px = 8,
    double py = 16,
    bool outlineborder = true}) {
  /// Generate padded textform widgets with default padding parameters
  /// to avoid unnecessary duplicating

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: px, vertical: py),
    child: TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required Field';
        }
        if (value.length < 3) {
          return 'Too short';
        }
        return null;
      },
      decoration: InputDecoration(
        border: outlineborder ? const OutlineInputBorder() : null,
        labelText: label,
      ),
    ),
  );
}
