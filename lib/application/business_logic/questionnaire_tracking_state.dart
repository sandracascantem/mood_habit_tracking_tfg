part of 'questionnaire_tracking_cubit.dart';

class QuestionnaireTrackingState {
  final List<QuestionnaireTracking> trackings; // Listas de trackings cuestionario
  final String errorMessage; // Mensaje de error (si lo hay)

  const QuestionnaireTrackingState({
    this.trackings = const [], // Valor predeterminado para 'habits'
    this.errorMessage = '', // Valor predeterminado para 'errorMessage'
  });
}

class QuestionnaireTrackingReceived extends QuestionnaireTrackingState {
  final List<QuestionnaireTracking> trackings;

  const QuestionnaireTrackingReceived(List<QuestionnaireTracking> trackings) : trackings = trackings, super(trackings: trackings);
}

class QuestionnaireTrackingLoading extends QuestionnaireTrackingState {
  final String loadingMessage;

  const QuestionnaireTrackingLoading({this.loadingMessage = 'Loading...'});
}

class QuestionnaireTrackingError extends QuestionnaireTrackingState {
  final String errorMessage;

  const QuestionnaireTrackingError(String errorMessage) : errorMessage = errorMessage, super(errorMessage: errorMessage);
}
