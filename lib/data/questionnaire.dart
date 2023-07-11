// ignore_for_file: non_constant_identifier_names

class Questionnaire {
  final int id_questionnaire;
  final String name;
  final String description;
  final List<Map<String, dynamic>> questions;

  Questionnaire({
    required this.id_questionnaire,
    required this.name,
    required this.description,
    required this.questions,
  });
}
