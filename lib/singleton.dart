import 'dart:core';

import 'package:get/get.dart';
import 'package:whereitis_2/handle_stores.dart';
import 'package:whereitis_2/model/db/settings.dart';
import 'package:whereitis_2/model/db/wii_profile.dart';

import 'model/db/wii_file.dart';

class Singleton {
  //for safety this singleton only holds the data which is stored on phone and this how the
  //the singleton only holds real world data how i call it

  static final Singleton _singleton = Singleton._internal();

  Rx<WFile>? rxRoot;
  Rx<WProfile>? rxProfile;
  Rx<WSettings>? rxSettings;
  Rx<WFile>? setActiveStore;
  Rx<HandleStores>? rxHandleStores;

  int _hashCounter = 42;

  RxBool? setCheck;

  int getHashCounter() {
    return _hashCounter++;
  }

  factory Singleton() {
    return _singleton;
  }

  Singleton._internal();
}
