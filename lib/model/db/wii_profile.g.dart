// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wii_profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WProfileAdapter extends TypeAdapter<WProfile> {
  @override
  final int typeId = 1;

  @override
  WProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WProfile(
      firstname: fields[1] as String,
      lastname: fields[3] as String,
      id: fields[5] as String,
      email: fields[7] as String,
      description: fields[9] as String,
      image: fields[11] as String,
      // groups: (fields[13] as List).cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, WProfile obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.firstname)
      ..writeByte(3)
      ..write(obj.lastname)
      ..writeByte(5)
      ..write(obj.id)
      ..writeByte(7)
      ..write(obj.email)
      ..writeByte(9)
      ..write(obj.description)
      ..writeByte(11)
      ..write(obj.image)
      ..writeByte(13);
    // ..write(obj.groups);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WProfileAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WProfile _$WProfileFromJson(Map<String, dynamic> json) => WProfile(
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      id: json['id'] as String,
      email: json['email'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      // groups: json['groups'] as List<dynamic>,
    );

Map<String, dynamic> _$WProfileToJson(WProfile instance) => <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'id': instance.id,
      'email': instance.email,
      'description': instance.description,
      'image': instance.image,
      // 'groups': instance.groups,
    };
