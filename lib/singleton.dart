import 'dart:core';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:whereitis_2/model/db/wii_profile.dart';

import 'model/db/wii_file.dart';

class Singleton {
  //for safety this singleton only holds the data which is stored on phone and this how the
  //the singleton only holds real world data how i call it

  static final Singleton _singleton = Singleton._internal();

  late Rx<WFile> rxRoot;
  late Rx<WProfile> rxProfile;
  late Rx<WFile> rxActive;

  late BoxCollection collection;

  factory Singleton() {
    return _singleton;
  }

  Singleton._internal() {
    //DBTool.createDefaults();

    rxRoot =
        WFile(title: "", description: "", location: "", id: "", image: "", files: [], auth: '').obs;
  }
}
