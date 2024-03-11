import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whereitis_2/model/db/wii_file.dart';
import 'package:whereitis_2/view/view_element_property.dart';

class TouchFilePage extends StatelessWidget {
  late Rx<WFile> model;
  late bool editable;
  TouchFilePage({super.key, required this.model, this.editable = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          model.value.auth.substring(0, 1) == 'd' ? "Container" : "Item",
        ),
      ),
      // drawer: WiiDrawerView(),
      // floatingActionButton: WiiFab(),
      body: ElementPropertyView(
        model: model,
        editable: editable,
      ),
    );
  }
}
