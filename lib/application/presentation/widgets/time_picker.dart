import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_habit_tracking_tfg/core/constants/colors.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({Key? key}) : super(key: key);

  @override
  State<TimePicker> createState() => _TimePickerState();
}

int selectedHour = 0;
int selectedMinute = 0;

class _TimePickerState extends State<TimePicker> {

  @override
  void initState() {
    super.initState();
    selectedHour = 0;
    selectedMinute = 0;
  }
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            child: CupertinoPicker(
              looping: true,
              itemExtent: 30,
              onSelectedItemChanged: (value) {
                setState(() {
                  selectedHour = value;
                });
              },
              children: List<Widget>.generate(24, (index) {
                return Center(
                  child: Text(
                    index.toString().padLeft(2, '0'),
                    style: GoogleFonts.roboto(
                      fontSize: 22,
                      color: clarocolor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }),
            ),
          ),
          Container(
            child: Text(
              ':',
              style: GoogleFonts.roboto(
                fontSize: 22,
                color: clarocolor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            width: 100,
            child: CupertinoPicker(
              looping: true,
              itemExtent: 30,
              onSelectedItemChanged: (value) {
                setState(() {
                  selectedMinute = value * 10; // Multiplicar por 10 para obtener el valor de los minutos seleccionados
                });
              },
              children: List<Widget>.generate(6, (index) { // Solo generar 6 elementos para los minutos
                int minute = index * 10;
                return Center(
                  child: Text(
                    minute.toString().padLeft(2, '0'),
                    style: GoogleFonts.roboto(
                      fontSize: 22,
                      color: clarocolor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }),
            ),
          ),

        ],
      ),
    );
  }
}
