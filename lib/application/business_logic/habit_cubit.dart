import 'package:bloc/bloc.dart';
import 'package:mood_habit_tracking_tfg/data/habit.dart';
import 'package:mood_habit_tracking_tfg/data/habit_tracking.dart';
import 'package:mood_habit_tracking_tfg/domain/habit_repository.dart';

part 'habit_state.dart';

class HabitCubit extends Cubit<HabitState> {
  final HabitRepository habitRepository;

  HabitCubit(this.habitRepository) : super(HabitLoading());

  Future<List<Habit>> getHabits() async {
    try {
      emit(HabitLoading(loadingMessage: 'Getting habits...'));
      final habits = await habitRepository.getHabits();
      emit(HabitReceived(habits));
      return habits;
    } catch (e) {
      emit(HabitError('Error in obtaining habits: $e.'));
      throw e; // Relanza el error para que pueda ser capturado en el lugar adecuado
    }
  }
  Future<void> addHabit(Habit habit) async {
    try {
      await habitRepository.addHabit(habit);
      emit(HabitLoading(loadingMessage: 'Getting habits...'));
      final habits = await habitRepository.getHabits();
      emit(HabitReceived(habits));
    } catch (e) {
      emit(HabitError('Error in creating habits: $e.'));
    }
  }

  Future<void> deleteHabit(Habit habit) async {
    try {
      await habitRepository.deleteHabit(habit);
      emit(HabitLoading(loadingMessage: 'Getting habits...'));
      final habits = await habitRepository.getHabits();
      emit(HabitReceived(habits));
    } catch (e) {
      emit(HabitError('Error in creating habits: $e.'));
    }
  }

  Future<void> getHabitsDay(DateTime day) async {
    try {
      emit(HabitLoading(loadingMessage: 'Getting habits...'));
      final habits = await habitRepository.getHabitsDay(day);
      emit(HabitReceived(habits));
    } catch (e) {
      emit(HabitError('Error in creating habits: $e.'));
    }
  }

  Future<void> addTracking(Habit habit, HabitTracking habitTracking) async {
    try {
      await habitRepository.addTracking(habit, habitTracking);
      emit(HabitLoading(loadingMessage: 'Getting habits...'));
      final habits = await habitRepository.getHabitsDay(DateTime.now());
      emit(HabitReceived(habits));
    } catch (e) {
      emit(HabitError('Error in creating habits: $e.'));
    }
  }

}
