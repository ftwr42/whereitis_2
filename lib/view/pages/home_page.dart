import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whereitis_2/controller/controller_explorer.dart';
import 'package:whereitis_2/view/view_drawer.dart';
import 'package:whereitis_2/view/view_explorer.dart';

class HomePage extends GetView<ExplorerController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: WiiDrawerView(),
      // floatingActionButton: WiiFab(),
      body: ExplorerView(controller: controller),
    );
  }
}
