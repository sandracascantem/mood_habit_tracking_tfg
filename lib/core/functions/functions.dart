import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//para calcular los dias hasta el mes siguiente
int daysInOneMonth(DateTime date) {
  var firstDayThisMonth = DateTime(date.year, date.month, date.day);
  var firstDayNextMonth = DateTime(date.year, date.month + 1, date.day);
  var daysInMonth = firstDayNextMonth.difference(firstDayThisMonth).inDays;
  return daysInMonth;
}

//para calcular los dias hasta los dos meses siguientes
int daysInTwoMonth(DateTime date) {
  var firstDayThisMonth = DateTime(date.year, date.month, date.day);
  var firstDayNextMonth = DateTime(date.year, date.month + 2, date.day);
  var daysInMonth = firstDayNextMonth.difference(firstDayThisMonth).inDays;
  return daysInMonth;
}

//para calcular los dias hasta los tres meses siguientes
int daysInThreeMonth(DateTime date) {
  var firstDayThisMonth = DateTime(date.year, date.month, date.day);
  var firstDayNextMonth = DateTime(date.year, date.month + 3, date.day);
  var daysInMonth = firstDayNextMonth.difference(firstDayThisMonth).inDays;
  return daysInMonth;
}

//para saber si son el mismo dia
bool isAtSameDayAs(DateTime date1, DateTime date2) {
  if (date1.year == date2.year && date1.month == date2.month && date1.day == date2.day) {
    return true;
  } else {
    return false;
  }
}

String formatDateInfo(String date) {
  List<String> partes = date.split('-');
  return '${partes[2]}-${partes[1]}-${partes[0]}';
}

