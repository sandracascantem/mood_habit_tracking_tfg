import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_habit_tracking_tfg/application/business_logic/habit_cubit.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/widgets/list_habits_today.dart';
import 'dart:async';

import 'package:mood_habit_tracking_tfg/core/constants/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateTime today = DateTime.now();

  String mesStr(int month) {
    List<String> meses = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    return meses[month-1];
  }

  late String todayText = 'Today, ${mesStr(today.month)} ${today.day}';

  @override
  void initState() {
    super.initState();
    context.read<HabitCubit>().getHabitsDay(today);
    Timer.periodic(const Duration(days: 1) - today.difference(DateTime.now()), (timer) {
      setState(() {
        today = DateTime.now();
        todayText = 'Today, ${mesStr(today.month)} ${today.day}';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        toolbarHeight: 0,
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
                  todayText,
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
              height: 20.0
            ),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<HabitCubit, HabitState>(
              builder: (context, state) {
                if (state is HabitLoading) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      strokeWidth: 5.0,
                    ),
                  );
                } else if (state is HabitReceived) {
                  final habits = state.habits;
                  if (habits.isEmpty) {
                    return Center(
                      child: Text(
                        'Still no habits for today yet :( \nClick the button + to start!',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: clarocolor,
                        ),
                        overflow: TextOverflow.visible,
                      ),
                    );
                  } else {
                    return Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: habits.length,
                        itemBuilder: (context, index) {
                          final habit = habits[index];
                          return ListHabitsToday(
                            habit: habit,
                          );
                        },
                      ),
                    );
                  }
                } else if (state is HabitError) {
                  return Text(
                    state.errorMessage,
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: clarocolor,
                    ),
                    overflow: TextOverflow.visible,
                  );
                } else {
                  return Text(
                    'Habit state unknown',
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: clarocolor,
                    ),
                    overflow: TextOverflow.visible,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}