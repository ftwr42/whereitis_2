import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whereitis_2/model/db/wii_file.dart';
import 'package:whereitis_2/model/db/wii_profile.dart';
import 'package:whereitis_2/project/assets_images.dart';

import '../singleton.dart';

class DBTool {
  static const String DBNAME = "WIIDB";
  static const String PROFILENAME = "profiles";
  static const String FILENAME = "files";
  static const String PATH = "./where_it_is";
  static const String ROOTKEY = "root";

  static clearAll() async {
    var fileBox = await openHiveBox(FILENAME);
    fileBox.clear();
    var profileBox = await openHiveBox(PROFILENAME);
    profileBox.clear();
  }

  static putDefaults() async {
    var rootFile = WFile(
      title: "root",
      description: "root",
      id: "root",
      auth: "drwxrwxrwx",
      location: "root",
      image: "root",
      files: ["storeaid", "storebid"],
    );
    var storeA = WFile(
      title: "Store A",
      description: "Stores Chickens",
      id: "storeaid",
      auth: "drwxrwxrwx",
      location: "chicken land",
      image: AssetsImages.PLACEHOLDER_STORE,
      files: ["chickenbunid", "chickenwingid"],
    );
    var storeABun = WFile(
      title: "Chicken Bun",
      description: "holds a box of chicken pieces",
      id: "chickenbunid",
      auth: "drwxrwxrwx",
      location: "in chicken store",
      image: AssetsImages.PLACEHOLDER_CONTAINER,
      files: ["chickenpiecesid"],
    );
    var storeAChickenWing = WFile(
      title: "Chicken Wing",
      description: "crusty and jammy",
      id: "chickenwingid",
      auth: "irwxrwxrwx",
      location: "in chicken store",
      image: AssetsImages.PLACEHOLDER_ITEM,
      files: [],
    );
    var storeAPiece = WFile(
      title: "Chicken Pieces",
      description: "pieces of chicken",
      id: "chickenpiecesid",
      auth: "irwxrwxrwx",
      location: "in a bun",
      image: AssetsImages.PLACEHOLDER_ITEM,
      files: [],
    );

    var storeB = WFile(
      title: "Store B",
      description: "Stores Dogs",
      id: "storebid",
      auth: "drwxrwxrwx",
      location: "dogs land",
      image: AssetsImages.PLACEHOLDER_STORE,
      files: ["cutedogid"],
    );
    var storeBdog = WFile(
      title: "cute Dog",
      description: "A cute little dog",
      id: "cutedogid",
      auth: "irwxrwxrwx",
      location: "in the dog shop",
      image: AssetsImages.PLACEHOLDER_ITEM,
      files: [],
    );

    var fileBox = await openHiveBox(FILENAME);
    fileBox.put("root", rootFile.toJson());
    Rx<WFile> rxRoot = rootFile.obs;
    Singleton().rxRoot = rxRoot;

    putFile(storeA, rxRoot);
    putFile(storeABun, rxRoot);
    putFile(storeAPiece, storeABun.obs);
    putFile(storeAChickenWing, rxRoot);

    Rx<WFile> rxStoreB = storeB.obs;
    putFile(storeBdog, rxStoreB);

    var wProfile = WProfile(
      firstname: "Jan",
      lastname: "Freirich",
      id: "jfid",
      email: "jf@gmail.com",
      description: "admin",
      image: AssetsImages.PLACEHOLDER_PROFILE,
    );

    Singleton().rxProfile = wProfile.obs;
    await putProfile(wProfile);
  }

  static putProfile(WProfile wProfile) async {
    var filesBox = await openHiveBox(PROFILENAME);
    var json = wProfile.toJson();
    filesBox.put('root', json);
  }

  static Future<void> printAllFiles() async {
    var fileBox = await openHiveBox(FILENAME);
    var profileBox = await openHiveBox(PROFILENAME);

    print("PRINT_ALL_FILES keys=${fileBox.keys}");

    int i = 0;
    for (String key in fileBox.keys) {
      var wFile = await loadFileFromFS(key);
      print("\t${++i < 9 ? " " : ""}$i. ${wFile?.toJson()}");
    }
  }

  static Future<dynamic> loadProfileFromFs() async {
    var profilesBox = await openHiveBox(PROFILENAME);

    var getProfile = await _getProfile(profilesBox, 'root');

    return getProfile;
  }

  static Future<Rx<WFile>> loadProfileAndRootSafeToSingletonAndReturnRoot() async {
    var profile = await loadProfileFromFs();
    Singleton().rxProfile = profile.obs;

    var rootFile = await loadFileFromFS('root');
    Rx<WFile> rxRoot;
    if (rootFile == null) {
      rootFile = WFile(
          title: "root",
          description: "root",
          id: "root",
          auth: "drwxrwxrwx",
          location: "root",
          image: "root",
          files: []);
      WFile storeFile = SETID(WFile(
          title: "Store",
          description: "default store",
          auth: "drwxrwxrwx",
          location: "store location",
          image: AssetsImages.PLACEHOLDER_STORE,
          files: []));

      var fileBox = await openHiveBox(FILENAME);
      fileBox.put("root", rootFile.toJson());
      rxRoot = rootFile.obs;
      putFile(storeFile, rxRoot);
    } else {
      rxRoot = rootFile.obs;
    }

    Singleton().rxRoot = rxRoot;

    return rxRoot;
  }

  static Future<WFile?> loadFileFromFS(String key) async {
    var fileBox = await openHiveBox(FILENAME);

    var root = await fileBox.get(key);

    if (root == null) {
      return null;
    }

    var wFile = WFile.fromJson(root);
    return wFile;
  }

  static putFile(WFile wFile, Rx<WFile> parent) async {
    var openBox = await openHiveBox(FILENAME);

    var getFile = await loadFileFromFS(wFile.id);

    var json = wFile.toJson();
    openBox.put(wFile.id, jsonDecode(json.toString()));

    if (getFile == null) {
      _addToLists(wFile, parent);
    }
  }

  static _addToLists(WFile wFile, Rx<WFile> parent) {
    parent.value.files.add(wFile.id);
    parent.refresh();
  }

  static Future<WProfile?> _getProfile(Box<dynamic> box, String key) async {
    var string = await box.get(key);

    if (string == null) {
      return null;
    }

    var decode = jsonDecode(string);
    var wProfile = WProfile.fromJson(decode);
    return wProfile;
  }

  static Future<Box> openHiveBox(String boxName) async {
    if (!kIsWeb && !Hive.isBoxOpen(boxName))
      Hive.init((await getApplicationDocumentsDirectory()).path);

    return await Hive.openBox(boxName);
  }

  static WFile SETID(WFile wFile) {
    var encode = utf8
        .encode(wFile.title + DateTime.now().toString() + Singleton().getHashCounter().toString());
    var convert = sha1.convert(encode);
    wFile.id = convert.toString();
    return wFile;
  }
}
