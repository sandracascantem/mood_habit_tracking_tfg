part of 'habit_cubit.dart';

class HabitState {
  final List<Habit> habits; // Lista de hábitos recibidos
  final String errorMessage; // Mensaje de error (si lo hay)

  const HabitState({
    this.habits = const [], // Valor predeterminado para 'habits'
    this.errorMessage = '', // Valor predeterminado para 'errorMessage'
  });
}

class HabitReceived extends HabitState {
  final List<Habit> habits;

  const HabitReceived(List<Habit> habits) : habits = habits, super(habits: habits);
}

class HabitLoading extends HabitState {
  final String loadingMessage;

  const HabitLoading({this.loadingMessage = 'Loading...'});
}

class HabitError extends HabitState {
  final String errorMessage;

  const HabitError(String errorMessage) : errorMessage = errorMessage, super(errorMessage: errorMessage);
}
