import 'package:flutter/material.dart';

class ProjectTextStyle {
  static TextStyle header1() => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
        letterSpacing: 2.0,
      );

  static TextStyle normal1() => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        letterSpacing: 1.0,
      );

  static TextStyle normal2() => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        letterSpacing: 1.0,
      );
}
