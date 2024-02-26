import 'package:flutter/material.dart';

class DrawerSettingsView extends StatelessWidget {
  const DrawerSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {},
          child: const Icon(Icons.settings),
        ),
      ],
    );
  }
}
