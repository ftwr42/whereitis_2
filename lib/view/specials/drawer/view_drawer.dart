import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:whereitis_2/model/db/settings.dart';
import 'package:whereitis_2/view/specials/drawer/view_drawer_profile.dart';
import 'package:whereitis_2/view/specials/drawer/view_drawer_settings.dart';
import 'package:whereitis_2/view/specials/drawer/view_drawer_stores.dart';

import '../../../model/db/wii_file.dart';
import '../../../model/db/wii_profile.dart';

class WiiDrawerView extends StatelessWidget {
  late Rx<WProfile> rxProfile;
  late Rx<WFile> rxFile;
  late Rx<WSettings> rxSettings;
  WiiDrawerView(
      {super.key, required this.rxFile, required this.rxProfile, required this.rxSettings});

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
                  DrawerProfileView(rxProfile: rxProfile),
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
                  DrawerStoresView(
                    wFile: rxFile,
                    rxSettings: rxSettings,
                  ),
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
