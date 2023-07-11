// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:mood_habit_tracking_tfg/core/constants/colors.dart';

class ListAddHabit extends StatefulWidget {
  const ListAddHabit({super.key, this.image, this.title, this.onTap});
  
  final image; //para el fondo
  final title;  
  final onTap;

  @override
  State<ListAddHabit> createState() => _ListAddHabitState();
}

class _ListAddHabitState extends State<ListAddHabit> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: InkWell(
            onTap: () => widget.onTap(),
            child: Container(
              decoration: widget.image != null ? BoxDecoration(
                image: DecorationImage(
                  image: widget.image,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
              ) : BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Text(
                                widget.title != null ? widget.title : 'Title_default',
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: bgcolor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      CupertinoIcons.chevron_right, 
                      color: Theme.of(context).canvasColor,
                    ),
                  ],
                ),
              ),
            ),
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