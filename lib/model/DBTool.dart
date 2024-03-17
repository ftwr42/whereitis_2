import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whereitis_2/model/db/settings.dart';
import 'package:whereitis_2/model/db/wii_file.dart';
import 'package:whereitis_2/model/db/wii_profile.dart';
import 'package:whereitis_2/project/assets_images.dart';

import '../singleton.dart';

//flutter packages pub run build_runner build

class DBTool {
  static const String DBNAME = "WIIDB";
  static const String PROFILENAME = "profiles";
  static const String SETTINGSNAME = "settings";
  static const String FILENAME = "files";
  static const String PATH = "./where_it_is";
  static const String ROOTKEY = "root";

  static clearAll() async {
    var fileBox = await openHiveBox(FILENAME);
    await fileBox.clear();
    var profileBox = await openHiveBox(PROFILENAME);
    await profileBox.clear();
    var settingsBox = await openHiveBox(SETTINGSNAME);
    await settingsBox.clear();
  }

  static putDefaults() async {
    var rootFile = WFile(
      title: "root",
      description: "root",
      id: "root",
      auth: "drwxrwxrwx",
      location: "root",
      image: "root",
      files: [],
    );
    var storeA = SETID(WFile(
      title: "Store A",
      description: "Stores Chickens",
      auth: "drwxrwxrwx",
      location: "chicken land",
      image: AssetsImages.PLACEHOLDER_STORE,
      files: [],
    ));
    var storeABun = SETID(WFile(
      title: "Chicken Bun",
      description: "holds a box of chicken pieces",
      auth: "drwxrwxrwx",
      location: "in chicken store",
      image: AssetsImages.PLACEHOLDER_CONTAINER,
      files: [],
    ));
    var storeAChickenWing = SETID(WFile(
      title: "Chicken Wing",
      description: "crusty and jammy",
      auth: "irwxrwxrwx",
      location: "in chicken store",
      image: AssetsImages.PLACEHOLDER_ITEM,
      files: [],
    ));
    var storeAPiece2 = SETID(WFile(
      title: "Chicken Piece small",
      description: "crusty and jammy",
      auth: "irwxrwxrwx",
      location: "in chicken store",
      image: AssetsImages.PLACEHOLDER_ITEM,
      files: [],
    ));
    var storeAPiece = SETID(WFile(
      title: "Chicken Pieces big",
      description: "pieces of chicken",
      auth: "irwxrwxrwx",
      location: "in a bun",
      image: AssetsImages.PLACEHOLDER_ITEM,
      files: [],
    ));

    var storeB = SETID(WFile(
      title: "Store B",
      description: "Stores Dogs",
      auth: "drwxrwxrwx",
      location: "dogs land",
      image: AssetsImages.PLACEHOLDER_STORE,
      files: [],
    ));
    var storeBdog = SETID(WFile(
      title: "cute Dog",
      description: "A cute little dog",
      auth: "irwxrwxrwx",
      location: "in the dog shop",
      image: AssetsImages.PLACEHOLDER_ITEM,
      files: [],
    ));

    var fileBox = await openHiveBox(FILENAME);
    var json = rootFile.toJson();
    var jsonEncode2 = jsonEncode(json);
    var string = jsonEncode2.toString();

    await fileBox.put("root", string);
    Rx<WFile> rxRoot = rootFile.obs;
    Singleton().rxRoot = rxRoot;

    var s = await fileBox.get("root");
    var loadFileFromFS3 = await loadFileFromFS('root');

    await putFile(storeA, rxRoot);

    Rx<WFile> storA = storeA.obs;

    var fileBox2 = await openHiveBox(FILENAME);

    // var loadFileFromFS2 = await loadFileFromFS(storeA.id);
    var ls = await fileBox2.get(storeA.id);

    await putFile(storeABun, storA);
    await putFile(storeAPiece, storeABun.obs);
    await putFile(storeAPiece2, storeABun.obs);
    await putFile(storeAChickenWing, storA);

    Rx<WFile> rxStoreB = storeB.obs;
    await putFile(storeB, rxRoot);
    await putFile(storeBdog, rxStoreB);

    var wProfile = WProfile(
      firstname: "Jan",
      lastname: "Freirich",
      id: "jfid",
      email: "jf@gmail.com",
      description: "admin",
      image: AssetsImages.PLACEHOLDER_PROFILE,
    );

    var wp = wProfile.toJson();
    var wpjsonEncode2 = jsonEncode(wp);
    var wpstring = wpjsonEncode2.toString();
    Singleton().rxProfile = wProfile.obs;
    var name = await (await openHiveBox(PROFILENAME)).put('root', wpstring);

    var wSettings = WSettings(activeStore: storeA.id);
    putSettings(wSettings);
  }

