// ignore_for_file: non_constant_identifier_names

import 'package:hive/hive.dart';

//para crearlo ejecutar: 
//source ~/.bash_profile (para poder ejecutar comandos flutter)
//flutter packages pub run build_runner build
part 'questionnaire_tracking.g.dart';

@HiveType(typeId: 2)
class QuestionnaireTracking extends HiveObject{

  @HiveField(0)
  final int id_questionnaire;

  @HiveField(1)
  final String date;

  @HiveField(2)
  Map<String, dynamic> answers;

  QuestionnaireTracking({
    required this.id_questionnaire,
    required this.date,
    required this.answers
  });
}