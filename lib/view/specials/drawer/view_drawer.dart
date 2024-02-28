import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:whereitis_2/model/model_file.dart';
import 'package:whereitis_2/model/model_profile.dart';
import 'package:whereitis_2/view/specials/drawer/view_drawer_profile.dart';
import 'package:whereitis_2/view/specials/drawer/view_drawer_settings.dart';
import 'package:whereitis_2/view/specials/drawer/view_drawer_stores.dart';

class WiiDrawerView extends StatelessWidget {
  late Rx<FileModel> rxFileModel;
  late Rx<ProfileModel> rxProfileModel;
  WiiDrawerView({super.key, required this.rxFileModel, required this.rxProfileModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView( // Wrap with ListView
                children: [
                  DrawerProfileView(rxModel: rxProfileModel),
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
                  DrawerStoresView(rxmodel: rxFileModel),
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
