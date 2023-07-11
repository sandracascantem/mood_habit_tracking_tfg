import 'package:hive/hive.dart';
import 'package:mood_habit_tracking_tfg/core/functions/functions.dart';
import 'package:mood_habit_tracking_tfg/data/habit.dart';
import 'package:mood_habit_tracking_tfg/data/habit_tracking.dart';
import 'package:collection/collection.dart';
import 'package:mood_habit_tracking_tfg/domain/habit_tracking_repository.dart';

class HabitRepository {
  const HabitRepository();

  //getHabits()
  Future<List<Habit>> getHabits() async {
    final Box<Habit> box = await Hive.openBox<Habit>('habits');
    List<Habit> habitList = box.values.toList();
    return habitList;
  }

  //getHabitsDay(Datetime day)
  Future<List<Habit>> getHabitsDay(DateTime day) async {
    final Box<Habit> box = await Hive.openBox<Habit>('habits');
    final List<Habit> habits = box.values.toList();
    List<Habit> habitsOfDay = [];
    for (Habit habit in habits) {
      if (habit.repeat.isEmpty) {  //ha funcionado
        //el habito no se repite, solo aparecerá el dia de la fecha de inicio
        DateTime fecha = DateTime.parse(habit.startDate);  //se transforma a tipo DateTime
        if (isAtSameDayAs(day, fecha)) {
          habitsOfDay.add(habit);
        }
      } else if (habit.repeat.contains('Monday') ||     //ha funcionado
                  habit.repeat.contains('Tuesday') ||
                  habit.repeat.contains('Wednesday') ||
                  habit.repeat.contains('Thursday') ||
                  habit.repeat.contains('Friday') ||
                  habit.repeat.contains('Saturday') ||
                  habit.repeat.contains('Sunday')) {
        //puede aparecer los Monday, Tuesday... pero solo segun dias de la semana
        if(day.weekday == 1) {  //guarda Monday
          if(habit.repeat.contains('Monday')) {
            habitsOfDay.add(habit);
          }
        } else if(day.weekday == 2) { 
          if(habit.repeat.contains('Tuesday')) {
            habitsOfDay.add(habit);
          }
        } else if(day.weekday == 3) { 
          if(habit.repeat.contains('Wednesday')) {
            habitsOfDay.add(habit);
          }
        } else if(day.weekday == 4) { 
          if(habit.repeat.contains('Thursday')) {
            habitsOfDay.add(habit);
          }
        } else if(day.weekday == 5) { 
          if(habit.repeat.contains('Friday')) {
            habitsOfDay.add(habit);
          }
        } else if(day.weekday == 6) { 
          if(habit.repeat.contains('Saturday')) {
            habitsOfDay.add(habit);
          }
        } else if(day.weekday == 7) { 
          if(habit.repeat.contains('Sunday')) {
            habitsOfDay.add(habit);
          }
        }
        
        //puede aparecer fechas concretas
        //puede aparecer según 1 intervalo
      } else if (habit.repeat.contains('Every 2 days') || 
                  habit.repeat.contains('Every 3 days') ||
                  habit.repeat.contains('Every 4 days') ||
                  habit.repeat.contains('Every 5 days') ||
                  habit.repeat.contains('Every 6 days') ||
                  habit.repeat.contains('Every 2 weeks') ||
                  habit.repeat.contains('Every 3 weeks') ||
                  habit.repeat.contains('Every month') ||
                  habit.repeat.contains('Every 2 months') ||
                  habit.repeat.contains('Every 3 months')) {
        DateTime fecha = DateTime.parse(habit.startDate);  //se transforma a tipo DateTime
        if(isAtSameDayAs(day, fecha)) {
          habitsOfDay.add(habit);
        } else if(habit.repeat.contains('Every 2 days')) {
          fecha = DateTime.parse(habit.startDate);
          for (fecha; fecha.isBefore(day); fecha = fecha.add(Duration(days: 2))) {
            if(isAtSameDayAs(day, fecha)) {
              habitsOfDay.add(habit);
              break;
            }
          }
        } else if(habit.repeat.contains('Every 3 days')) {
          fecha = DateTime.parse(habit.startDate);
          for (fecha; fecha.isBefore(day); fecha = fecha.add(Duration(days: 3))) {
            if(isAtSameDayAs(day, fecha)) {
              habitsOfDay.add(habit);
              break;
            }
          }
        } else if(habit.repeat.contains('Every 4 days')) {
          fecha = DateTime.parse(habit.startDate);
          for (fecha; fecha.isBefore(day); fecha = fecha.add(Duration(days: 4))) {
            if(isAtSameDayAs(day, fecha)) {
              habitsOfDay.add(habit);
              break;
            }
          }
        } else if(habit.repeat.contains('Every 5 days')) {
          fecha = DateTime.parse(habit.startDate);
          for (fecha; fecha.isBefore(day); fecha = fecha.add(Duration(days: 5))) {
            if(isAtSameDayAs(day, fecha)) {
              habitsOfDay.add(habit);
              break;
            }
          }
        } else if(habit.repeat.contains('Every 6 days')) {
          fecha = DateTime.parse(habit.startDate);
          for (fecha; fecha.isBefore(day); fecha = fecha.add(Duration(days: 6))) {
            if(isAtSameDayAs(day, fecha)) {
              habitsOfDay.add(habit);
              break;
            }
          }
        } else if(habit.repeat.contains('Every 2 weeks')) {
          fecha = DateTime.parse(habit.startDate);
          for (fecha; fecha.isBefore(day); fecha = fecha.add(Duration(days: 14))) {
            if(isAtSameDayAs(day, fecha)) {
              habitsOfDay.add(habit);
              break;
            }
          }
        } else if(habit.repeat.contains('Every 3 weeks')) {
          fecha = DateTime.parse(habit.startDate);
          for (fecha; fecha.isBefore(day); fecha = fecha.add(Duration(days: 21))) {
            if(isAtSameDayAs(day, fecha)) {
              habitsOfDay.add(habit);
              break;
            }
          }
        } else if(habit.repeat.contains('Every month')) {
          fecha = DateTime.parse(habit.startDate);
          while (fecha.isBefore(day)) {
            if (isAtSameDayAs(day, fecha)) {
              habitsOfDay.add(habit);
              break;
            }
            int days = daysInOneMonth(fecha);
            fecha = fecha.add(Duration(days: days));
          }
        } else if(habit.repeat.contains('Every 2 months')) {
          fecha = DateTime.parse(habit.startDate);
          while (fecha.isBefore(day)) {
            if (isAtSameDayAs(day, fecha)) {
              habitsOfDay.add(habit);
              break;
            }
            int days = daysInTwoMonth(fecha);
            fecha = fecha.add(Duration(days: days));
          }
        } else if(habit.repeat.contains('Every 3 months')) {
          fecha = DateTime.parse(habit.startDate);
          while (fecha.isBefore(day)) {
            if (isAtSameDayAs(day, fecha)) {
              habitsOfDay.add(habit);
              break;
            }
            int days = daysInThreeMonth(fecha);
            fecha = fecha.add(Duration(days: days));
          }
        }
      } else {  //ha funcionado (la fecha de inicio en este caso no se tiene en cuenta, solo los dias seleccionados en el calendario)
        for(String element in habit.repeat) {
          DateTime elemento = DateTime.parse(element);
          if(isAtSameDayAs(day, elemento)) {
            habitsOfDay.add(habit);
          }
        }
      }
    }
    await box.close();
    return habitsOfDay;
  }

