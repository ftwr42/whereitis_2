import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:hive/hive.dart';
import 'package:whereitis_2/model/db/wii_file.dart';
import 'package:whereitis_2/model/db/wii_profile.dart';
import 'package:whereitis_2/singleton.dart';

class DBTool {
  static const String DBNAME = "WIIDB";
  static const String PROFILENAME = "profiles";
  static const String FILENAME = "files";
  static const String PATH = "./where_it_is";
  static const String ROOTKEY = "root";

  static Future<dynamic>? loadProfileFromFs() async {
    var collection = await BoxCollection.open(
      DBNAME, // Name of your database
      {FILENAME, PROFILENAME}, // Names of your boxes
      path: PATH, // Path where to store your boxes (Only used in Flutter / Dart IO)
      // key: HiveCipher(), // Key to encrypt your boxes (Only used in Flutter / Dart IO)
    );

    var profilesBox = await collection.openBox<String>(PROFILENAME);

    return await profilesBox.get('root');
    // print("---------->" + rootP!);
    // Singleton().rxProfile = WProfile.fromJson(jsonDecode(rootP)).obs;
    // print("##### ${Singleton().rxProfile.value.firstname})");

    return profilesBox;
  }

  static Future<dynamic>? loadFileFromFs() async {
    BoxCollection collection = await BoxCollection.open(
      DBNAME, // Name of your database
      {FILENAME, PROFILENAME}, // Names of your boxes
      path: PATH, // Path where to store your boxes (Only used in Flutter / Dart IO)
      // key: HiveCipher(), // Key to encrypt your boxes (Only used in Flutter / Dart IO)
    );

    var filesBox = await collection.openBox<String>(FILENAME);

    // var rootF = await filesBox.get('root');
    // print("---------->" + rootF!);
    // Singleton().rxRoot = WFile.fromJson(jsonDecode(rootF)).obs;
    // print("##### ${Singleton().rxRoot.value.title})");

    return filesBox;
  }

  static Future<List<Rx<WFile>>> instanceFiles(WFile wFile) async {
    BoxCollection collection = await BoxCollection.open(
      DBNAME, // Name of your database
      {FILENAME, PROFILENAME}, // Names of your boxes
      path: PATH, // Path where to store your boxes (Only used in Flutter / Dart IO)
      // key: HiveCipher(), // Key to encrypt your boxes (Only used in Flutter / Dart IO)
    );

    var filesBox = await collection.openBox<String>(FILENAME);

    if (wFile.auth.startsWith("d")) {
      if (wFile.filesObj.isNotEmpty) {
        return wFile.filesObj;
      } else {
        for (String key in wFile.files) {
          var future = await filesBox.get(key);
          var encode = jsonDecode(future!);
          wFile.filesObj.add(WFile.fromJson(encode).obs);
        }
      }
    }
    return wFile.filesObj;
  }

  static void createDefaults() async {
    final collection = await BoxCollection.open(
      DBNAME, // Name of your database
      {FILENAME, PROFILENAME}, // Names of your boxes
      path: PATH, // Path where to store your boxes (Only used in Flutter / Dart IO)
      // key: HiveCipher(), // Key to encrypt your boxes (Only used in Flutter / Dart IO)
    );

    var root = WFile(
        title: "root",
        description: "root",
        id: "root",
        auth: "drwxrwxrwx",
        location: "root",
        image: "root",
        files: ["chickid"]);
    var storeChicken = WFile(
        title: "Chicken Store",
        description: "has hot chickens",
        id: "chickid",
        auth: "drwxrwxrwx",
        location: "west side",
        image: "chicken",
        files: ["friedid"]);
    var itemChicken = WFile(
        title: "Fried Chicken",
        description: "crusty and fatty",
        id: "friedid",
        auth: "irwxrwxrwx",
        location: "bun",
        image: "chickenfried",
        files: []);

    var wProfile = WProfile(
        firstname: "Samsi",
        lastname: "Baked",
        id: "root",
        email: "sams@hot.de",
        description: "is an admin",
        image: "samsywbi");

    // var encode = utf8.encode(wProfile.firstname + DateTime.now().millisecondsSinceEpoch.toString());
    // var convert = sha1.convert(encode).toString();
    // wProfile.id = convert;

    var profilesBox = await collection.openBox<String>(PROFILENAME);

    var json = jsonEncode(wProfile.toJson());
    await profilesBox.put('root', json.toString());

    var future = await profilesBox.get('root');

    //----------------

    var filesBox = await collection.openBox<String>(FILENAME);

    var json2 = root.toJson();
    var jsonEncode2 = jsonEncode(json2);
    var string = jsonEncode2.toString();
    filesBox.put(root.id, string);

    filesBox.put(storeChicken.id, jsonEncode(storeChicken.toJson()).toString());
    filesBox.put(itemChicken.id, jsonEncode(itemChicken.toJson()).toString());
  }

