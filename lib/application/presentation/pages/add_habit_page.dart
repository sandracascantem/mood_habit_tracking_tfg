import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/type_habits/hydration.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/type_habits/nutrition.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/type_habits/other.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/type_habits/sleep.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/type_habits/sport.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/type_habits/study.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/type_habits/work.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/widgets/list_add_habit.dart';
import 'package:mood_habit_tracking_tfg/core/constants/colors.dart';

class AddHabitPage extends StatelessWidget {
  const AddHabitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: CupertinoNavigationBar(
        automaticallyImplyLeading: true,
        backgroundColor: bgcolor,
        middle: Text(
          "Create a new habit",
          style: GoogleFonts.roboto(
            fontSize: 26,
            color: clarocolor,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [ 
          const SliverToBoxAdapter(
            child: SizedBox(height: 30),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, i) { 
              if (i == 0) {
                return ListAddHabit(
                  key: UniqueKey(),
                  image: const AssetImage('assets/deporte.jpg'), 
                  title: 'Sport', 
                  onTap: () => {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SportType())),
                  },
                );
              }
              if (i == 1) {
                return ListAddHabit(
                  key: UniqueKey(),
                  image: const AssetImage('assets/sueno.jpg'), 
                  title: 'Sleep', 
                  onTap: () => {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SleepType())),
                  },
                );
              }
              if (i == 2) {
                return ListAddHabit(
                  key: UniqueKey(),
                  image: const AssetImage('assets/beberAgua.jpg'),
                  title: 'Hydration', 
                  onTap: () => {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const HydrationType())),
                  },
                );
              }
              if (i == 3) {
                return ListAddHabit(
                  key: UniqueKey(),
                  image: const AssetImage('assets/comer.jpg'), 
                  title: 'Nutrition', 
                  onTap: () => {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const NutritionType())),
                  },
                );
              }
              if (i == 4) {
                return ListAddHabit(
                  key: UniqueKey(),
                  image: const AssetImage('assets/estudio.jpg'),  
                  title: 'Study', 
                  onTap: () => {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const StudyType())),
                  },
                );
              }
              if (i == 5) {
                return ListAddHabit(
                  key: UniqueKey(),
                  image: const AssetImage('assets/trabajo.jpg'), 
                  title: 'Work', 
                  onTap: () => {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const WorkType())),
                  },
                );
              }
              if (i == 6) {
                return ListAddHabit(
                  key: UniqueKey(),
                  image: const AssetImage('assets/otro.jpg'), 
                  title: 'Other', 
                  onTap: () => {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const OtherType())),
                  },
                );
              }
              else {
                return null;
              }
            }),
          ),
        ],
      ),
    );
  }
}