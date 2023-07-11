import 'package:flutter/material.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/widgets/repeat_table_calendar.dart';

class SomeDays extends StatefulWidget {
  const SomeDays({Key? key}) : super(key: key);

  @override
  State<SomeDays> createState() => _SomeDaysState();
}

class _SomeDaysState extends State<SomeDays> {

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Material(
        child: RepeatTableCalendar(),
      ),
    );
  }
}