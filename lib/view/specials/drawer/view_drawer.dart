import 'package:flutter/material.dart';
import 'package:whereitis_2/view/specials/drawer/view_drawer_profile.dart';
import 'package:whereitis_2/view/specials/drawer/view_drawer_settings.dart';
import 'package:whereitis_2/view/specials/drawer/view_drawer_stores.dart';

class WiiDrawerView extends StatelessWidget {
  WiiDrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                // Wrap with ListView
                children: [
                  DrawerProfileView(),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text("Home"),
                  ),
                  ListTile(
                    leading: Icon(Icons.history),
                    title: Text("My History"),
                  ),
                  Divider(),
                  DrawerStoresView(),
                  Expanded(child: Container()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const DrawerSettingsView(),
            ),
          ],
        ),
      ),
    );
  }
}
