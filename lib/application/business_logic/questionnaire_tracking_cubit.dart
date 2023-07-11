import 'package:bloc/bloc.dart';
import 'package:mood_habit_tracking_tfg/data/questionnaire_tracking.dart';
import 'package:mood_habit_tracking_tfg/domain/questionnaire_tracking_repository.dart';

part 'questionnaire_tracking_state.dart';

class QuestionnaireTrackingCubit extends Cubit<QuestionnaireTrackingState> {
  final QuestionnaireTrackingRepository questionnaireTrackingRepository;

  QuestionnaireTrackingCubit(this.questionnaireTrackingRepository) : super(QuestionnaireTrackingLoading());

  Future<void> addQuestionnaireTracking(QuestionnaireTracking tracking) async {
    try {
      await questionnaireTrackingRepository.addQuestionnaireTracking(tracking);
      emit(QuestionnaireTrackingLoading(loadingMessage: 'Getting habitTrackings...'));
      List<QuestionnaireTracking> trackings = await questionnaireTrackingRepository.getQuestionnaireTracking();
      emit(QuestionnaireTrackingReceived(trackings));
    } catch (e) {
      emit(QuestionnaireTrackingError('Error in obtaining questionnaireTrackings: $e.'));
    }
  }

  Future<List<QuestionnaireTracking>> getQuestionnaireTracking() async {
    try {
      emit(QuestionnaireTrackingLoading(loadingMessage: 'Getting habits...'));
      final mood = await questionnaireTrackingRepository.getQuestionnaireTracking();
      emit(QuestionnaireTrackingReceived(mood));
      return mood;
    } catch (e) {
      emit(QuestionnaireTrackingError('Error in obtaining habits: $e.'));
      throw e; // Relanza el error para que pueda ser capturado en el lugar adecuado
    }
  }
  
  // Future<void> deleteMood() async {
  //   try {
  //     await questionnaireTrackingRepository.deleteMood();
  //     emit(QuestionnaireTrackingLoading(loadingMessage: 'Getting habitTrackings...'));
  //     List<QuestionnaireTracking> trackings = await questionnaireTrackingRepository.getQuestionnaireTracking();
  //     emit(QuestionnaireTrackingReceived(trackings));
  //   } catch (e) {
  //     emit(QuestionnaireTrackingError('Error in obtaining questionnaireTrackings: $e.'));
  //   }
  // }
}
