import 'dart:core';

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:whereitis_2/model/db/wii_file.dart';

part 'settings.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class WSettings {
  late WFile active;
}
