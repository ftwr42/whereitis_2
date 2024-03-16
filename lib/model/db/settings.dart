// To parse this JSON data, do
//
//     final wSettings = wSettingsFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'settings.g.dart';

WSettings wSettingsFromJson(String str) => WSettings.fromJson(json.decode(str));

String wSettingsToJson(WSettings data) => json.encode(data.toJson());

@JsonSerializable()
class WSettings {
  @JsonKey(name: "activeStore")
  String activeStore;

  WSettings({
    required this.activeStore,
  });

  factory WSettings.fromJson(Map<String, dynamic> json) => _$WSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$WSettingsToJson(this);
}
