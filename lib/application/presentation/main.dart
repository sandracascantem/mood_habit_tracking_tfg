// ignore_for_file: use_key_in_widget_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mood_habit_tracking_tfg/application/business_logic/habit_tracking_cubit.dart';
import 'package:mood_habit_tracking_tfg/application/business_logic/questionnaire_cubit.dart';
import 'package:mood_habit_tracking_tfg/application/business_logic/questionnaire_tracking_cubit.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/pages/calendar_page.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/pages/habits_page.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/pages/home_page.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/pages/mood_page.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/widgets/animation_add.dart';
import 'package:mood_habit_tracking_tfg/core/constants/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_habit_tracking_tfg/application/business_logic/habit_cubit.dart';
import 'package:mood_habit_tracking_tfg/data/habit.dart';
import 'package:mood_habit_tracking_tfg/data/habit_tracking.dart';
import 'package:mood_habit_tracking_tfg/data/questionnaire_tracking.dart';
import 'package:mood_habit_tracking_tfg/domain/habit_repository.dart';
import 'package:mood_habit_tracking_tfg/domain/habit_tracking_repository.dart';
import 'package:mood_habit_tracking_tfg/domain/questionnaire_repository.dart';
import 'package:mood_habit_tracking_tfg/domain/questionnaire_tracking_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HabitAdapter());
  Hive.registerAdapter(HabitTrackingAdapter());
  Hive.registerAdapter(QuestionnaireTrackingAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HabitCubit>(
          create: (context) => HabitCubit(const HabitRepository()),
        ),
        BlocProvider<HabitTrackingCubit>(
          create: (context) => HabitTrackingCubit(const HabitTrackingRepository()),
        ),
        BlocProvider<QuestionnaireCubit>(
          create: (context) => QuestionnaireCubit(const QuestionnaireRepository()),
        ),
        BlocProvider<QuestionnaireTrackingCubit>(
          create: (context) => QuestionnaireTrackingCubit(const QuestionnaireTrackingRepository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mood_habit_tracking_tfg',
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          canvasColor: bgcolor,
          cardColor: bgcolor,
          colorScheme: ColorScheme(
            brightness: Brightness.dark, 
            primary: Colors.white, 
            onPrimary: Colors.red, 
            secondary: Colors.blue, 
            onSecondary: Colors.green, 
            error: Colors.orange, 
            onError: Colors.pink, 
            background: bgcolor, 
            onBackground: botoncolor, 
            surface: Colors.brown,  
            onSurface: clarocolor, 
          ),
        ),
        home: SafeArea(child:NavigationScreen()),
      ),
    );
  }
}

class NavigationScreen extends StatefulWidget {
  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  
  int currentTab = 0;
  final List<Widget> screens = [
    const HomePage(),
    const HabitsPage(),
    const CalendarPage(),
    const MoodPage(),
  ];
  
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        shape: const CircleBorder(),
        backgroundColor: botoncolor,
        foregroundColor: oscurocolor,
        onPressed: () {
          Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context, animation, _) {
            return const AnimationAdd();
          },
          opaque: false,
          ));
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: bgcolor,
        notchMargin: 10.0,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MaterialButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen = HomePage();
                      currentTab = 0;
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.home,
                        color: currentTab == 0 ? botoncolor : menucolor,
                      ),
                      Text(
                        'Home',
                        style: TextStyle(
                          color: currentTab == 0 ? botoncolor : menucolor,
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,                  
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen = HabitsPage();
                      currentTab = 1;
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.format_list_bulleted,
                        color: currentTab == 1 ? botoncolor : menucolor,
                      ),
                      Text(
                        'Habits',
                        style: TextStyle(
                          color: currentTab == 1 ? botoncolor : menucolor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                MaterialButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,                  
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen = CalendarPage();
                      currentTab = 2;
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: currentTab == 2 ? botoncolor : menucolor,
                      ),
                      Text(
                        'Calendar',
                        style: TextStyle(
                          color: currentTab == 2 ? botoncolor : menucolor,
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,                  
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen = MoodPage();
                      currentTab = 3;
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.mood,
                        color: currentTab == 3 ? botoncolor : menucolor,
                      ),
                      Text(
                        'Mood',
                        style: TextStyle(
                          color: currentTab == 3 ? botoncolor : menucolor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}