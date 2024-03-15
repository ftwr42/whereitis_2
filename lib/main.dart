import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whereitis_2/controller/controller_explorer.dart';
import 'package:whereitis_2/model/DBTool.dart';

Future<void> main() async {
  Get.put(ExplorerController());
  // DBTool.clearAll();
  //DBTool.putDefaults();
  DBTool.printAllFiles();
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DBTool.loadProfileAndRootSafeToSingletonAndReturnRoot(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        Widget w = Container();
        if (snapshot.hasData) {
          // w = GetMaterialApp(
          //   title: 'Wii - Where is it',
          //   theme: ThemeData(
          //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          //     useMaterial3: true,
          //   ),
          // home: Obx(
          //   () {
          //     return ExplorerView(
          //       wFile: snapshot.data.value.filesObj[0],
          //     );
          //   },
          // ),
          // );
        } else {
          w = const Center(
            child: Text("NO DATA FOUND"),
          );
        }
        return w;
      },
    );
  }
}
