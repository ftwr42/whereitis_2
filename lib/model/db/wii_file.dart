import 'dart:core';

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wii_file.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class WFile {
  @HiveField(1)
  @JsonKey(name: "title")
  String title;
  @HiveField(3)
  @JsonKey(name: "description")
  String description;
  @HiveField(5)
  @JsonKey(name: "id")
  String id;
  @HiveField(7)
  @JsonKey(name: "auth")
  String auth;
  @HiveField(9)
  @JsonKey(name: "location")
  String location;
  @HiveField(11)
  @JsonKey(name: "image")
  String image;
  @HiveField(13)
  @JsonKey(name: "files")
  List<dynamic> files;

  WFile({
    required this.title,
    required this.description,
    this.id = "",
    required this.auth,
    required this.location,
    required this.image,
    required this.files,
  });

  factory WFile.fromJson(Map<String, dynamic> json) => _$WFileFromJson(json);

  Map<String, dynamic> toJson() => _$WFileToJson(this);
}
