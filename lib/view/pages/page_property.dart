import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whereitis_2/model/model_element.dart';
import 'package:whereitis_2/view/view_element_property.dart';

class ElementPropertyPage extends StatelessWidget {
  late Rx<ElementModel> model;
  ElementPropertyPage({super.key, required this.model});

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
      ),
    );
  }
}
