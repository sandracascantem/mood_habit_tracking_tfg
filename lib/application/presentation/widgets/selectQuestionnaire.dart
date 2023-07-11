import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_habit_tracking_tfg/application/business_logic/questionnaire_cubit.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/widgets/questionnaire.dart';
import 'package:mood_habit_tracking_tfg/core/constants/colors.dart';

class SelectQuestionnaireScreen extends StatefulWidget {
    const SelectQuestionnaireScreen({Key? key, required this.ids, required this.dia}) : super(key: key);
  final List<int> ids;
  final dia;
  
  @override
  State<SelectQuestionnaireScreen> createState() => _SelectQuestionnaireScreenState();
}

class _SelectQuestionnaireScreenState extends State<SelectQuestionnaireScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: CupertinoNavigationBar(
        automaticallyImplyLeading: true,
        backgroundColor: bgcolor,
        middle: Text(
          "Select questionnaire",
          style: GoogleFonts.roboto(
            fontSize: 26,
            color: clarocolor,
          ),
        ),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemCount: widget.ids.length,
        itemBuilder: (context, index) {
          final id = widget.ids[index];
          return ListTile(
            title: Text('ID: $id'),
            onTap: () {
              context.read<QuestionnaireCubit>().getQuestionnaire(id);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuestionnaireScreen(dia: widget.dia, id: id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
