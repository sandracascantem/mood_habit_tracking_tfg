// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:mood_habit_tracking_tfg/core/constants/colors.dart';

class ListHabitsCalendar extends StatelessWidget {
  const ListHabitsCalendar({Key? key, this.nombre, this.tipo, this.objetivo});
  
  final nombre;
  final tipo;
  final objetivo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Container(
                    height: 90,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: tipo == 'Sport' ? const AssetImage('assets/deporte.jpg') 
                                : (tipo == 'Sleep' ? const AssetImage('assets/sueno.jpg')
                                : (tipo == 'Hydration' ? const AssetImage('assets/beberAgua.jpg')
                                : (tipo == 'Nutrition' ? const AssetImage('assets/comer.jpg')
                                : (tipo == 'Study' ? const AssetImage('assets/estudio.jpg')
                                : (tipo == 'Work' ? const AssetImage('assets/trabajo.jpg')
                                : (tipo == 'Other' ? const AssetImage('assets/otro.jpg')
                                : const AssetImage('assets/ocio.jpg'))))))), 
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: const EdgeInsets.all(0.0),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                              height: 75,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(211, 255, 255, 255),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        nombre ?? 'Default nombre',
                                        style: GoogleFonts.roboto(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: oscurocolor,
                                        ),
                                        overflow: TextOverflow.visible,
                                      ),
                                      Text(
                                        tipo,
                                        style: GoogleFonts.roboto(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: oscurocolor,
                                        ),
                                        overflow: TextOverflow.visible,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 20,
          thickness: 1,
          color: Colors.grey.shade800,
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }
}
