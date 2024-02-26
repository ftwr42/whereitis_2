import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whereitis_2/model/model_file.dart';
import 'package:whereitis_2/singleton.dart';
import 'package:whereitis_2/view/pages/page_touch_file.dart';

class DrawerStoresView extends StatelessWidget {
  late Rx<FileModel> rxmodel;
  DrawerStoresView({super.key, required this.rxmodel});

  FileModel storePlaceholderModel = FileModel(
      title: 'New Store',
      description: 'enter a description',
      location: 'xy',
      id: 'none',
      auth: 'drwxrwxrwx',
      imgPath: "",
      imagePath: 'assets/images/store_placeholder.png');

  @override
  Widget build(BuildContext context) {
    var files = rxmodel.value.files;

    return Column(
      children: [
        Obx(
          () => Column(
            children: files!.map((e) => storeView(e)).toList() ?? storePlaceholder(),
          ),
        ),
        createNewStoreButton(),
      ],
    );
  }

  List<Widget> storePlaceholder() {
    return <Widget>[
      GestureDetector(
        onTap: () {
          Get.to(TouchFilePage(model: storePlaceholderModel.obs));
        },
        child: ListTile(
          leading: const Icon(Icons.store),
          title: Text(storePlaceholderModel.title),
        ),
      ),
    ];
  }

  Widget storeView(Rx<FileModel> rxModel) => GestureDetector(
        onTap: () {
          //todo understand routetree from  Get and then close all pages opened after the root of a store
          Singleton().rxActiveStore = rxModel;
          Singleton().rxActiveStore!.refresh();
        },
        child: Container(
          color: (rxModel.value.id == Singleton().rxActiveStore!.value.id)
              ? Colors.lightBlueAccent
              : null,
          child: ListTile(
            leading: const Icon(Icons.store),
            title: Text(rxModel.value.title),
            subtitle: Text(rxModel.value.description),
            trailing: GestureDetector(child: const Icon(Icons.edit)),
          ),
        ),
      );

  Widget createNewStoreButton() {
    return GestureDetector(
      onTap: () {
        Get.to(TouchFilePage(model: storePlaceholderModel.obs));
      },
      child: Container(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black26,
            border: Border.all(
              width: 2,
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          width: 100,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
