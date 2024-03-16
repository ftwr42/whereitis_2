import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whereitis_2/controller/controller_explorer.dart';
import 'package:whereitis_2/handle_stores.dart';
import 'package:whereitis_2/model/DBTool.dart';
import 'package:whereitis_2/model/db/wii_file.dart';
import 'package:whereitis_2/model/db/wii_profile.dart';
import 'package:whereitis_2/singleton.dart';
import 'package:whereitis_2/view/page_explorer.dart';

Future<void> main() async {
  Get.put(ExplorerController());
  Singleton();
  // DBTool.clearAll();
  // DBTool.putDefaults();
  DBTool.printAllFiles();

  var rxRootFile = (await DBTool.loadFileFromFS('root'))!.obs;
  var rxRootProfile = (await DBTool.loadProfileFromFs('root'))!.obs;
  var rxSettings = (await DBTool.loadSettingsFromFS('root'))!.obs;

  var handleStores =
      HandleStores(files: rxRootFile.value.files, activeStore: rxSettings.value.activeStore);
  var obs2 = handleStores.obs;

  Singleton().rxRoot = rxRootFile;
  Singleton().rxProfile = rxRootProfile;
  Singleton().rxSettings = rxSettings;
  Singleton().rxHandleStores = obs2;

  runApp(MyApp(rxRootFile: rxRootFile, rxRootProfile: rxRootProfile, rxHandleStores: obs2));
}

class MyApp extends StatelessWidget {
  late Rx<WFile> rxRootFile;
  late Rx<WProfile> rxRootProfile;
  late Rx<HandleStores> rxHandleStores;

  MyApp(
      {super.key,
      required this.rxRootFile,
      required this.rxRootProfile,
      required this.rxHandleStores});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Wii - Where is it',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Obx(() {
        print("ACTIVESTORE::" + rxHandleStores.value.activeStore);
        return FutureBuilder(
          future: rxHandleStores.value.getActiveStore(),
          builder: (BuildContext context, AsyncSnapshot<WFile?> snapshot) {
            if (snapshot.hasData) {
              return ExplorerView(wFile: snapshot.data!.obs);
            }
            return Container();
          },
        );
      }),
      // home: FutureBuilder(future: ExplorerView(wFile: rxHandleStores.value!.getActiveStore().obs)),
    );
  }
}