  //addHabit(Habit habit)
  Future<void> addHabit(Habit habit) async {
    final Box<Habit> box = await Hive.openBox<Habit>('habits');
    await box.add(habit);
    await box.close();
  }

  //deleteHabit(Habit habit)
  Future<void> deleteHabit(Habit habit) async {
    final Box<Habit> box = await Hive.openBox<Habit>('habits');
    await box.delete(habit.key);
    await box.close();
  }

  //addTracking(Habit habit, HabitTracking tracking)
  Future<void> addTracking(Habit habit, HabitTracking habitTracking) async {
    HabitTrackingRepository habitTrackingRepository = HabitTrackingRepository();
    final List<HabitTracking> trackings = await habitTrackingRepository.addHabitTracking(habit, habitTracking);
    print(trackings);

    final updatedHabit = Habit(
      type: habit.type,
      name: habit.name,
      repeat: habit.repeat,
      startDate: habit.startDate,
      goal: habit.goal,
      tracking: trackings
      ); // Crea una nueva instancia de Habit

    final Box<Habit> habitBox = await Hive.openBox<Habit>('habits');
    final habitKey =
        habitBox.values.firstWhereOrNull((h) => habitEquals(h, habit))?.key;

    if (habitKey != null) {
      await habitBox.put(habitKey, updatedHabit); // Usa la nueva instancia de Habit
    }
    await habitBox.close();
  }


  bool habitEquals(Habit habit1, Habit habit2) {
    return habit1.name == habit2.name;
  }


}
