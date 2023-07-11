import 'package:bloc/bloc.dart';
import 'package:mood_habit_tracking_tfg/data/habit.dart';
import 'package:mood_habit_tracking_tfg/data/habit_tracking.dart';
import 'package:mood_habit_tracking_tfg/domain/habit_tracking_repository.dart';

part 'habit_tracking_state.dart';

class HabitTrackingCubit extends Cubit<HabitTrackingState> {
  final HabitTrackingRepository habitTrackingRepository;

  HabitTrackingCubit(this.habitTrackingRepository) : super(HabitTrackingLoading());

  Future<void> addHabitTracking(Habit habit, HabitTracking tracking) async {
    try {
      emit(HabitTrackingLoading(loadingMessage: 'Getting habitTrackings...'));
      final trackings = await habitTrackingRepository.addHabitTracking(habit, tracking);
      emit(HabitTrackingReceived(trackings));
    } catch (e) {
      emit(HabitTrackingError('Error in obtaining habitTrackings: $e.'));
    }
  }
}
