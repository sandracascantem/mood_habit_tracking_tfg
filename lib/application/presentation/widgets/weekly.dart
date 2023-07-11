import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];

void ordenar(List<String> days) {
  List<String> daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
  List<String> orderedDays = [];

  for (int i = 0; i < daysOfWeek.length; i++) {
    if (days.contains(daysOfWeek[i])) {
      orderedDays.add(daysOfWeek[i]);
    }
  }

  days..clear()..addAll(orderedDays);
}

class Weekly extends StatefulWidget {
  const Weekly({Key? key}) : super(key: key);

  @override
  State<Weekly> createState() => _WeeklyState();
}

class _WeeklyState extends State<Weekly> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          SizedBox(height: 10),
          ValueListenableBuilder(
            valueListenable: mondaySelected.isMondaySelected,
            builder: (context, value, _) {
              return GestureDetector(
                onTap: () {
                  if(mondaySelected.isMondaySelected.value) {
                    mondaySelected.isMondaySelected.value = false;
                    days.remove("Monday");
                  } else {
                    mondaySelected.isMondaySelected.value = true;
                    days.add("Monday");
                  }
                  print(mondaySelected.isMondaySelected.value);
                  ordenar(days);
                  print(days);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal:30, vertical: 5),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DefaultTextStyle(
                        style: GoogleFonts.roboto(
                          fontSize: 18, 
                          color: const Color(0xFFf2e9e4),
                        ),
                        child: const Text(
                          "Monday",
                        ),
                      ),
                      mondaySelected.isMondaySelected.value ? const Icon(Icons.done) : const SizedBox(height: 1, width: 1),
                    ],
                  ),
                ),
              );
            },
          ),
          Divider(
            thickness: 1,
            color: Colors.grey.shade600,
            indent: 20,
            endIndent: 20,
          ),
          ValueListenableBuilder(
            valueListenable: tuesdaySelected.isTuesdaySelected,
            builder: (context, value, _) {
              return GestureDetector(
                onTap: () {
                  if(tuesdaySelected.isTuesdaySelected.value) {
                    tuesdaySelected.isTuesdaySelected.value = false;
                    days.remove("Tuesday");
                  } else {
                    tuesdaySelected.isTuesdaySelected.value = true;
                    days.add("Tuesday");
                  }
                  print(tuesdaySelected.isTuesdaySelected.value);
                  ordenar(days);
                  print(days);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal:30, vertical: 5),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DefaultTextStyle(
                        style: GoogleFonts.roboto(
                          fontSize: 18, 
                          color: const Color(0xFFf2e9e4),
                        ),
                        child: const Text(
                          "Tuesday",
                        ),
                      ),
                      tuesdaySelected.isTuesdaySelected.value ? const Icon(Icons.done) : const SizedBox(height: 1, width: 1),
                    ],
                  ),
                ),
              );
            },
          ),
          Divider(
            thickness: 1,
            color: Colors.grey.shade600,
            indent: 20,
            endIndent: 20,
          ),
          ValueListenableBuilder(
            valueListenable: wednesdaySelected.isWednesdaySelected,
            builder: (context, value, _) {
              return GestureDetector(
                onTap: () {
                  if(wednesdaySelected.isWednesdaySelected.value) {
                    wednesdaySelected.isWednesdaySelected.value = false;
                    days.remove("Wednesday");
                  } else {
                    wednesdaySelected.isWednesdaySelected.value = true;
                    days.add("Wednesday");
                  }
                  print(wednesdaySelected.isWednesdaySelected.value);
                  ordenar(days);
                  print(days);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal:30, vertical: 5),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DefaultTextStyle(
                        style: GoogleFonts.roboto(
                          fontSize: 18, 
                          color: Color(0xFFf2e9e4),
                        ),
                        child: const Text(
                          "Wednesday",
                        ),
                      ),
                      wednesdaySelected.isWednesdaySelected.value ? const Icon(Icons.done) : const SizedBox(height: 1, width: 1),
                    ],
                  ),
                ),
              );
            },
          ),
          Divider(
            thickness: 1,
            color: Colors.grey.shade600,
            indent: 20,
            endIndent: 20,
          ),
          ValueListenableBuilder(
            valueListenable: thursdaySelected.isThursdaySelected,
            builder: (context, value, _) {
              return GestureDetector(
                onTap: () {
                  if(thursdaySelected.isThursdaySelected.value) {
                    thursdaySelected.isThursdaySelected.value = false;
                    days.remove("Thursday");
                  } else {
                    thursdaySelected.isThursdaySelected.value = true;
                    days.add("Thursday");
                  }
                  print(thursdaySelected.isThursdaySelected.value);
                  ordenar(days);
                  print(days);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal:30, vertical: 5),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DefaultTextStyle(
                        style: GoogleFonts.roboto(
                          fontSize: 18, 
                          color: const Color(0xFFf2e9e4),
                        ),
                        child: const Text(
                          "Thursday",
                        ),
                      ),
                      thursdaySelected.isThursdaySelected.value ? const Icon(Icons.done) : const SizedBox(height: 1, width: 1),
                    ],
                  ),
                ),
              );
            },
          ),
          Divider(
            thickness: 1,
            color: Colors.grey.shade600,
            indent: 20,
            endIndent: 20,
          ),
          ValueListenableBuilder(
            valueListenable: fridaySelected.isFridaySelected,
            builder: (context, value, _) {
              return GestureDetector(
                onTap: () {
                  if(fridaySelected.isFridaySelected.value) {
                    fridaySelected.isFridaySelected.value = false;
                    days.remove("Friday");
                  } else {
                    fridaySelected.isFridaySelected.value = true;
                    days.add("Friday");
                  }
                  print(fridaySelected.isFridaySelected.value);
                  ordenar(days);
                  print(days);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal:30, vertical: 5),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DefaultTextStyle(
                        style: GoogleFonts.roboto(
                          fontSize: 18, 
                          color: const Color(0xFFf2e9e4),
                        ),
                        child: const Text(
                          "Friday",
                        ),
                      ),
                      fridaySelected.isFridaySelected.value ? const Icon(Icons.done) : const SizedBox(height: 1, width: 1),
                    ],
                  ),
                ),
              );
            },
          ),
          Divider(
            thickness: 1,
            color: Colors.grey.shade600,
            indent: 20,
            endIndent: 20,
          ),
          ValueListenableBuilder(
            valueListenable: saturdaySelected.isSaturdaySelected,
            builder: (context, value, _) {
              return GestureDetector(
                onTap: () {
                  if(saturdaySelected.isSaturdaySelected.value) {
                    saturdaySelected.isSaturdaySelected.value = false;
                    days.remove("Saturday");
                  } else {
                    saturdaySelected.isSaturdaySelected.value = true;
                    days.add("Saturday");
                  }
                  print(saturdaySelected.isSaturdaySelected.value);
                  ordenar(days);
                  print(days);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal:30, vertical: 5),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DefaultTextStyle(
                        style: GoogleFonts.roboto(
                          fontSize: 18, 
                          color: Color(0xFFf2e9e4),
                        ),
                        child: const Text(
                          "Saturday",
                        ),
                      ),
                      saturdaySelected.isSaturdaySelected.value ? const Icon(Icons.done) : const SizedBox(height: 1, width: 1),
                    ],
                  ),
                ),
              );
            },
          ),
          Divider(
            thickness: 1,
            color: Colors.grey.shade600,
            indent: 20,
            endIndent: 20,
          ),
          ValueListenableBuilder(
            valueListenable: sundaySelected.isSundaySelected,
            builder: (context, value, _) {
              return GestureDetector(
                onTap: () {
                  if(sundaySelected.isSundaySelected.value) {
                    sundaySelected.isSundaySelected.value = false;
                    days.remove("Sunday");
                  } else {
                    sundaySelected.isSundaySelected.value = true;
                    days.add("Sunday");
                  }
                  print(sundaySelected.isSundaySelected.value);
                  ordenar(days);
                  print(days);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal:30, vertical: 5),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DefaultTextStyle(
                        style: GoogleFonts.roboto(
                          fontSize: 18, 
                          color: Color(0xFFf2e9e4),
                        ),
                        child: const Text(
                          "Sunday",
                        ),
                      ),
                      sundaySelected.isSundaySelected.value ? const Icon(Icons.done) : const SizedBox(height: 1, width: 1),
                    ],
                  ),
                ),
              );
            },
          ),
          Divider(
            thickness: 1,
            color: Colors.grey.shade600,
            indent: 20,
            endIndent: 20,
          ),
        ],
      ),
    );
  }
}

