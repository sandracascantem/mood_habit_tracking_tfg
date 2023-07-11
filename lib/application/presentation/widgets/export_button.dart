// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_habit_tracking_tfg/application/business_logic/habit_cubit.dart';
import 'package:mood_habit_tracking_tfg/application/business_logic/questionnaire_tracking_cubit.dart';
import 'package:mood_habit_tracking_tfg/core/constants/colors.dart';
import 'package:mood_habit_tracking_tfg/data/habit.dart';
import 'package:mood_habit_tracking_tfg/data/questionnaire_tracking.dart';

class ExportButton extends StatelessWidget {
  const ExportButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () async {
            String loadpwd = await rootBundle.loadString('assets/password.json');
            Map<String, dynamic> jsonpwd = json.decode(loadpwd);
            String pwd = jsonpwd["pwd"];

            String? enteredPassword = await showDialog<String>(
              context: context,
              builder: (BuildContext context) {
                
                String password = ''; // Variable para almacenar la contraseña ingresada
                return AlertDialog(
                  title: Text('Enter Password'),
                  content: TextField(
                    obscureText: true, // Ocultar el texto ingresado
                    onChanged: (value) {
                      password = value; // Actualizar la contraseña cuando se cambia el texto
                    },
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(password); // Cerrar el diálogo y devolver la contraseña ingresada
                      },
                      child: Text('Submit'),
                    ),
                  ],
                );
              },
            );

            // Verificar si la contraseña ingresada coincide con la del archivo password.json
            if (enteredPassword == pwd) {
              // Contraseña correcta, continuar con la exportación del JSON
              QuestionnaireTrackingCubit questionnaireTrackingCubit = context.read<QuestionnaireTrackingCubit>();
              HabitCubit habitCubit = context.read<HabitCubit>();
              String jsonString = await getJson(questionnaireTrackingCubit, habitCubit);
              print(jsonString);
              // Exportar el JSON
              Share.share(jsonString, subject: 'Look what I made!');
            } else {
              // Contraseña incorrecta, mostrar un mensaje de error o tomar alguna acción adicional
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Incorrect Password'),
                    content: Text('The entered password is incorrect.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          },

          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(oscurocolor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(Icons.share_sharp),
              Text(
                "Export data",
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  color: clarocolor,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<String> getJson(QuestionnaireTrackingCubit questionnaireTrackingCubit, HabitCubit habitCubit) async {
  final Map<String, dynamic> json = {};

  // Obtener los hábitos
  final List<Habit> habits = await habitCubit.getHabits();
  // Convertir los hábitos a JSON
  final List<Map<String, dynamic>> habitsJson = habits.map((habit) {
    final Map<String, dynamic> habitJson = {
      'type': habit.type,
      'name': habit.name,
      'repeat': habit.repeat,
      'startDate': habit.startDate,
      'goal': habit.goal,
      'tracking': habit.tracking.map((tracking) => {
        'date': tracking.date,
        'tracking': tracking.tracking,
      }).toList(),
    };
    return habitJson;
  }).toList();
  json['habits'] = habitsJson;

  // Obtener los seguimientos de cuestionario
  final List<QuestionnaireTracking> questionnaireTrackings = await questionnaireTrackingCubit.getQuestionnaireTracking();

  // Convertir los seguimientos de cuestionario a JSON
  final List<Map<String, dynamic>> moodJson = questionnaireTrackings.map((tracking) {
    final Map<String, dynamic> moodTrackingJson = {
      'id_questionnaire': tracking.id_questionnaire,
      'date': tracking.date,
      'answers': tracking.answers,
    };
    return moodTrackingJson;
  }).toList();
  json['mood'] = moodJson;

  // Convertir el JSON a una cadena de texto
  final jsonString = jsonEncode(json);
  return jsonString;
}
