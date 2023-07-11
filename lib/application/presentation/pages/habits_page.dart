import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:mood_habit_tracking_tfg/application/presentation/main.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/widgets/item_info.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/widgets/item_progress.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/widgets/list_habits.dart';
import 'package:mood_habit_tracking_tfg/core/constants/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_habit_tracking_tfg/application/business_logic/habit_cubit.dart';

class HabitsPage extends StatelessWidget {
  const HabitsPage({Key? key}) : super(key: key);

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
            child: SizedBox(height: 20.0),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Center(
                child: Text(
                  "Your created habits",
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
            child: SizedBox(height: 20.0),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<HabitCubit, HabitState>(
              builder: (context, state) {
                context.read<HabitCubit>().getHabits();
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
                        'Still no habits yet :( \nClick the button + to start!',
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
                          return ListHabits(
                            nombre: habit.name,
                            tipo: habit.type,
                            onTap: () {
                              showCupertinoModalPopup<void>(
                                context: context,
                                builder: (BuildContext context) => CupertinoActionSheet(
                                  title: Text(habit.name),
                                  message: const Text('Select an action:'),
                                  actions: <CupertinoActionSheetAction>[
                                    CupertinoActionSheetAction(
                                      isDefaultAction: true,
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => ItemInfo(
                                            habit: habit,
                                          )),
                                        );
                                      },
                                      child: const Text('View habit information'),
                                    ),
                                    CupertinoActionSheetAction(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => ItemProgress(
                                            habit: habit,
                                          ),
                                        ),
                                        );
                                      },
                                      child: const Text('View habit progress'),
                                    ),
                                    CupertinoActionSheetAction(
                                      isDestructiveAction: true,
                                      onPressed: () {
                                        final habitCubit = context.read<HabitCubit>();
                                        habitCubit.deleteHabit(habit);
                                        Navigator.pop(context);
                                        /*Navigator.pushAndRemoveUntil(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (BuildContext context) => SafeArea(child: NavigationScreen()),
                                            fullscreenDialog: true,
                                            maintainState: true,
                                          ),
                                          (route) => false,
                                        );*/
                                      },
                                      child: const Text('Delete habit'),
                                    ),
                                  ],
                                ),
                              );
                            },
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
  