List<String> getDays(List<String> repetir, DateTime fechaInicio) {
  List<String> dias = [];
  if (repetir.isEmpty) {  
    //el habito no se repite, solo aparecerá el dia de la fecha de inicio
    dias.add(DateFormat('yyyy-MM-dd').format(fechaInicio));
    return dias;
  } else if (repetir.contains('Monday') ||     
              repetir.contains('Tuesday') ||
              repetir.contains('Wednesday') ||
              repetir.contains('Thursday') ||
              repetir.contains('Friday') ||
              repetir.contains('Saturday') ||
              repetir.contains('Sunday')) {
    //puede aparecer los lunes, martes... pero solo segun dias de la semana
    DateTime now = DateTime.now();
    while (fechaInicio.isBefore(now)) {
      if (repetir.contains(DateFormat('EEEE').format(fechaInicio))) {
        dias.add(DateFormat('yyyy-MM-dd').format(fechaInicio));
      }
      fechaInicio = fechaInicio.add(Duration(days: 1));
    }
    return dias;
    
    //puede aparecer fechas concretas
    //puede aparecer según 1 intervalo
  } else if (repetir.contains('Every 2 days') || 
              repetir.contains('Every 3 days') ||
              repetir.contains('Every 4 days') ||
              repetir.contains('Every 5 days') ||
              repetir.contains('Every 6 days') ||
              repetir.contains('Every 2 weeks') ||
              repetir.contains('Every 3 weeks') ||
              repetir.contains('Every month') ||
              repetir.contains('Every 2 months') ||
              repetir.contains('Every 3 months')) {
    DateTime now = DateTime.now();
    if (repetir.contains('Every 2 days')) {
      while (fechaInicio.isBefore(now)) {
        dias.add(DateFormat('yyyy-MM-dd').format(fechaInicio));
        fechaInicio = fechaInicio.add(Duration(days: 2));
      }
      return dias;
    } else if (repetir.contains('Every 3 days')) {
      while (fechaInicio.isBefore(now)) {
        dias.add(DateFormat('yyyy-MM-dd').format(fechaInicio));
        fechaInicio = fechaInicio.add(Duration(days: 3));
      }
      return dias;
    } else if (repetir.contains('Every 4 days')) {
      while (fechaInicio.isBefore(now)) {
        dias.add(DateFormat('yyyy-MM-dd').format(fechaInicio));
        fechaInicio = fechaInicio.add(Duration(days: 4));
      }
      return dias;
    } else if (repetir.contains('Every 5 days')) {
      while (fechaInicio.isBefore(now)) {
        dias.add(DateFormat('yyyy-MM-dd').format(fechaInicio));
        fechaInicio = fechaInicio.add(Duration(days: 5));
      }
      return dias;
    } else if (repetir.contains('Every 6 days')) {
      while (fechaInicio.isBefore(now)) {
        dias.add(DateFormat('yyyy-MM-dd').format(fechaInicio));
        fechaInicio = fechaInicio.add(Duration(days: 6));
      }
      return dias;
    } else if (repetir.contains('Every 2 weeks')) {
      while (fechaInicio.isBefore(now)) {
        dias.add(DateFormat('yyyy-MM-dd').format(fechaInicio));
        fechaInicio = fechaInicio.add(Duration(days: 14));
      }
      return dias;
    } else if (repetir.contains('Every 3 weeks')) {
      while (fechaInicio.isBefore(now)) {
        dias.add(DateFormat('yyyy-MM-dd').format(fechaInicio));
        fechaInicio = fechaInicio.add(Duration(days: 21));
      }
      return dias;
    } else if (repetir.contains('Every month')) {
      while (fechaInicio.isBefore(now)) {
        dias.add(DateFormat('yyyy-MM-dd').format(fechaInicio));
        fechaInicio = fechaInicio.add(Duration(days: daysInOneMonth(fechaInicio)));
      }
      return dias;
    } else if (repetir.contains('Every 2 months')) {
      while (fechaInicio.isBefore(now)) {
        dias.add(DateFormat('yyyy-MM-dd').format(fechaInicio));
        fechaInicio = fechaInicio.add(Duration(days: daysInTwoMonth(fechaInicio)));
      }
      return dias;
    } else if (repetir.contains('Every 3 months')) {
      while (fechaInicio.isBefore(now)) {
        dias.add(DateFormat('yyyy-MM-dd').format(fechaInicio));
        fechaInicio = fechaInicio.add(Duration(days: daysInThreeMonth(fechaInicio)));
      }
      return dias;
    }
  } else {  //(la fecha de inicio en este caso no se tiene en cuenta, solo los dias seleccionados en el calendario)
    for(String element in repetir) {
      dias.add(element);
    }
    return dias;
  }
  return dias;
}

Color getProgressColor22(double value) {
  if (value < 0.1) {
    return Colors.white;
  } else if (value < 0.2) {
    return const Color.fromARGB(255, 140, 255, 0);
  } else if (value < 0.3) {
    return const Color.fromARGB(255, 0, 151, 10);
  } else if (value < 0.4) {
    return const Color.fromARGB(255, 0, 104, 3);
  } else if (value < 0.5) {
    return const Color.fromARGB(255, 255, 217, 0);
  } else if (value < 0.6) {
    return const Color.fromARGB(255, 255, 179, 0);
  } else if (value < 0.7) {
    return const Color.fromARGB(255, 255, 140, 0);
  } else if (value < 0.8) {
    return const Color.fromARGB(255, 255, 89, 0);
  } else if (value < 0.9) {
    return const Color.fromARGB(255, 255, 51, 0);
  } else {
    return const Color.fromARGB(255, 187, 0, 0);
  }
}

Color getProgressColor21(double value) {
  if (value == 1.0) {
    return Colors.white;
  } else if (value == 2.0) {
    return const Color.fromARGB(255, 0, 151, 10);
  } else if (value == 3.0) {
    return const Color.fromARGB(255, 255, 217, 0);
  } else if (value == 4.0) {
    return const Color.fromARGB(255, 255, 140, 0);
  } else if (value == 5.0) {
    return const Color.fromARGB(255, 255, 51, 0);
  } else {
    return const Color.fromARGB(255, 187, 0, 0);
  }
}