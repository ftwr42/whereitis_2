import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:whereitis_2/controller/controller_explorer.dart';
import 'package:whereitis_2/model/db/wii_file.dart';
import 'package:whereitis_2/singleton.dart';
import 'package:whereitis_2/view/specials/drawer/view_drawer.dart';
import 'package:whereitis_2/view/specials/fab/view_fab.dart';
import 'package:whereitis_2/view/view_element_grid.dart';

import '../model/DBTool.dart';

class ExplorerView extends StatelessWidget {
  late ExplorerController controller;
  late Rx<WFile> wFile;
  late bool withDrawer;
  ExplorerView({super.key, required this.controller, required this.wFile, this.withDrawer = true}) {
    Singleton().rxActive = wFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: WiiFab(
        controller: controller,
      ),
      drawer: (withDrawer) ? WiiDrawerView() : null,
      body: Container(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(wFile.value.title), //Text(dirModel.value.title),
            ),
            FutureBuilder(
              future: DBTool.instanceFiles(wFile.value),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                var data = Singleton().rxActive.value.filesObj;
                SliverGrid sliver;
                if (snapshot.hasData) {
                  sliver = SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return ElementGridView(rxmodel: data[index]);
                    }, childCount: data.length),
                    gridDelegate: elementGridDelegate(2),
                  );
                } else {
                  sliver = SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return ElementGridView(rxmodel: data[index]);
                    }, childCount: data.length),
                    gridDelegate: elementGridDelegate(2),
                  );
                }
                return sliver;
              },
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
