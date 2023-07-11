import 'package:bloc/bloc.dart';
import 'package:mood_habit_tracking_tfg/data/questionnaire.dart';
import 'package:mood_habit_tracking_tfg/domain/questionnaire_repository.dart';

part 'questionnaire_state.dart';

class QuestionnaireCubit extends Cubit<QuestionnaireState> {
  final QuestionnaireRepository questionnaireRepository;

  QuestionnaireCubit(this.questionnaireRepository) : super(QuestionnaireLoading());

  Future<Questionnaire> getQuestionnaire(int id) async {
    try {
      emit(QuestionnaireLoading(loadingMessage: 'Getting Questionnaire...'));
      final questionnaire = await questionnaireRepository.getQuestionnaire(id);
      emit(QuestionnaireReceived(questionnaire));
      return questionnaire; // Devuelve el cuestionario obtenido
    } catch (e) {
      emit(QuestionnaireError('Error in obtaining questionnaire: $e.'));
      throw e; // Relanza el error para que pueda ser capturado en el lugar adecuado
    }
  }
}
