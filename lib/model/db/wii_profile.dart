import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wii_profile.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class WProfile {
  @HiveField(1)
  @JsonKey(name: "firstname")
  String firstname;
  @HiveField(3)
  @JsonKey(name: "lastname")
  String lastname;
  @HiveField(5)
  @JsonKey(name: "id")
  String id;
  @HiveField(7)
  @JsonKey(name: "email")
  String email;
  @HiveField(9)
  @JsonKey(name: "description")
  String description;
  @HiveField(11)
  @JsonKey(name: "image")
  String image;
  @HiveField(13)
  // @JsonKey(name: "groups")
  // List<dynamic> groups;

  WProfile({
    required this.firstname,
    required this.lastname,
    required this.id,
    required this.email,
    required this.description,
    required this.image,
    // required this.groups,
  });

  factory WProfile.fromJson(Map<String, dynamic> json) => _$WProfileFromJson(json);

  Map<String, dynamic> toJson() => _$WProfileToJson(this);
}
