import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whereitis_2/model/DBTool.dart';
import 'package:whereitis_2/model/db/settings.dart';
import 'package:whereitis_2/model/db/wii_file.dart';
import 'package:whereitis_2/singleton.dart';
import 'package:whereitis_2/view/pages/page_property_file.dart';

class DrawerStoresView extends StatefulWidget {
  late Rx<WFile> wFile;
  late Rx<WSettings> rxSettings;

  DrawerStoresView({super.key, required this.wFile, required this.rxSettings});

  @override
  State<DrawerStoresView> createState() => _DrawerStoresViewState();
}

class _DrawerStoresViewState extends State<DrawerStoresView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => wrapper(Singleton().rxSettings!),
        ),
        createNewStoreButton(),
      ],
    );
  }

  Widget wrapper(Rx<WSettings> settings) {
    return Column(
      children: widget.wFile.value.files.map((e) => storeView(e)).toList(),
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

                var rxHandleStore = Singleton().rxHandleStores;
                rxHandleStore?.value.activeStore = key;
                rxHandleStore?.refresh();
              },
              child: Container(
                color: (key == Singleton().rxHandleStores?.value.activeStore)
                    ? Colors.lightBlueAccent
                    : null,
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
            parentFile: widget.wFile,
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
