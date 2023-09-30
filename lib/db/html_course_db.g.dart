// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'html_course_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HtmlCourseAdapter extends TypeAdapter<HtmlCourse> {
  @override
  final int typeId = 1;

  @override
  HtmlCourse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HtmlCourse(
      id: fields[0] as int,
      title: fields[1] as String,
      description: fields[2] as String,
      progressMateri: fields[3] == null ? 0 : fields[3] as int,
      progressInteraktif:
          fields[4] == null ? [0] : (fields[4] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, HtmlCourse obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.progressMateri)
      ..writeByte(4)
      ..write(obj.progressInteraktif);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HtmlCourseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
