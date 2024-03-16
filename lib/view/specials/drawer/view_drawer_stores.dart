import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whereitis_2/model/DBTool.dart';
import 'package:whereitis_2/model/db/wii_file.dart';
import 'package:whereitis_2/view/pages/page_property_file.dart';

class DrawerStoresView extends StatelessWidget {
  late Rx<WFile> wFile;

  DrawerStoresView({super.key, required this.wFile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: wFile.value.files.map((e) => storeView(e)).toList(),
        ),
        createNewStoreButton(),
      ],
    );
  }

  Widget storeView(String key) => FutureBuilder(
        future: DBTool.loadFileFromFS(key),
        builder: (BuildContext context, AsyncSnapshot<WFile?> snapshot) {
          Widget w = const Center(
            child: Text("NO STORE YET"),
          );
          if (snapshot.hasData) {
            w = GestureDetector(
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
                  title: Text(snapshot.data!.title),
                  subtitle: Text(snapshot.data!.title),
                  trailing: GestureDetector(child: const Icon(Icons.edit)),
                ),
              ),
            );
          }
          return w;
        },
      );

  Widget createNewStoreButton() {
    return GestureDetector(
      onTap: () {
        Get.to(
          PropertyFilePage(
            editable: true,
            type: 'container',
            parentFile: wFile,
          ),
        );
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
