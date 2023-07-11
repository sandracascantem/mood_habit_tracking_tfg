import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:mood_habit_tracking_tfg/application/business_logic/habit_cubit.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/main.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/widgets/interval.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/widgets/repeat_table_calendar.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/widgets/some_days.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/widgets/start_table_calendar.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/widgets/water_picker.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/widgets/weekly.dart';
import 'package:mood_habit_tracking_tfg/core/constants/colors.dart';
import 'package:mood_habit_tracking_tfg/data/habit.dart';

class HydrationType extends StatefulWidget {
  const HydrationType({Key? key}) : super(key: key);

  @override
  State<HydrationType> createState() => _HydrationTypeState();
}

List<String> repeat = [];
String name = "";
const type = "Hydration";
var screenActive = 0;


class _HydrationTypeState extends State<HydrationType> {

  final nameController = TextEditingController();
  
  @override
  void dispose() {
    // liberar los recursos cuando se termina de usar el controlador
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: CupertinoNavigationBar(
        automaticallyImplyLeading: true,
        backgroundColor: bgcolor,
        middle: Text(
          "Hydration",
          style: GoogleFonts.roboto(
            fontSize: 26,
            color: clarocolor,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [ 
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Material(
                child: TextField(
                  maxLength: 15,
                  cursorColor: mediocolor,
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Habit name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "How many glasses per day do you aim to drink?",
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  color: clarocolor,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: WaterPicker(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "* A glass of 250 mL is assumed.\n** In general, it is recommended to drink between 1.5 - 2 L daily, approximately 6-8 glasses.",
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: clarocolor,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 30,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "What day would you like to start the habit?",
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  color: clarocolor,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Material(
              child: StartTableCalendar(),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 30,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "When do you want the habit to be repeated?",
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  color: clarocolor,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    width: 305,
                    decoration: BoxDecoration(
                      color: mediocolor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              screenActive = 0;
                            });
                          },
                          child: Container(
                            width: 120,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: screenActive == 0
                                  ? clarocolor
                                  : mediocolor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: DefaultTextStyle(
                                style: GoogleFonts.openSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: bgcolor,
                                ),
                                child: const Text(
                                  'Weekly',
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 2),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              screenActive = 1;
                            });
                          },
                          child: Container(
                            width: 90,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: screenActive == 1
                                  ? clarocolor
                                  : mediocolor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: DefaultTextStyle(
                                style: GoogleFonts.openSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: bgcolor,
                                ),
                                child: const Text(
                                  'Some days',
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 2),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              screenActive = 2;
                            });
                          },
                          child: Container(
                            width: 90,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: screenActive == 2
                                  ? clarocolor
                                  : mediocolor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: DefaultTextStyle(
                                style: GoogleFonts.openSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF22223b),
                                ),
                                child: const Text(
                                  'Interval',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                screenActive == 0
                    ? const Weekly()
                    : (screenActive == 1 ? const SomeDays() : const IntervalDays()),
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90.0),
              child: CupertinoButton(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                color: botoncolor,
                onPressed: () {
                  if (screenActive == 0) {
                    repeat = days;
                  } else if (screenActive == 1) {
                    repeat = diasSel;
                  } else {
                    repeat = interval;
                  }
                  (nameController.text).isEmpty ? name = "" : name = nameController.text;
                  print(type);
                  print(name);
                  print(repeat);
                  print(inicioStr);
                  print(selectedVasos);
                  
                  final habit = Habit(
                    name: name,
                    type: type,
                    startDate: inicioStr,
                    repeat: repeat,
                    goal: [selectedVasos],
                    tracking: [],
                  );
                  final habitCubit = context.read<HabitCubit>();
                  habitCubit.addHabit(habit);
                  Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(
                      builder: (BuildContext context) => const MyApp(),
                      fullscreenDialog: true,
                      maintainState: true,
                    ),
                    (route) => false,
                  );
                },
                child: Text(
                  "Create habit",
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: bgcolor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 70,
            ),
          ),
        ],
      ),
    );
  }
}