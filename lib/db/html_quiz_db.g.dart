// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'html_quiz_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HtmlQuizAdapter extends TypeAdapter<HtmlQuiz> {
  @override
  final int typeId = 5;

  @override
  HtmlQuiz read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HtmlQuiz(
      id: fields[0] as int,
      question: fields[1] as String,
      answer: fields[2] as String,
      options: (fields[3] as List)
          .map((dynamic e) => (e as Map).cast<String, String>())
          .toList(),
      image: fields[4] == null ? '' : fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HtmlQuiz obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.question)
      ..writeByte(2)
      ..write(obj.answer)
      ..writeByte(3)
      ..write(obj.options)
      ..writeByte(4)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HtmlQuizAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
