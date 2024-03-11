import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whereitis_2/controller/controller_explorer.dart';
import 'package:whereitis_2/model/DBTool.dart';
import 'package:whereitis_2/model/db/wii_file.dart';
import 'package:whereitis_2/singleton.dart';
import 'package:whereitis_2/view/page_explorer.dart';

void main() {
  Get.put(ExplorerController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DBTool.loadRootFromFs(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        var data = snapshot.data as Rx<WFile>;

        Widget w;
        if (snapshot.hasData) {
          w = GetMaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: Obx(
              () {
                Singleton().rxRoot.value.id;
                return ExplorerView(
                  controller: ExplorerController(),
                  wFile: Singleton().rxRoot.value.filesObj[0],
                );
              },
            ),
          );
        } else {
          w = Container(
            child: const Center(
              child: Text("NO DATA FOUND"),
            ),
          );
        }
        return w;
      },
    );
  }
}
