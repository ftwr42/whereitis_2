import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:whereitis_2/model/db/wii_profile.dart';

class DBTool {
  static Future<List<WProfile>> loadProfilesFromFS() async {
    // Create a box collection
    final collection = await BoxCollection.open(
      'MyFirstFluffyBox', // Name of your database
      {'profiles', 'files'}, // Names of your boxes
      path: './', // Path where to store your boxes (Only used in Flutter / Dart IO)
      // key: HiveCipher(), // Key to encrypt your boxes (Only used in Flutter / Dart IO)
    );

    var wProfile = WProfile(
      firstname: "Samira",
      lastname: "Baecker",
      id: "abc",
      email: "sbbecker.de",
      description: "015255492508",
      image: "null",
      // groups: ["admin"],
    );

    print("-------->" + collection.boxNames.toString());
    var profiles = await collection.openBox<String>('profiles');
    profiles.clear();
    var json = wProfile.toJson();
    await profiles.put('janeeisklar2', json.toString());
    var other = await profiles.get('janeeisklar2');
    print("===========>" + other.toString());

    var allKeys = await profiles.getAllKeys();

    List<WProfile> plist = [];

    int i = 0;

    allKeys.forEach((key) async {
      i++;
      String? p = await profiles.get(key);
      if (p != null) {
        print("$i. $p");
        String jsonStringWithQuotes =
            p.replaceAllMapped(RegExp(r'(\w+):'), (Match match) => '"${match.group(1)}":');

        jsonStringWithQuotes.removeAllWhitespace;
        print("object $jsonStringWithQuotes");

        Map<String, dynamic> to = jsonDecode(jsonStringWithQuotes);

        // var wProfile = WProfile.fromJson(p);
        //plist.add(wProfile);
      }
    });

    return plist;
  }
}
