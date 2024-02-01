import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:whereitis_2/controller/controller_explorer.dart';
import 'package:whereitis_2/view/specials/drawer/view_drawer.dart';
import 'package:whereitis_2/view/specials/fab/view_fab.dart';
import 'package:whereitis_2/view/view_explorer.dart';

class HomePage extends GetView<ExplorerController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: WiiDrawerView(),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: WiiFab(
        controller: controller,
      ),
      body: ExplorerView(controller: controller),
    );
  }
}
