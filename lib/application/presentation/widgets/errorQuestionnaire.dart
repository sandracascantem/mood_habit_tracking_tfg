import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_habit_tracking_tfg/core/constants/colors.dart';


class ErrorQuestionnaireScreen extends StatelessWidget {
  const ErrorQuestionnaireScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        automaticallyImplyLeading: true, // Mostrar el botón de retroceso
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Text(
          "No hay ningún cuestionario disponible",
          style: GoogleFonts.roboto(
            fontSize: 18,
            color: clarocolor,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}