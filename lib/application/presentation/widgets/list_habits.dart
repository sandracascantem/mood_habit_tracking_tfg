import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_habit_tracking_tfg/core/constants/colors.dart';


class ListHabits extends StatefulWidget {
  const ListHabits({Key? key, this.nombre, this.tipo, this.objetivo, this.onTap});
  
  final nombre;
  final tipo;
  final objetivo;
  final onTap;

  @override
  State<ListHabits> createState() => _ListHabitsState();
}

class _ListHabitsState extends State<ListHabits> {
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
                        image: widget.tipo == 'Sport' ? AssetImage('assets/deporte.jpg') 
                                : (widget.tipo == 'Sleep' ? AssetImage('assets/sueno.jpg')
                                : (widget.tipo == 'Hydration' ? AssetImage('assets/beberAgua.jpg')
                                : (widget.tipo == 'Nutrition' ? AssetImage('assets/comer.jpg')
                                : (widget.tipo == 'Study' ? AssetImage('assets/estudio.jpg')
                                : (widget.tipo == 'Work' ? AssetImage('assets/trabajo.jpg')
                                : (widget.tipo == 'Other' ? AssetImage('assets/otro.jpg')
                                : AssetImage('assets/ocio.jpg'))))))), 
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
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                              height: 75,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(211, 255, 255, 255),
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
                                        widget.nombre != null ? widget.nombre : 'Default nombre',
                                        style: GoogleFonts.roboto(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: oscurocolor,
                                        ),
                                        overflow: TextOverflow.visible,
                                      ),
                                      Text(
                                        widget.tipo,
                                        style: GoogleFonts.roboto(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: oscurocolor,
                                        ),
                                        overflow: TextOverflow.visible,
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap:() {
                                      widget.onTap();
                                    },
                                    child: Icon(
                                      Icons.menu, 
                                      size: 22,
                                      color: oscurocolor,
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
