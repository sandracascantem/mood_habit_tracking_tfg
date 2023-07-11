part of 'questionnaire_cubit.dart';

class QuestionnaireState {
  final Questionnaire? questionnaire; // Lista de hábitos recibidos
  final String errorMessage; // Mensaje de error (si lo hay)
  final List<int> ids;

  const QuestionnaireState({
    this.questionnaire, // Valor predeterminado para 'habits'
    this.errorMessage = '', // Valor predeterminado para 'errorMessage'
    this.ids = const [],
  });
}

class QuestionnaireReceived extends QuestionnaireState {
  final Questionnaire questionnaire;

  const QuestionnaireReceived(Questionnaire questionnaire) : questionnaire = questionnaire, super(questionnaire: questionnaire);
}


class QuestionnaireLoading extends QuestionnaireState {
  final String loadingMessage;

  const QuestionnaireLoading({this.loadingMessage = 'Loading...'});
}

class QuestionnaireError extends QuestionnaireState {
  final String errorMessage;

  const QuestionnaireError(String errorMessage) : errorMessage = errorMessage, super(errorMessage: errorMessage);
}
