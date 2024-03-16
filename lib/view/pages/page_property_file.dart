import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whereitis_2/model/db/wii_file.dart';
import 'package:whereitis_2/model/db/wii_profile.dart';
import 'package:whereitis_2/project/assets_images.dart';
import 'package:whereitis_2/view/view_element_property.dart';

class PropertyFilePage extends StatelessWidget {
  late String type;
  late Rx<WFile>? wFile;
  late Rx<WFile> parentFile;
  late Rx<WProfile>? rxProfile;
  late bool editable;
  PropertyFilePage({
    super.key,
    required this.type,
    required this.parentFile,
    this.wFile,
    required this.editable,
  });

  @override
  Widget build(BuildContext context) {
    WFile newFile = WFile(
        title: "title",
        description: "description",
        auth: "auth",
        location: "location",
        image: "",
        files: []);

    if (type.toLowerCase() == 'item'.toLowerCase()) {
      newFile.auth = "irwxrwxrwx";
      newFile.image = AssetsImages.PLACEHOLDER_ITEM;
    } else if (type.toLowerCase() == 'container'.toLowerCase()) {
      newFile.auth = "drwxrwxrwx";
      newFile.image = AssetsImages.PLACEHOLDER_CONTAINER;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(type.toUpperCase()),
      ),
      body: ElementPropertyView(
        wFile: (wFile == null) ? newFile.obs : wFile!,
        type: type.toLowerCase(),
        parentFile: parentFile,
        editable: editable,
      ),
    );
  }
}