  static putProfile(WProfile wProfile) async {
    var filesBox = await openHiveBox(PROFILENAME);
    var json = wProfile.toJson();
    filesBox.put('root', json.toString());
  }

  static Future<void> printAllFiles() async {
    var fileBox = await openHiveBox(FILENAME);
    var profileBox = await openHiveBox(PROFILENAME);
    var settingsBox = await openHiveBox(SETTINGSNAME);

    print("PRINT_ALL_FILES keys=${fileBox.keys}");
    int i = 0;
    for (String key in fileBox.keys) {
      WFile? wFile = await loadFileFromFS(key);
      if (wFile != null) {
        print("\t${++i < 9 ? " " : ""}$i. ${wFile.toJson()}");
      }
    }

    print("PRINT_ALL_SETTINGS keys=${settingsBox.keys}");
    int j = 0;
    for (String key in settingsBox.keys) {
      WSettings? wFile = await loadSettingsFromFS(key);
      if (WSettings != null) {
        print("\t${++j < 9 ? " " : ""}$j. ${wFile?.toJson()}");
      }
    }

    print("PRINT_ALL_PROFILES keys=${profileBox.keys}");
    int k = 0;
    for (String key in profileBox.keys) {
      WProfile? wProfile = await loadProfileFromFs(key);
      if (wProfile != null) {
        print("\t${++k < 9 ? " " : ""}$k. ${wProfile.toJson()}");
      }
    }
  }

  static Future<WProfile> loadProfileFromFs(String key) async {
    var profilesBox = await openHiveBox(PROFILENAME);

    var profile = await profilesBox.get(key);
    var decode = jsonDecode(profile.toString());
    var jsonDecode2 = decode;
    var wProfile = WProfile.fromJson(decode);

    return wProfile;
  }

  static Future<WSettings> loadSettingsFromFS(String key) async {
    var openBox = await openHiveBox(SETTINGSNAME);
    var settings = await openBox.get('root');

    if (settings == null) {
      var wSettings = WSettings(activeStore: "");
      putSettings(wSettings);
      return wSettings;
    }

    var decode = jsonDecode(settings);
    WSettings wSettings = WSettings.fromJson(decode);

    return wSettings;
  }

  static Future<String> loadStringFromFS(String key) async {
    var fileBox = await openHiveBox(FILENAME);

    var root = await fileBox.get(key);

    if (root == null) {
      return "empty";
    }
    return root;
  }

  static Future<WFile?> loadFileFromFS(String key) async {
    var fileBox = await openHiveBox(FILENAME);

    var root = await fileBox.get(key);
    //print(root);

    if (root == null) {
      var root = WFile(
          title: "root",
          description: "root",
          auth: "root",
          location: "root",
          image: "root",
          files: []);

      var rxRoot = root.obs;

      await (await openHiveBox(FILENAME)).put("root", jsonEncode(root.toJson()).toString());

      var store = SETID(WFile(
          title: "Store A",
          description: "default Store",
          auth: "drwxrwxrwx",
          location: "nowhere",
          image: AssetsImages.PLACEHOLDER_STORE,
          files: []));

      await putFile(store, rxRoot);

      var item = SETID(WFile(
          title: "Item",
          description: "default item",
          auth: "irwxrwxrwx",
          location: "nowhere",
          image: AssetsImages.PLACEHOLDER_ITEM,
          files: []));

      await putFile(item, rxRoot);

      return root;
    }

    var jsonDecode2 = jsonDecode(root);
    var wFile = WFile.fromJson(jsonDecode2);

    return wFile;
  }

