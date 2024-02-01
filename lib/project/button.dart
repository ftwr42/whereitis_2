import 'package:flutter/material.dart';

class ProjectButtonWidget {
  static Widget button1(String title, Function? onPressed()) {
    return ElevatedButton(onPressed: onPressed, child: Text(title));
  }
}
