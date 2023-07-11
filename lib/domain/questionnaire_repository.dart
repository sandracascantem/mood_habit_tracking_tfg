import 'package:mood_habit_tracking_tfg/data/questionnaire.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class QuestionnaireRepository {
  const QuestionnaireRepository();

  //getQuestionnaire(int id)
  Future<Questionnaire> getQuestionnaire(int id) async {
    // Leer el contenido del archivo JSON desde los assets
    String jsonString = await rootBundle.loadString('assets/questionnaire.json');
    List<dynamic> jsonList = json.decode(jsonString);

    // Buscar el cuestionario con el ID especificado
    Map<String, dynamic>? jsonQuestionnaire;
    for (var jsonEntry in jsonList) {
      if (jsonEntry['id_questionnaire'] == id) {
        jsonQuestionnaire = jsonEntry;
        break;
      }
    }

    if (jsonQuestionnaire == null) {
      throw Exception('No se encontró un cuestionario con el ID especificado');
    }

    // Obtener la lista de preguntas del JSON
    List<Map<String, dynamic>> questions = List<Map<String, dynamic>>.from(jsonQuestionnaire['questions']);

    // Crear el objeto Questionnaire a partir del JSON
    return Questionnaire(
      id_questionnaire: jsonQuestionnaire['id_questionnaire'],
      name: jsonQuestionnaire['name'],
      description: jsonQuestionnaire['description'],
      questions: questions,
    );
  }
}