import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_habit_tracking_tfg/application/business_logic/habit_cubit.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/widgets/list_habits_calendar.dart';
import 'package:mood_habit_tracking_tfg/core/constants/colors.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime selectedDate = DateTime.now();
  int currentDateSelectedIndex = 0;
  ScrollController scrollController = ScrollController();
  List<String> listOfMonths = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  List<String> listOfDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  @override
  void initState() {
    super.initState();
    context.read<HabitCubit>().getHabitsDay(selectedDate);
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
            child: SizedBox(height: 20.0),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Center(
                child: Text(
                  "Select a day to view your scheduled habits.",
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
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Container(
                    height: 100,
                    child: Container(
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(width: 10);
                        },
                        itemCount: 365,
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                currentDateSelectedIndex = index;
                                selectedDate = DateTime.now().add(Duration(days: index));
                              });
                              context.read<HabitCubit>().getHabitsDay(selectedDate);
                            },
                            child: Container(
                              height: 80,
                              width: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 219, 219, 236),
                                    offset: Offset(3, 3),
                                    blurRadius: 5,
                                  )
                                ],
                                color: currentDateSelectedIndex == index
                                    ? clarocolor
                                    : mediocolor,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    listOfDays[DateTime.now().add(Duration(days: index)).weekday - 1]
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: currentDateSelectedIndex == index
                                          ? mediocolor
                                          : clarocolor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    DateTime.now().add(Duration(days: index)).day.toString(),
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: currentDateSelectedIndex == index
                                          ? mediocolor
                                          : clarocolor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    listOfMonths[DateTime.now().add(Duration(days: index)).month - 1]
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: currentDateSelectedIndex == index
                                          ? mediocolor
                                          : clarocolor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20.0),
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
                        'Still no habits for that day yet :( \nClick the button + to start!',
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
                          return ListHabitsCalendar(
                            nombre: habit.name,
                            tipo: habit.type,
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
