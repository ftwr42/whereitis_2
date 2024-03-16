import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whereitis_2/controller/controller_explorer.dart';
import 'package:whereitis_2/model/DBTool.dart';
import 'package:whereitis_2/model/db/wii_file.dart';
import 'package:whereitis_2/model/db/wii_profile.dart';
import 'package:whereitis_2/singleton.dart';
import 'package:whereitis_2/view/page_explorer.dart';

Future<void> main() async {
  Get.put(ExplorerController());
  Singleton();
  //DBTool.clearAll();
  //DBTool.putDefaults();
  DBTool.printAllFiles();

  var rxRootFile = (await DBTool.loadFileFromFS('root'))!.obs;
  var rxRootProfile = (await DBTool.loadProfileFromFs('root'))!.obs;

  //check settings which default store is set
  var activeStore = rxRootFile.value.files[0];
  var rxStore = (await DBTool.loadFileFromFS(activeStore))!.obs;

  Singleton().rxRoot = rxRootFile;
  Singleton().rxProfile = rxRootProfile;

  //same can be made with profile

  runApp(MyApp(rxRootFile: rxRootFile, rxRootProfile: rxRootProfile, rxStore: rxStore));
}

class MyApp extends StatelessWidget {
  late Rx<WFile> rxRootFile;
  late Rx<WProfile> rxRootProfile;
  late Rx<WFile> rxStore;

  MyApp({super.key, required this.rxRootFile, required this.rxRootProfile, required this.rxStore});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Wii - Where is it',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        // drawer: WiiDrawerView(
        //   rxFile: rxRootFile,
        //   rxProfile: rxRootProfile,
        // ),
        body: ExplorerView(wFile: rxStore),
        // floatingActionButton: WiiFab(
        //   wFile: rxStore,
        // ),
        // floatingActionButtonLocation: ExpandableFab.location,
      ),
    );
  }
}