  static putSettings(WSettings wSettings) async {
    var openBox = await openHiveBox(SETTINGSNAME);

    // var getFile = await loadFileFromFS(wFile.id);
    // var getSettings = await openBox.get('root');

    var json = wSettings.toJson();
    var jsonEncode2 = jsonEncode(json);
    var string = jsonEncode2.toString();

    await openBox.put('root', string);
    var s = await openBox.get('root');
    print("SAVED: " + s.toString());
  }

  static putFile(WFile wFile, Rx<WFile> parent) async {
    var openBox = await openHiveBox(FILENAME);

    // var getFile = await loadFileFromFS(wFile.id);
    var getFile = await openBox.get(wFile.id);

    var json = wFile.toJson();
    var jsonEncode2 = jsonEncode(json);
    var string = jsonEncode2.toString();

    await openBox.put(wFile.id, string);
    var s = await openBox.get(wFile.id);
    // print(s);

    if (getFile == null) {
      await _addToLists(openBox, wFile, parent);
    }
  }

  static dropFile(WFile wFile, Rx<WFile> parent) async {
    var openBox = await openHiveBox(FILENAME);

    // var getFile = await loadFileFromFS(wFile.id);
    var getFile = await openBox.get(wFile.id);

    if (getFile != null) {
      openBox.delete(wFile.id);

      int i = 0;
      for (String str in parent.value.files) {
        if (str == wFile.id) {
          parent.value.files.removeAt(i);
        }
        i++;
      }

      parent.refresh();
    }
  }

  static _addToLists(Box<dynamic> box, WFile wFile, Rx<WFile> parent) async {
    parent.value.files.add(wFile.id);

    var json = parent.value.toJson();
    var jsonEncode2 = jsonEncode(json);
    var string = jsonEncode2.toString();

    await (await openHiveBox(FILENAME)).put(parent.value.id, string);
    // var s = (await openHiveBox(FILENAME)).get(parent.value.id);
    parent.refresh();
  }

  static Future<WProfile?> getProfile(Box<dynamic> box, String key) async {
    var string = await box.get(key);

    if (string == null) {
      return null;
    }

    var decode = jsonDecode(string);
    var wProfile = WProfile.fromJson(decode);
    return wProfile;
  }

  static Future<Box<String?>> openHiveBox(String boxName) async {
    if (!kIsWeb && !Hive.isBoxOpen(boxName)) {
      Hive.init((await getApplicationDocumentsDirectory()).path);
    }
    return Hive.openBox<String>(boxName);
  }

  static WFile SETID(WFile wFile) {
    var encode = utf8
        .encode(wFile.title + DateTime.now().toString() + Singleton().getHashCounter().toString());
    var convert = sha1.convert(encode);
    wFile.id = convert.toString();
    return wFile;
  }

  static Future<List<WFile>> loadAllFilesFromFS(List<dynamic> files) async {
    List<WFile> wFiles = [];
    for (String str in files) {
      var wFile = await loadFileFromFS(str);
      wFiles.add(wFile!);
    }

    return wFiles;
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory(); // aus dem Path Provider Package
    if (!(await directory.exists())) {
      directory.create();
    }
    return directory.path;
  }

  static Future<void> putImageToFS({required XFile file}) async {
    final path = await _localPath;

    await file.saveTo(path + file.name);

    // file.writeAsString(mode: FileMode.write, encoding: utf8, flush: false);

    // final File file = (await _localFile(name: 'data.json'));
  }

  static Future<XFile> loadImageFromFS({required String imageName}) async {
    final directory = await _localPath;
    String path = "${directory}/${imageName}";
    var split = path.split("/");
    var xFile = XFile(path + "/$imageName");

    return xFile;
  }
}
