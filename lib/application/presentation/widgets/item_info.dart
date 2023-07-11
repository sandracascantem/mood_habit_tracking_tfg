import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:mood_habit_tracking_tfg/core/constants/colors.dart';
import 'package:mood_habit_tracking_tfg/core/functions/functions.dart';

class ItemInfo extends StatelessWidget {
  const ItemInfo({super.key, this.habit});

  final habit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: CupertinoNavigationBar(
        automaticallyImplyLeading: true,
        backgroundColor: bgcolor,
        middle: Text(
          habit.name ?? 'Information',
          style: GoogleFonts.roboto(
            fontSize: 26,
            color: clarocolor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: habit.type == 'Sport' ? const AssetImage('assets/deporte.jpg') 
                : (habit.type == 'Sleep' ? const AssetImage('assets/sueno.jpg')
                : (habit.type == 'Hydration' ? const AssetImage('assets/beberAgua.jpg')
                : (habit.type == 'Nutrition' ? const AssetImage('assets/comer.jpg')
                : (habit.type == 'Study' ? const AssetImage('assets/estudio.jpg')
                : (habit.type == 'Work' ? const AssetImage('assets/trabajo.jpg')
                : (habit.type == 'Other' ? const AssetImage('assets/otro.jpg')
                : const AssetImage('assets/ocio.jpg'))))))), 
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),  
                child: Container(
                  color: bgcolor, // Definir color de fondo rojo
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          habit.type == 'Other' ? 'It is an other-type habit'
                          : 'It is a ${habit.type}-type habit',
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            color: clarocolor,
                          ),
                          overflow: TextOverflow.visible,
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        Text(
                          'Has started ${habit.startDate != null ? formatDateInfo(habit.startDate) : "fecha"}.',
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            color: clarocolor,
                          ),
                          overflow: TextOverflow.visible,
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        Text(
                          'Will be repeated: ${habit.repeat.isEmpty ? 'NO' 
                            : (habit.repeat.toSet().containsAll(["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]) ? 'Every day'
                            : (habit.repeat.length == 1 
                                ? (habit.repeat.first.contains('-') 
                                    ? formatDateInfo(habit.repeat.first.toString()) 
                                    : '${habit.repeat.first}'
                                  )
                                : (habit.repeat.first.contains('-')
                                    ? '${habit.repeat.map((element) => formatDateInfo(element)).join(", ")}'
                                    : '${habit.repeat.join(", ")}')))}',
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            color: clarocolor,
                          ),
                          overflow: TextOverflow.visible,
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        Text(
                          habit.goal != null 
                          ? (habit.type == 'Sport' || habit.type == 'Sleep' || habit.type == 'Study' || habit.type == 'Work' || habit.type == 'Other'
                            ? 'Your goal is ${habit.goal[0]} hours and ${habit.goal[1]} minutes per day.'
                            : (habit.type == 'Hydration'
                              ? 'Your goal is drinking ${habit.goal[0]} water glasses (${habit.goal[0]*0.25} liters) per day.'
                              : (habit.type == 'Nutrition'
                                ? 'Your goal is having ${habit.goal[0]} meals, of which ${habit.goal[1]} will be healthy per day.'
                                : 'Goal ?')))
                          : '',
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            color: clarocolor,
                          ),
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}