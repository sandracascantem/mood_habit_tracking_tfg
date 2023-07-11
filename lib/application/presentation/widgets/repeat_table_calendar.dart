// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables, unused_field, prefer_if_null_operators

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class RepeatTableCalendar extends StatefulWidget {
  const RepeatTableCalendar({Key? key}) : super(key: key);

  @override
  State<RepeatTableCalendar> createState() => _RepeatTableCalendarState();
}

List<DateTime> _selectedDates = [];
List<String> diasSel = [];


List<String> dias(List<DateTime> _selectedDates) {
  if(_selectedDates.isEmpty) {
    return diasSel = [];
  } else {
    List<DateTime> sortedDias = List.from(_selectedDates);
    sortedDias.sort((a, b) => a.compareTo(b));
    return diasSel = sortedDias.map((date) => date.toString().split(" ")[0]).toList();
  }
}

class _RepeatTableCalendarState extends State<RepeatTableCalendar> {

  DateTime today = DateTime.now();
  DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
  // void _onDaySelected (DateTime day, DateTime focusedDay) {
  //   setState(() {
  //     today = day;
  //   });
  // }

  var _focusedDay;
  var _selectedDay;
  var _currentDate;
  var _lastClickedDate;

  // void initState() {
  //   super.initState();
  //   _selectedDates = [];
  //   _currentDate = DateTime.now();
  // }

  void _handleDayChanged(DateTime value) {
    setState(() {
      _lastClickedDate = value;
      if (_selectedDates.contains(value)) {
        _selectedDates.remove(value);
      } else {
        _selectedDates.add(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
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
          //focusedDay: _selectedDates.isNotEmpty ? _selectedDates[_selectedDates.length-1]! : today,
          focusedDay: _lastClickedDate != null ? _lastClickedDate : today,
          firstDay: today,
          lastDay: DateTime.utc(2050),
          selectedDayPredicate: (day) { 
            //return isSameDay(_selectedDay, day);
            return _selectedDates.contains(day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
              if (isSameDay(_selectedDay, focusedDay)) {
                _handleDayChanged(_selectedDay);
                diasSel = dias(_selectedDates);
                print(_selectedDates);
                print(diasSel);
              }
              // _selectedDay = selectedDay;
              // _focusedDay = focusedDay;
              //print(_focusedDay);
            });
          },
          onPageChanged: (focusedDay) {
            _selectedDay = focusedDay;
          },
        ),
      ),
      //Text ("Selected Day = " + today. toString().split(" ")[0]),   //2023-03-16
    );
  }
}