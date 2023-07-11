import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mood_habit_tracking_tfg/application/business_logic/questionnaire_cubit.dart';
import 'package:mood_habit_tracking_tfg/application/business_logic/questionnaire_tracking_cubit.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/main.dart';
import 'package:mood_habit_tracking_tfg/core/constants/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_habit_tracking_tfg/data/questionnaire.dart';
import 'package:mood_habit_tracking_tfg/data/questionnaire_tracking.dart';

class QuestionnaireScreen extends StatefulWidget {
  final DateTime dia;
  final int id;

  const QuestionnaireScreen({Key? key, required this.dia, required this.id}) : super(key: key);

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  PageController _pageController = PageController();
  int currentPage = 0;
  Questionnaire? questionnaire;
  List<int> selectedOptions = [];
  List<String> questions = [];
  List<List<dynamic>> options = [];
  Map<String, dynamic> answers = {};

  @override
  void initState() {
    super.initState();
    _loadQuestionnaire().then((loadedQuestionnaire) {
      setState(() {
        questionnaire = loadedQuestionnaire;
      });
    });
  }

  Future<Questionnaire> _loadQuestionnaire() async {
    try {
      final loadedQuestionnaire = await context.read<QuestionnaireCubit>().getQuestionnaire(widget.id);
      questions = loadedQuestionnaire.questions.map((question) => question['text'] as String).toList();
      options = loadedQuestionnaire.questions.map((question) => List<dynamic>.from(question['answers'])).toList();
      selectedOptions = List<int>.filled(questions.length, -1);
      print(loadedQuestionnaire);
      return loadedQuestionnaire;
    } catch (e) {
      // Manejar el error
      throw e;
    }
  }


   void selectOption(int optionIndex) {
    setState(() {
      selectedOptions[currentPage] = optionIndex;
    });
  }

  void nextPage() async {
    if (selectedOptions[currentPage] != -1) {
      if (currentPage < questions.length - 1) {
        _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
      } else {
        //para enviar el cuestionario
        //generar las respuestas
        generateAnswers();
        //mostrar las respuestas
        showAnswers();
        //guardar cuestionario en la base de datos
        final questionnaireTracking = QuestionnaireTracking(
          id_questionnaire: widget.id,
          date: fecha(widget.dia),
          answers: answers
        );
        final questionnaireTrackingCubit = context.read<QuestionnaireTrackingCubit>();
        questionnaireTrackingCubit.addQuestionnaireTracking(questionnaireTracking);
        Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(
            builder: (BuildContext context) => SafeArea(child: NavigationScreen()),
            fullscreenDialog: true,
            maintainState: true,
          ),
          (route) => false,
        );
      }
    }
  }

  void previousPage() {
    _pageController.previousPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
  }

  //en este guarda las respuestas con el string seleccionado 'Muy buena'..
  // void generateAnswers() {
  //   answers.clear();
  //   for (int i = 0; i < questions.length; i++) {
  //     String question = questions[i];
  //     String option = options[i][selectedOptions[i]];
  //     String answer = '$option';
  //     answers.add(answer);
  //   }
  // }
  //en este guarda las respuestas del 1-5 (string) con el orden de la respuesta seleccionada
  void generateAnswers() {
    answers.clear();
    for (int i = 0; i < questions.length; i++) {
      String questionId = questionnaire!.questions[i]['id_question'];
      int optionIndex = selectedOptions[i];
      answers[questionId] = optionIndex + 1;
    }
  }

  void showAnswers() {
    print(answers);
  }

  String fecha(DateTime dia) {
    return DateFormat('dd-MM-yyyy').format(dia);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: CupertinoNavigationBar(
        automaticallyImplyLeading: true,
        backgroundColor: bgcolor,
        middle: Text(
          "Questionnaire",
          style: GoogleFonts.roboto(
            fontSize: 26,
            color: clarocolor,
          ),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            currentPage = page;
          });
        },
        itemCount: questions.length,
        itemBuilder: (BuildContext context, int index) {
          return buildQuestionPage(index);
        },
      ),
    );
  }

  Widget buildQuestionPage(int index) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'QUESTION ${index + 1}/${questions.length}',
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: botoncolor,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              questions[index],
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Column(
              children: List.generate(
                options[index].length,
                (optionIndex) => buildOption(
                  optionIndex,
                  options[index][optionIndex].toString(),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (index > 0)
                  ElevatedButton(
                    onPressed: previousPage,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(botoncolor),
                    ),
                    child: Text(
                      'Back',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: oscurocolor,
                      ),
                    ),
                  ),
                ElevatedButton(
                  onPressed: nextPage,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(botoncolor),
                  ),
                  child: Text(
                    index < questions.length - 1 ? 'Next' : 'Submit',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: oscurocolor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOption(int optionIndex, String optionText) {
    return ListTile(
      onTap: () {
        selectOption(optionIndex);
      },
      leading: Radio<int>(
        value: optionIndex,
        groupValue: selectedOptions[currentPage],
        onChanged: (int? value) {
          selectOption(value!);
        },
      ),
      title: Text(optionText),
    );
  }
}