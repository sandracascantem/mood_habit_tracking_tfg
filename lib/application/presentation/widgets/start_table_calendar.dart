// ignore_for_file: unused_element, prefer_typing_uninitialized_variables, unused_field, prefer_if_null_operators, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class StartTableCalendar extends StatefulWidget {
  const StartTableCalendar({Key? key}) : super(key: key);

  @override
  State<StartTableCalendar> createState() => _StartTableCalendarState();
}

DateTime inicio = DateTime.now();
String inicioStr = inicio.toString().split(" ")[0];

class _StartTableCalendarState extends State<StartTableCalendar> {

  DateTime today = DateTime.now();
  void _onDaySelected (DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  var _focusedDay;
  DateTime _selectedDay = DateTime.now();
  var _currentDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 30.0),
      child: DefaultTextStyle(
        style: GoogleFonts.roboto(
          fontSize: 18, 
          color: Color(0xFFf2e9e4),
        ),
        child: TableCalendar(
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: TextStyle(fontSize: 22),
            headerPadding: EdgeInsets.symmetric(vertical: 12.0),
          ),
          daysOfWeekStyle: const DaysOfWeekStyle(
            weekdayStyle: TextStyle(
              fontSize: 18,
              color: Color(0xFFc9ada7),
            ), 
            weekendStyle: TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 112, 142, 181),
            ),
          ),
          daysOfWeekHeight: 30.0,
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
            todayTextStyle: const TextStyle(
              color: Color.fromARGB(255, 232, 108, 0),
              fontSize: 18,
            ),
            todayDecoration: BoxDecoration(
              color: Colors.transparent, 
              shape: BoxShape.circle,
              border: Border.all(color: const Color.fromARGB(255, 232, 108, 0)),
            ),
            selectedTextStyle: const TextStyle(
              color: Color(0xFF22223b), 
              fontSize: 18,
            ),
            selectedDecoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 177, 21), 
              shape: BoxShape.circle,
            ),
            weekendTextStyle: const TextStyle(
              color: Color.fromARGB(255, 112, 142, 181),
            ),
            weekNumberTextStyle: const TextStyle(
              color: Color(0xFFc9ada7),
            ),
            outsideTextStyle: const TextStyle(
              color: Colors.transparent,
            ),
            disabledTextStyle: const TextStyle(
              color: Color.fromARGB(255, 61, 64, 82),
            ),
          ),
          focusedDay: _selectedDay != null ? _selectedDay : today,
          firstDay: today,
          lastDay: DateTime.utc(2050),
          selectedDayPredicate: (day) { 
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
              inicio = selectedDay;
              inicioStr = inicio.toString().split(" ")[0];
            });
          },
          onPageChanged: (focusedDay) {
            _selectedDay = focusedDay;
          },
        ),
      ),
    );
  }
}