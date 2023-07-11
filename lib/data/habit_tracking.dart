import 'package:hive/hive.dart';
import 'package:mood_habit_tracking_tfg/data/habit.dart';

//para crearlo ejecutar: 
//source ~/.bash_profile (para poder ejecutar comandos flutter)
//flutter packages pub run build_runner build
part 'habit_tracking.g.dart';

@HiveType(typeId: 1)
class HabitTracking extends HiveObject{

  @HiveField(0)
  final String date;

  @HiveField(1)
  Habit habit;

  @HiveField(2)
  Map<String, dynamic> tracking;

  HabitTracking({
    required this.date,
    required this.habit,
    required this.tracking
  });
}