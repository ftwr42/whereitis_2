import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:whereitis_2/model/db/wii_file.dart';
import 'package:whereitis_2/view/pages/page_property_file.dart';

class WiiFab extends StatelessWidget {
  final _key = GlobalKey<ExpandableFabState>();
  final Rx<WFile> wFile;
  WiiFab({super.key, required this.wFile});

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
            Get.to(
              PropertyFilePage(
                editable: true,
                type: "item",
                parentFile: wFile,
              ),
            );
          },
        ),
        FloatingActionButton.small(
          heroTag: null,
          child: const Icon(Icons.create_new_folder_outlined),
          onPressed: () {
            _key.currentState!.toggle();
            Get.to(
              PropertyFilePage(
                editable: true,
                type: "container",
                parentFile: wFile,
              ),
            );
          },
        ),
      ],
    );
  }
}
