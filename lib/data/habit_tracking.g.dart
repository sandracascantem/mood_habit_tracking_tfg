// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_tracking.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitTrackingAdapter extends TypeAdapter<HabitTracking> {
  @override
  final int typeId = 1;

  @override
  HabitTracking read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitTracking(
      date: fields[0] as String,
      habit: fields[1] as Habit,
      tracking: (fields[2] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, HabitTracking obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.habit)
      ..writeByte(2)
      ..write(obj.tracking);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitTrackingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
