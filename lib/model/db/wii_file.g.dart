// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wii_file.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WFileAdapter extends TypeAdapter<WFile> {
  @override
  final int typeId = 1;

  @override
  WFile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WFile(
      title: fields[1] as String,
      description: fields[3] as String,
      id: fields[5] as String,
      auth: fields[7] as String,
      location: fields[9] as String,
      image: fields[11] as String,
      files: (fields[13] as List).cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, WFile obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.id)
      ..writeByte(7)
      ..write(obj.auth)
      ..writeByte(9)
      ..write(obj.location)
      ..writeByte(11)
      ..write(obj.image)
      ..writeByte(13)
      ..write(obj.files);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WFileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WFile _$WFileFromJson(Map<String, dynamic> json) => WFile(
      title: json['title'] as String,
      description: json['description'] as String,
      id: json['id'] as String? ?? "",
      auth: json['auth'] as String,
      location: json['location'] as String,
      image: json['image'] as String,
      files: json['files'] as List<dynamic>,
    );

Map<String, dynamic> _$WFileToJson(WFile instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'id': instance.id,
      'auth': instance.auth,
      'location': instance.location,
      'image': instance.image,
      'files': instance.files,
    };
