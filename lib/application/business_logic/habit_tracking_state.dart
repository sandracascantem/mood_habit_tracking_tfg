part of 'habit_tracking_cubit.dart';

class HabitTrackingState {
  final List<HabitTracking> trackings; // Lista de hábitos recibidos
  final String errorMessage; // Mensaje de error (si lo hay)

  const HabitTrackingState({
    this.trackings = const [], // Valor predeterminado para 'habits'
    this.errorMessage = '', // Valor predeterminado para 'errorMessage'
  });
}

class HabitTrackingReceived extends HabitTrackingState {
  final List<HabitTracking> trackings;

  const HabitTrackingReceived(List<HabitTracking> trackings) : trackings = trackings, super(trackings: trackings);
}

class HabitTrackingLoading extends HabitTrackingState {
  final String loadingMessage;

  const HabitTrackingLoading({this.loadingMessage = 'Loading...'});
}

class HabitTrackingError extends HabitTrackingState {
  final String errorMessage;

  const HabitTrackingError(String errorMessage) : errorMessage = errorMessage, super(errorMessage: errorMessage);
}