  static Future<Rx<WFile>> loadRootFromFs() async {
    BoxCollection collection = await BoxCollection.open(
      DBNAME, // Name of your database
      {FILENAME, PROFILENAME}, // Names of your boxes
      path: PATH, // Path where to store your boxes (Only used in Flutter / Dart IO)
      // key: HiveCipher(), // Key to encrypt your boxes (Only used in Flutter / Dart IO)
    );

    var filesBox = await collection.openBox<String>(FILENAME);
    var future = await filesBox.get('root');
    var encode = jsonDecode(future!);
    var obs = WFile.fromJson(encode).obs;
    Singleton().rxRoot = obs;

    instanceFiles(obs.value);

    return obs;
  }

  // static _putDefaultProfile() async {
  //   // Create a box collection
  //   final collection = await BoxCollection.open(
  //     DBNAME, // Name of your database
  //     {PROFILENAME, FILENAME}, // Names of your boxes
  //     path: PATH, // Path where to store your boxes (Only used in Flutter / Dart IO)
  //     // key: HiveCipher(), // Key to encrypt your boxes (Only used in Flutter / Dart IO)
  //   );
  //
  //   var wProfile = WProfile(
  //     firstname: "samira",
  //     lastname: "Baecker",
  //     id: "abc",
  //     email: "sbbecker.de",
  //     description: "015255492508",
  //     image: "null",
  //     // groups: ["admin"],
  //   );
  //
  //   var encode = utf8.encode(wProfile.firstname + DateTime.now().millisecondsSinceEpoch.toString());
  //   var convert = sha1.convert(encode).toString();
  //
  //   print("-------->" + collection.boxNames.toString());
  //   var profiles = await collection.openBox<String>(PROFILENAME);
  //   var json = jsonEncode(wProfile.toJson());
  //   await profiles.put(convert, json.toString());
  //   var other = await profiles.get(convert);
  //   print("===========>" + other.toString());
  // }
  //
  // static createDefaultStore(WFile root) async {
  //   // Create a box collection
  //   final collection = await BoxCollection.open(
  //     DBNAME, // Name of your database
  //     {PROFILENAME, FILENAME}, // Names of your boxes
  //     path: PATH, // Path where to store your boxes (Only used in Flutter / Dart IO)
  //     // key: HiveCipher(), // Key to encrypt your boxes (Only used in Flutter / Dart IO)
  //   );
  //
  //   var encode = utf8.encode("Store Chicken" + DateTime.now().millisecondsSinceEpoch.toString());
  //   var convert = sha1.convert(encode).toString();
  //
  //   var wFile = WFile(
  //       title: "Store Chicken",
  //       description: "Sells hot Chicken",
  //       id: convert,
  //       auth: "drwxrwxrwx",
  //       location: "Chickenland",
  //       image: "chicken",
  //       files: []);
  //
  //   root.files.add(convert);
  //
  //   print("-------->" + collection.boxNames.toString());
  //   var profiles = await collection.openBox<String>(FILENAME);
  //   var json = jsonEncode(wFile.toJson());
  //   await profiles.put(convert, json.toString());
  //   var other = await profiles.get(convert);
  //   print("===========>" + other.toString());
  // }
  //
  // static Future<List<WProfile>> loadProfilesFromFS() async {
  //   // _putDefaultProfile();
  //   final collection = await BoxCollection.open(
  //     DBNAME, // Name of your database
  //     {PROFILENAME, FILENAME}, // Names of your boxes
  //     path: PATH, // Path where to store your boxes (Only used in Flutter / Dart IO)
  //     // key: HiveCipher(), // Key to encrypt your boxes (Only used in Flutter / Dart IO)
  //   );
  //
  //   var profiles = await collection.openBox<String>(PROFILENAME);
  //   var allKeys = await profiles.getAllKeys();
  //
  //   List<WProfile> plist = [];
  //   int i = 0;
  //
  //   allKeys.forEach((key) async {
  //     String? p = await profiles.get(key);
  //     if (p != null) {
  //       i++;
  //       print("$i. $p");
  //       Map<String, dynamic> to = jsonDecode(p);
  //       var wProfile2 = WProfile.fromJson(to);
  //       plist.add(wProfile2);
  //     }
  //   });
  //
  //   return plist;
  // }
  //
  // static Future<List<WProfile>> loadFilesFromFS() async {
  //   final collection = await BoxCollection.open(
  //     DBNAME, // Name of your database
  //     {PROFILENAME, FILENAME}, // Names of your boxes
  //     path: PATH, // Path where to store your boxes (Only used in Flutter / Dart IO)
  //     // key: HiveCipher(), // Key to encrypt your boxes (Only used in Flutter / Dart IO)
  //   );
  //
  //   var openBox = await collection.openBox<String>(FILENAME);
  //   var list = await openBox.getAllKeys();
  //   String? root = await openBox.get(ROOTKEY);
  //
  //   if (root == null) {
  //     var wFile = WFile(
  //         title: "root",
  //         description: "root",
  //         id: "root",
  //         auth: "drwxrwxrwx",
  //         location: "root",
  //         image: "root",
  //         files: []);
  //     openBox.put(ROOTKEY, jsonEncode(wFile.toJson()));
  //
  //     root = await openBox.get(ROOTKEY);
  //
  //     // _putDefaultStore(wFile);
  //   }
  //
  //   List<WProfile> plist = [];
  //
  //   return plist;
  // }
}
