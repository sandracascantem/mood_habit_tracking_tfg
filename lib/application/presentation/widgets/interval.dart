import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntervalDays extends StatefulWidget {
  const IntervalDays({Key? key}) : super(key: key);

  @override
  State<IntervalDays> createState() => _IntervalDaysState();
}

List<String> interval = [];

class _IntervalDaysState extends State<IntervalDays> {

  List<DefaultTextStyle> _interval = [
    DefaultTextStyle(
      style: GoogleFonts.roboto(
        fontSize: 18, 
        color: Color(0xFFf2e9e4),
      ),
      child: Text(
        "Every 2 days",
      ),
    ),
    DefaultTextStyle(
      style: GoogleFonts.roboto(
        fontSize: 18, 
        color: Color(0xFFf2e9e4),
      ),
      child: Text(
        "Every 3 days",
      ),
    ),
    DefaultTextStyle(
      style: GoogleFonts.roboto(
        fontSize: 18, 
        color: Color(0xFFf2e9e4),
      ),
      child: Text(
        "Every 4 days",
      ),
    ),
    DefaultTextStyle(
      style: GoogleFonts.roboto(
        fontSize: 18, 
        color: Color(0xFFf2e9e4),
      ),
      child: Text(
        "Every 5 days",
      ),
    ),
    DefaultTextStyle(
      style: GoogleFonts.roboto(
        fontSize: 18, 
        color: Color(0xFFf2e9e4),
      ),
      child: Text(
        "Every 6 days",
      ),
    ),
    DefaultTextStyle(
      style: GoogleFonts.roboto(
        fontSize: 18, 
        color: Color(0xFFf2e9e4),
      ),
      child: Text(
        "Every 2 weeks",
      ),
    ),
    DefaultTextStyle(
      style: GoogleFonts.roboto(
        fontSize: 18, 
        color: Color(0xFFf2e9e4),
      ),
      child: Text(
        "Every 3 weeks",
      ),
    ),
    DefaultTextStyle(
      style: GoogleFonts.roboto(
        fontSize: 18, 
        color: Color(0xFFf2e9e4),
      ),
      child: Text(
        "Every month",
      ),
    ),
    DefaultTextStyle(
      style: GoogleFonts.roboto(
        fontSize: 18, 
        color: Color(0xFFf2e9e4),
      ),
      child: Text(
        "Every 2 months",
      ),
    ),
    DefaultTextStyle(
      style: GoogleFonts.roboto(
        fontSize: 18, 
        color: Color(0xFFf2e9e4),
      ),
      child: Text(
        "Every 3 months",
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: [
          const SizedBox(height: 10),
          ValueListenableBuilder(
            valueListenable: intervalSelected.indexIntervalSelected,
            builder: (context, value, _) {
              return GestureDetector(
                onTap: () {
                  if(intervalSelected.indexIntervalSelected.value!=0) {
                    intervalSelected.indexIntervalSelected.value = 0;
                    interval = [];
                    interval.add("Every 2 days");
                  } else {
                    intervalSelected.indexIntervalSelected.value = -1;
                    interval.remove("Every 2 days");
                  }
                  print(intervalSelected.indexIntervalSelected.value);
                  print(interval);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal:30, vertical: 5),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _interval[0],
                      intervalSelected.indexIntervalSelected.value==0 ? const Icon(Icons.done) : const SizedBox(height: 1, width: 1),
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
            valueListenable: intervalSelected.indexIntervalSelected,
            builder: (context, value, _) {
              return GestureDetector(
                onTap: () {
                  if(intervalSelected.indexIntervalSelected.value!=1) {
                    intervalSelected.indexIntervalSelected.value = 1;
                    interval = [];
                    interval.add("Every 3 days");
                  } else {
                    intervalSelected.indexIntervalSelected.value = -1;
                    interval.remove("Every 3 days");
                  }
                  print(intervalSelected.indexIntervalSelected.value);
                  print(interval);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal:30, vertical: 5),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _interval[1],
                      intervalSelected.indexIntervalSelected.value==1 ? const Icon(Icons.done) : const SizedBox(height: 1, width: 1),
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
            valueListenable: intervalSelected.indexIntervalSelected,
            builder: (context, value, _) {
              return GestureDetector(
                onTap: () {
                  if(intervalSelected.indexIntervalSelected.value!=2) {
                    intervalSelected.indexIntervalSelected.value = 2;                      
                    interval = [];
                    interval.add("Every 4 days");
                  } else {
                    intervalSelected.indexIntervalSelected.value = -1;
                    interval.remove("Every 4 days");
                  }
                  print(intervalSelected.indexIntervalSelected.value);
                  print(interval);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal:30, vertical: 5),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _interval[2],
                      intervalSelected.indexIntervalSelected.value==2 ? const Icon(Icons.done) : const SizedBox(height: 1, width: 1),
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
            valueListenable: intervalSelected.indexIntervalSelected,
            builder: (context, value, _) {
              return GestureDetector(
                onTap: () {
                  if(intervalSelected.indexIntervalSelected.value!=3) {
                    intervalSelected.indexIntervalSelected.value = 3;
                    interval = [];
                    interval.add("Every 5 days");
                  } else {
                    intervalSelected.indexIntervalSelected.value = -1;
                    interval.remove("Every 5 days");
                  }
                  print(intervalSelected.indexIntervalSelected.value);
                  print(interval);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal:30, vertical: 5),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _interval[3],
                      intervalSelected.indexIntervalSelected.value==3 ? const Icon(Icons.done) : const SizedBox(height: 1, width: 1),
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
            valueListenable: intervalSelected.indexIntervalSelected,
            builder: (context, value, _) {
              return GestureDetector(
                onTap: () {
                  if(intervalSelected.indexIntervalSelected.value!=4) {
                    intervalSelected.indexIntervalSelected.value = 4;
                    interval = [];
                    interval.add("Every 6 days");
                  } else {
                    intervalSelected.indexIntervalSelected.value = -1;
                    interval.remove("Every 6 days");
                  }
                  print(intervalSelected.indexIntervalSelected.value);
                  print(interval);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal:30, vertical: 5),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _interval[4],
                      intervalSelected.indexIntervalSelected.value==4 ? const Icon(Icons.done) : const SizedBox(height: 1, width: 1),
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
            valueListenable: intervalSelected.indexIntervalSelected,
            builder: (context, value, _) {
              return GestureDetector(
                onTap: () {
                  if(intervalSelected.indexIntervalSelected.value!=5) {
                    intervalSelected.indexIntervalSelected.value = 5;
                    interval = [];
                    interval.add("Every 2 weeks");
                  } else {
                    intervalSelected.indexIntervalSelected.value = -1;
                    interval.remove("Every 2 weeks");
                  }
                  print(intervalSelected.indexIntervalSelected.value);
                  print(interval);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal:30, vertical: 5),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _interval[5],
                      intervalSelected.indexIntervalSelected.value==5 ? const Icon(Icons.done) : const SizedBox(height: 1, width: 1),
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
            valueListenable: intervalSelected.indexIntervalSelected,
            builder: (context, value, _) {
              return GestureDetector(
                onTap: () {
                  if(intervalSelected.indexIntervalSelected.value!=6) {
                    intervalSelected.indexIntervalSelected.value = 6;
                    interval = [];
                    interval.add("Every 3 weeks");
                  } else {
                    intervalSelected.indexIntervalSelected.value = -1;
                    interval.remove("Every 3 weeks");
                  }
                  print(intervalSelected.indexIntervalSelected.value);
                  print(interval);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal:30, vertical: 5),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _interval[6],
                      intervalSelected.indexIntervalSelected.value==6 ? const Icon(Icons.done) : const SizedBox(height: 1, width: 1),
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
            valueListenable: intervalSelected.indexIntervalSelected,
            builder: (context, value, _) {
              return GestureDetector(
                onTap: () {
                  if(intervalSelected.indexIntervalSelected.value!=7) {
                    intervalSelected.indexIntervalSelected.value = 7;
                    interval = [];
                    interval.add("Every month");
                  } else {
                    intervalSelected.indexIntervalSelected.value = -1;
                    interval.remove("Every month");
                  }
                  print(intervalSelected.indexIntervalSelected.value);
                  print(interval);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal:30, vertical: 5),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _interval[7],
                      intervalSelected.indexIntervalSelected.value==7 ? const Icon(Icons.done) : const SizedBox(height: 1, width: 1),
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
            valueListenable: intervalSelected.indexIntervalSelected,
            builder: (context, value, _) {
              return GestureDetector(
                onTap: () {
                  if(intervalSelected.indexIntervalSelected.value!=8) {
                    intervalSelected.indexIntervalSelected.value = 8;
                    interval = [];
                    interval.add("Every 2 months");
                  } else {
                    intervalSelected.indexIntervalSelected.value = -1;
                    interval.remove("Every 2 months");
                  }
                  print(intervalSelected.indexIntervalSelected.value);
                  print(interval);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal:30, vertical: 5),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _interval[8],
                      intervalSelected.indexIntervalSelected.value==8 ? const Icon(Icons.done) : const SizedBox(height: 1, width: 1),
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
            valueListenable: intervalSelected.indexIntervalSelected,
            builder: (context, value, _) {
              return GestureDetector(
                onTap: () {
                  if(intervalSelected.indexIntervalSelected.value!=9) {
                    intervalSelected.indexIntervalSelected.value = 9;
                    interval = [];
                    interval.add("Every 3 months");
                  } else {
                    intervalSelected.indexIntervalSelected.value = -1;
                    interval.remove("Every 3 months");
                  }
                  print(intervalSelected.indexIntervalSelected.value);
                  print(interval);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal:30, vertical: 5),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _interval[9],
                      intervalSelected.indexIntervalSelected.value==9 ? const Icon(Icons.done) : const SizedBox(height: 1, width: 1),
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

class IntervalSelected with ChangeNotifier {
  ValueNotifier<int> indexIntervalSelected = ValueNotifier(-1);
}
IntervalSelected intervalSelected = IntervalSelected();