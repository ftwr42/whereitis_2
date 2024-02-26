import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:whereitis_2/controller/controller_explorer.dart';
import 'package:whereitis_2/model/model_file.dart';
import 'package:whereitis_2/singleton.dart';
import 'package:whereitis_2/view/specials/drawer/view_drawer.dart';
import 'package:whereitis_2/view/specials/fab/view_fab.dart';
import 'package:whereitis_2/view/view_element_grid.dart';

class ExplorerView extends StatelessWidget {
  late ExplorerController controller;
  late Rx<FileModel> dirModel;
  late bool withDrawer;
  ExplorerView(
      {super.key, required this.controller, required this.dirModel, this.withDrawer = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: WiiFab(
        controller: controller,
      ),
      drawer: (withDrawer)
          ? WiiDrawerView(
              rxFileModel: Singleton().rxRootFile,
              rxProfileModel: Singleton().rxRootProfile,
            )
          : null,
      body: Container(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(dirModel.value.title),
            ),
            Obx(
              () => SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return ElementGridView(rxmodel: dirModel.value.files![index]);
                }, childCount: dirModel.value.files!.length),
                gridDelegate: elementGridDelegate(2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverGridDelegateWithFixedCrossAxisCount elementGridDelegate(int crossAxisCount) =>
      SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 3.0,
        mainAxisSpacing: 3.0,
        childAspectRatio: 1.0, // Verhältnis von Breite zu Höhe
      );
}
