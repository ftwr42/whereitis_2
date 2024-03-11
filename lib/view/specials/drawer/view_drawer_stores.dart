import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whereitis_2/model/db/wii_file.dart';
import 'package:whereitis_2/singleton.dart';
import 'package:whereitis_2/view/pages/page_touch_file.dart';

import '../../../model/DBTool.dart';

class DrawerStoresView extends StatelessWidget {
  DrawerStoresView({super.key});

  WFile storePlaceholderModel = WFile(
    title: 'New Store',
    description: 'enter a description',
    location: 'xy',
    id: 'none',
    auth: 'drwxrwxrwx',
    image: 'assets/images/store_placeholder.png',
    files: [],
  );

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      FutureBuilder(
        future: DBTool.instanceFiles(Singleton().rxRoot.value),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          var files = snapshot.data as List<Rx<WFile>>;
          print("================>>>>" + files[0].value.title);
          Column w;
          if (snapshot.hasData) {
            w = Column(
              children: files.map((e) => storeView(e)).toList(),
            );
          } else {
            w = const Column(
              children: [
                Text("Hallo test2"),
              ],
            );
          }
          return w;
        },
      ),
      createNewStoreButton(),
    ]);
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

  Widget storeView(Rx<WFile> rxModel) => GestureDetector(
        onTap: () {
          //todo understand routetree from  Get and then close all pages opened after the root of a store
          // Singleton().rxActiveStore = rxModel;
          // Singleton().rxActiveStore!.refresh();
        },
        child: Container(
          // color: (rxModel.value.id == Singleton().rxActiveStore!.value.id)
          //     ? Colors.lightBlueAccent
          //     : null,
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