class MondaySelected with ChangeNotifier {
  ValueNotifier<bool> isMondaySelected = ValueNotifier(true);
}
MondaySelected mondaySelected = MondaySelected();

class TuesdaySelected with ChangeNotifier {
  ValueNotifier<bool> isTuesdaySelected = ValueNotifier(true);
}
TuesdaySelected tuesdaySelected = TuesdaySelected();

class WednesdaySelected with ChangeNotifier {
  ValueNotifier<bool> isWednesdaySelected = ValueNotifier(true);
}
WednesdaySelected wednesdaySelected = WednesdaySelected();

class ThursdaySelected with ChangeNotifier {
  ValueNotifier<bool> isThursdaySelected = ValueNotifier(true);
}
ThursdaySelected thursdaySelected = ThursdaySelected();

class FridaySelected with ChangeNotifier {
  ValueNotifier<bool> isFridaySelected = ValueNotifier(true);
}
FridaySelected fridaySelected = FridaySelected();

class SaturdaySelected with ChangeNotifier {
  ValueNotifier<bool> isSaturdaySelected = ValueNotifier(true);
}
SaturdaySelected saturdaySelected = SaturdaySelected();

class SundaySelected with ChangeNotifier {
  ValueNotifier<bool> isSundaySelected = ValueNotifier(true);
}
SundaySelected sundaySelected = SundaySelected();
