import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:whereitis_2/controller/controller_explorer.dart';
import 'package:whereitis_2/model/model_element.dart';
import 'package:whereitis_2/view/pages/page_property.dart';

//https://pub.dev/packages/flutter_expandable_fab
class WiiFab extends StatelessWidget {
  final _key = GlobalKey<ExpandableFabState>();
  late ExplorerController controller;
  WiiFab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      key: _key,
      pos: ExpandableFabPos.right,
      type: ExpandableFabType.up,
      distance: 80,
      afterOpen: () {},
      children: [
        FloatingActionButton.small(
          heroTag: null,
          child: const Icon(Icons.edit),
          onPressed: () {
            _key.currentState!.toggle();
            var newrxmodel = ElementModel(
                    title: 'Title',
                    description: 'Description',
                    location: 'Location',
                    id: 'Id',
                    auth: 'frwxrwxrwx',
                    imagePath: 'assets/element_placeholder.jpg')
                .obs;
            Get.to(ElementPropertyPage(
              model: newrxmodel,
              editable: true,
            ));
          },
        ),
        FloatingActionButton.small(
          heroTag: null,
          child: const Icon(Icons.create_new_folder_outlined),
          onPressed: () {
            _key.currentState!.toggle();
            var newrxmodel = ElementModel(
                    title: 'Title',
                    description: 'Description',
                    location: 'Location',
                    id: 'Id',
                    auth: 'drwxrwxrwx',
                    imagePath: 'assets/element_placeholder.jpg')
                .obs;
            Get.to(ElementPropertyPage(
              model: newrxmodel,
              editable: true,
            ));
          },
        ),
      ],
    );
  }
}