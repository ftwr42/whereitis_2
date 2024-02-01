import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whereitis_2/controller/controller_explorer.dart';
import 'package:whereitis_2/model/model_element.dart';
import 'package:whereitis_2/view/view_element_grid.dart';

class ExplorerView extends StatelessWidget {
  late ExplorerController controller;
  ExplorerView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    controller.loadElementModels();
    var listModel = controller.getModelShow;

    return Container(
      child: CustomScrollView(
        slivers: [
          // SliverAppBar(),
          SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              Rx<ElementModel> rxmodel = listModel[index];
              // print("title " + rxmodel.value.title);
              return ElementGridView(rxmodel: rxmodel);
            }, childCount: listModel.length),
            gridDelegate: elementGridDelegate(2),
          ),
        ],
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
