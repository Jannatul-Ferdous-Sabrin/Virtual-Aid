// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomSnackBar {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.withOpacity(0.85),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class CopiedSnackBar {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blue.withOpacity(0.85),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
