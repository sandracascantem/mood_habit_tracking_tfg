import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_habit_tracking_tfg/core/constants/colors.dart';

class WaterPicker extends StatefulWidget {
  const WaterPicker({Key? key}) : super(key: key);

  @override
  State<WaterPicker> createState() => _WaterPickerState();
}

int selectedVasos = 0;

class _WaterPickerState extends State<WaterPicker> {

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
                  selectedVasos = value;
                });
              },
              children: List<Widget>.generate(13, (index) {
                return Center(
                  child: Text(
                    index.toString(),
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
