import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whereitis_2/controller/controller_explorer.dart';
import 'package:whereitis_2/singleton.dart';
import 'package:whereitis_2/view/page_explorer.dart';

void main() {
  Get.put(ExplorerController());
  Singleton();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Obx(
        () {
          Singleton().rxActiveStore!.value.id; // for obx scan
          return ExplorerView(
            controller: ExplorerController(),
            dirModel: Singleton().rxActiveStore!,
          );
        },
      ),
    );
  }
}
