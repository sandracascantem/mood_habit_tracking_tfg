import 'package:hive/hive.dart';
import 'package:mood_habit_tracking_tfg/data/questionnaire_tracking.dart';

class QuestionnaireTrackingRepository {
  const QuestionnaireTrackingRepository();

  //addQuestionnaireTracking(QuestionnaireTracking tracking)
  Future<void> addQuestionnaireTracking(QuestionnaireTracking tracking) async {
    final Box<QuestionnaireTracking> box = await Hive.openBox<QuestionnaireTracking>('questionnaireTrackings');
    await box.add(tracking);
    await box.close();
  }

  //getQuestionnaireTracking()
  Future<List<QuestionnaireTracking>> getQuestionnaireTracking() async {
    final Box<QuestionnaireTracking> box = await Hive.openBox<QuestionnaireTracking>('questionnaireTrackings');
    List<QuestionnaireTracking> questionnaireTrackingList = box.values.toList();
    return questionnaireTrackingList;
  }

  // para pruebas, borrar mood
  // Future<void> deleteMood() async {
  //   final Box<QuestionnaireTracking> box = await Hive.openBox<QuestionnaireTracking>('questionnaireTrackings');
  //   final int key = 0;
  //   await box.delete(key);
  //   await box.close();
  // }
}