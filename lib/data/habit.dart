import 'package:hive/hive.dart';
import 'package:mood_habit_tracking_tfg/data/habit_tracking.dart';

//para crearlo ejecutar: 
//source ~/.bash_profile (para poder ejecutar comandos flutter)
//flutter packages pub run build_runner build
part 'habit.g.dart';

@HiveType(typeId: 0)
class Habit extends HiveObject {
  
  @HiveField(0)
  final String type;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<String> repeat;

  @HiveField(3)
  final String startDate;

  @HiveField(4)
  final List<int> goal;

  @HiveField(5)
  List<HabitTracking> tracking;

  Habit({
    required this.type,
    required this.name,
    required this.repeat,
    required this.startDate,
    required this.goal,
    required this.tracking
  });
}