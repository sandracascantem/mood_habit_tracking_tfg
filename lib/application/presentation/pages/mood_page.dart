import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_habit_tracking_tfg/application/business_logic/questionnaire_tracking_cubit.dart';
//import 'package:mood_habit_tracking_tfg/application/business_logic/questionnaire_cubit.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/widgets/errorQuestionnaire.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/widgets/export_button.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/widgets/questionnaire.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/widgets/selectQuestionnaire.dart';
import 'package:mood_habit_tracking_tfg/core/constants/colors.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mood_habit_tracking_tfg/data/questionnaire_tracking.dart';

class MoodPage extends StatefulWidget {
  const MoodPage({Key? key}) : super(key: key);

  @override
  State<MoodPage> createState() => _MoodPageState();
}

class _MoodPageState extends State<MoodPage> {

  DateTime hoy = DateTime.now();
  bool isCuestionario = false;
  bool filled = false;
  List<int> ids = [];

  //AÑADIR PARA Q NO ESTE DISPONIBLE SI YA LO HA ENVIADO
  Future<bool> isCuestionarioAvailable() async {  //tampoco debe estar dsiponible si ya has rellenado el cuestionario (solo si lo has enviado) en el dia de hoy
    final currentTime = TimeOfDay.now();
    const startTime = TimeOfDay(hour: 21, minute: 0); // de 9 de la noche
    const endTime = TimeOfDay(hour: 24, minute: 0); // a 12 de la noche

    final currentHour = currentTime.hour;
    final startHour = startTime.hour;
    final endHour = endTime.hour;
    
    final dia = DateFormat('dd-MM-yyyy').format(DateTime.now());  //dia de hoy en formato dd-MM-yyyy
    
    //se ha rellenado al menos 1 vez el cuestionario
    // Obtener los seguimientos de cuestionario
    QuestionnaireTrackingCubit questionnaireTrackingCubit = context.read<QuestionnaireTrackingCubit>();
    final List<QuestionnaireTracking> questionnaireTrackings = await questionnaireTrackingCubit.getQuestionnaireTracking();
    filled = false;
    if (questionnaireTrackings.isNotEmpty) {
      //si cuestionario tiene la fecha de hoy (dd-mm-yyyy) entonces ya se ha rellenado el cuestionario
      for (int i = 0; i < questionnaireTrackings.length; i++) {
        String trackingDate = questionnaireTrackings[i].date;
        if (trackingDate == dia) {
          filled = true;
          break;
        }
      }
    } else {
      filled = false;
    }

    //si es la hora del cuestionario y el cuestionario NO ha sido rellenado aun
    if (currentHour >= startHour && currentHour < endHour && !filled) {
      isCuestionario = true;
      print(isCuestionario);
      return isCuestionario;
    } else {
      isCuestionario = false;
      print(isCuestionario);
      return isCuestionario;
    }
  }

  Future<List<int>> getIds() async {
    // Leer el contenido del archivo JSON desde los assets
    String jsonString = await rootBundle.loadString('assets/questionnaire.json');
    List<dynamic> jsonList = json.decode(jsonString);

    // Extraer todos los ids (campo id_questionnaire dentro de cada objeto del json)
    List<int> ids = [];
    for (var jsonEntry in jsonList) {
      int id = jsonEntry['id_questionnaire'];
      ids.add(id);
    }
    print(ids);
    return ids;
  }
  
  @override
  void initState() {
    super.initState();
    isCuestionarioAvailable().then((isCuestionario) {
      setState(() {
        isCuestionario = isCuestionario;
      });
    });
    getIds().then((id) {
      setState(() {
        ids = id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        toolbarHeight: 20,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: CustomScrollView(
        slivers: [ 
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20.0
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Center(
                child: Text(
                  "Mood Questionnaire",
                  style: GoogleFonts.roboto(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: clarocolor,
                  ),
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 15.0
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                child: Text(
                  "Questionnaire open from 9:00 p.m. to 0:00 a.m.",
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: clarocolor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20.0
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: botoncolor,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      height: 100.0,
                      width: 100.0,
                      child: Image(
                        image: AssetImage('assets/comoEstas.gif'),
                      )
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "How do you feel?",
                            style: GoogleFonts.roboto(
                              fontSize: 23,
                              color: oscurocolor,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            "Track your mood!",
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              color: oscurocolor,
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          isCuestionario 
                          ? ElevatedButton(
                            onPressed: () {
                              if(ids.isEmpty) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ErrorQuestionnaireScreen(),
                                  ),
                                );
                              } else if(ids.length == 1) {
                                final id = ids.first;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => QuestionnaireScreen(dia: hoy, id: id),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SelectQuestionnaireScreen(dia: hoy, ids: ids),
                                  ),
                                );
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(oscurocolor),
                            ),
                            child: Text(
                              "Questionnaire",
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: clarocolor,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          )
                          : ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      filled ? "You have already filled out the questionnaire today. It will be available again tomorrow from 9:00 p.m."
                                      : "The questionnaire will be available from 9:00 p.m.",
                                      style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        color: botoncolor,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Color.fromARGB(114, 74, 78, 105)),
                            ),
                            child: Text(
                              "Questionnaire",
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                                color: Color.fromARGB(121, 242, 233, 228),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20.0
            ),
          ),
          const SliverToBoxAdapter(
            child: ExportButton()
          ),
        ],
      ),
    );
  }
}