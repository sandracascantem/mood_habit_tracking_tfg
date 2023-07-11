// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questionnaire_tracking.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionnaireTrackingAdapter extends TypeAdapter<QuestionnaireTracking> {
  @override
  final int typeId = 2;

  @override
  QuestionnaireTracking read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionnaireTracking(
      id_questionnaire: fields[0] as int,
      date: fields[1] as String,
      answers: (fields[2] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, QuestionnaireTracking obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id_questionnaire)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.answers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionnaireTrackingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
