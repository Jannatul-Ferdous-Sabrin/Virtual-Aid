// ignore_for_file: file_names

import 'package:flutter/material.dart';

snackBar(String title, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));
}
