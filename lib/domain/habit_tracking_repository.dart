import 'package:hive/hive.dart';
import 'package:mood_habit_tracking_tfg/data/habit.dart';
import 'package:mood_habit_tracking_tfg/data/habit_tracking.dart';

class HabitTrackingRepository {
  const HabitTrackingRepository();
  
  //addHabitTracking(Habit habit, HabitTracking tracking)
  Future<List<HabitTracking>> addHabitTracking(Habit habit, HabitTracking tracking) async {
    final Box<HabitTracking> habitTrackingBox = await Hive.openBox<HabitTracking>('habitTrackings');
    
    final habitTrackings = habitTrackingBox.values.toList();
    //await habitTrackingBox.close();
    final existingTrackingIndex = habitTrackings.indexWhere((t) => t.habit.name == tracking.habit.name && t.date == tracking.date);
    
    if (existingTrackingIndex != -1) {
      habitTrackingBox.putAt(existingTrackingIndex, tracking);
    } else {
      habitTrackingBox.add(tracking);
    }
    print(habitTrackingBox.values.toList().first.tracking);
    print(habitTrackingBox.values.toList().first.habit.name);
    return habitTrackingBox.values.toList();
    
    //await habitTrackingBox.close();
  }
}