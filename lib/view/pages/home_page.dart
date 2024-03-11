import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:whereitis_2/controller/controller_explorer.dart';
import 'package:whereitis_2/view/specials/fab/view_fab.dart';

class HomePage extends GetView<ExplorerController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // var rxStoreFile = Singleton().rxRootFile;
    // var rxProfileFile = Singleton().rxRootProfile;

    return Scaffold(
      appBar: AppBar(
          // title: Obx(
          //   // () => Text(Singleton().rxActiveStore!.value.title),
          // ),
          ),
      // drawer: WiiDrawerView(
      //   rxFileModel: ,
      //   rxProfileModel: ,
      // ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: WiiFab(
        controller: controller,
      ),
      // body: ExplorerView(controller: ExplorerController(), dirModel: rxStoreFile.value.files![0]),
    );
  }
}
