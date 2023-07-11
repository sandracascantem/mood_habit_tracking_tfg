import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_habit_tracking_tfg/application/business_logic/habit_cubit.dart';
import 'package:mood_habit_tracking_tfg/core/constants/colors.dart';
import 'package:mood_habit_tracking_tfg/core/functions/functions.dart';
import 'package:mood_habit_tracking_tfg/data/habit_tracking.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ListHabitsToday extends StatefulWidget {
  ListHabitsToday({Key? key, this.habit});

  final habit;

  @override
  State<ListHabitsToday> createState() => _ListHabitsTodayState();
}

class _ListHabitsTodayState extends State<ListHabitsToday> {
  bool _showSlider = false;
  double _sliderValue1 = 0.0;
  double _sliderValue21 = 1.0;
  double _sliderValue22 = 0.0;

  @override
  void initState() {
    super.initState();
    widget.habit.tracking.forEach((tracking) {
      print(tracking.toString());
    });
    if (widget.habit.tracking.isNotEmpty &&
      widget.habit.tracking.any((habitTracking) => habitTracking.date == DateFormat('dd-MM-yyyy').format(DateTime.now()))) {
      // Se encontró un elemento con la fecha de hoy
      final habitTrackingToday = widget.habit.tracking.firstWhere(
          (habitTracking) => habitTracking.date == DateFormat('dd-MM-yyyy').format(DateTime.now()));
      final todayTracking = habitTrackingToday.tracking;
      if(widget.habit.type == 'Sport' || widget.habit.type == 'Sleep' || widget.habit.type == 'Study' || widget.habit.type == 'Work' || widget.habit.type == 'Other') {
        final time = todayTracking["hours"];
        final minutGoal = widget.habit.goal[0]*60 + widget.habit.goal[1];
        final intens = todayTracking["intensity_quality"];
        _sliderValue1 = time*60 / minutGoal;
        _sliderValue21 = intens.toDouble();
      } else if(widget.habit.type == 'Nutrition') {
        final food = todayTracking["meals"];
        final sano = todayTracking["healthy"];
        _sliderValue1 = food.toDouble();
        _sliderValue22 = sano.toDouble();
      } else {
        final vasos = todayTracking["glasses"];
        _sliderValue1 = vasos.toDouble();
      }
    } else {
      // No se encontró ningún elemento con la fecha de hoy
        _sliderValue1 = 0.0;
        _sliderValue21 = 1.0;
        _sliderValue22 = 0.0;
    }   
  }

  @override
  Widget build(BuildContext context) {
    final divisions1 = (widget.habit.type == 'Sport' ||
            widget.habit.type == 'Sleep' ||
            widget.habit.type == 'Study' ||
            widget.habit.type == 'Work' ||
            widget.habit.type == 'Other')
        ? ((widget.habit.goal[0] * 60 + widget.habit.goal[1]) / 10).ceil()
        : (widget.habit.type == 'Hydration' || widget.habit.type == 'Nutrition')
            ? widget.habit.goal[0]
            : 0;
    final label1 = (widget.habit.type == 'Sport' ||
            widget.habit.type == 'Sleep' ||
            widget.habit.type == 'Study' ||
            widget.habit.type == 'Work' ||
            widget.habit.type == 'Other')
        ? '${(((_sliderValue1 * divisions1).round()) * 10) ~/ 60}h ${(((_sliderValue1 * divisions1).round()) * 10) % 60}min'
        : widget.habit.type == 'Hydration'
            ? '${(_sliderValue1 * divisions1) ~/ 1}glasses'
            : widget.habit.type == 'Nutrition'
                ? '${(_sliderValue1 * divisions1) ~/ 1}meals'
                : '';
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _showSlider = !_showSlider;
                    });
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: widget.habit.type == 'Sport'
                            ? const AssetImage('assets/deporte.jpg')
                            : (widget.habit.type == 'Sleep'
                                ? const AssetImage('assets/sueno.jpg')
                                : (widget.habit.type == 'Hydration'
                                    ? const AssetImage('assets/beberAgua.jpg')
                                    : (widget.habit.type == 'Nutrition'
                                        ? const AssetImage('assets/comer.jpg')
                                        : (widget.habit.type == 'Study'
                                            ? const AssetImage(
                                                'assets/estudio.jpg')
                                            : (widget.habit.type == 'Work'
                                                ? const AssetImage(
                                                    'assets/trabajo.jpg')
                                                : (widget.habit.type == 'Other'
                                                    ? const AssetImage(
                                                        'assets/otro.jpg')
                                                    : const AssetImage(
                                                        'assets/ocio.jpg'))))))),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: CircularPercentIndicator(
                            radius: 30,
                            lineWidth: 7,
                            percent: _sliderValue1,
                            progressColor: (widget.habit.type == 'Sport' ||
                                    widget.habit.type == 'Sleep' ||
                                    widget.habit.type == 'Study' ||
                                    widget.habit.type == 'Work' ||
                                    widget.habit.type == 'Other')
                                ? getProgressColor21(_sliderValue21)
                                : widget.habit.type == 'Nutrition'
                                    ? getProgressColor22(_sliderValue22)
                                    : Colors.white,
                            backgroundColor:
                                const Color.fromARGB(139, 119, 119, 169),
                            circularStrokeCap: CircularStrokeCap.round,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              height: 78,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(211, 255, 255, 255),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.habit.name ?? 'Default nombre',
                                    style: GoogleFonts.roboto(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: oscurocolor,
                                    ),
                                    overflow: TextOverflow.visible,
                                  ),
                                  Text(
                                    widget.habit.type,
                                    style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: oscurocolor,
                                    ),
                                    overflow: TextOverflow.visible,
                                  ),
                                  Text(
                                    widget.habit.goal == null
                                        ? 'Default goal'
                                        : ((widget.habit.type == 'Sport' ||
                                                widget.habit.type == 'Sleep' ||
                                                widget.habit.type == 'Study' ||
                                                widget.habit.type == 'Work' ||
                                                widget.habit.type == 'Other')
                                            ? '${widget.habit.goal[0]} h ${widget.habit.goal[1]} min'
                                            : (widget.habit.type == 'Hydration'
                                                ? '${widget.habit.goal[0]} water glasses'
                                                : (widget.habit.type ==
                                                        'Nutrition'
                                                    ? '${widget.habit.goal[0]} meals : ${widget.habit.goal[1]} healthy'
                                                    : 'Error'))),
                                    style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      color: oscurocolor,
                                    ),
                                    overflow: TextOverflow.visible,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: _showSlider,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      divisions1 == 0 
                      ? Container()
                      : Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 20.0),
                        child: Text(
                          (widget.habit.type == 'Sport' ||
                                  widget.habit.type == 'Sleep' ||
                                  widget.habit.type == 'Study' ||
                                  widget.habit.type == 'Work' ||
                                  widget.habit.type == 'Other')
                              ? 'Slide the bar to mark how long you have done the habit.'
                              : widget.habit.type == 'Hydration'
                                  ? 'Slide the bar to mark how many glasses you have drunk'
                                  : widget.habit.type == 'Nutrition'
                                      ? 'Slide the bar to indicate how many meals you have eaten'
                                      : 'error',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      divisions1 == 0 
                      ? const Padding(
                        padding: EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 20.0),
                        child: Text(
                          'There is no goal',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.visible,
                        ),
                      )
                      : Slider(
                        value: _sliderValue1,
                        divisions: divisions1,
                        label: label1,
                        onChanged: (double value) {
                          setState(() {
                            _sliderValue1 = value;
                            //print(_sliderValue1);
                          });
                        },
                      ),
                      divisions1 == 0 
                      ? Container()
                      : Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 20.0),
                        child: Text(
                          (widget.habit.type == 'Sport' ||
                                  widget.habit.type == 'Study' ||
                                  widget.habit.type == 'Work' ||
                                  widget.habit.type == 'Other')
                              ? 'Slide the bar to mark the intensity of the habit'
                              : widget.habit.type == 'Sleep'
                                  ? 'Slide the bar to mark the quality of sleep'
                                  : widget.habit.type == 'Hydration'
                                      ? ''
                                      : widget.habit.type == 'Nutrition'
                                          ? 'Slide the bar to indicate how many healthy meals you have eaten'
                                          : 'error',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      divisions1 == 0 
                      ? Container()
                      : (widget.habit.type == 'Sport' ||
                              widget.habit.type == 'Sleep' ||
                              widget.habit.type == 'Study' ||
                              widget.habit.type == 'Work' ||
                              widget.habit.type == 'Other')
                          ? Slider(
                              value: _sliderValue21,
                              min: 1,
                              max: 5,
                              divisions: 4,
                              label: _sliderValue21.round().toString(),
                              onChanged: (double value) {
                                setState(() {
                                  _sliderValue21 = value;
                                  //print(_sliderValue21);
                                  //print(_sliderValue21.toInt());
                                });
                              },
                            )
                          : divisions1 == 0 
                      ? Container()
                      : widget.habit.type == 'Nutrition'
                              ? Slider(
                                  value: _sliderValue22,
                                  min: 0,
                                  max: (widget.habit.goal[1]).toDouble(),
                                  divisions: widget.habit.goal[1],
                                  label: _sliderValue22.round().toString(),
                                  onChanged: (double value) {
                                    setState(() {
                                      _sliderValue22 = value;
                                    });
                                  },
                                )
                              : Container(),
                        divisions1 == 0 
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: OutlinedButton(
                            child: Text(
                              "Save",
                              style: TextStyle(
                                color: botoncolor,
                              ),
                            ),
                            onPressed: () async {
                              final minGoal = widget.habit.goal[0]*60 + widget.habit.goal[1];
                              final minDone = _sliderValue1 * minGoal;
                              final hoursDone = minDone /60;
                              final intqual = _sliderValue21.toInt();
                              final glas = _sliderValue1.toInt();
                              final meal = _sliderValue1.toInt();
                              final health = _sliderValue22.toInt();
                              final tracking;
                              widget.habit.type == "Sport" || widget.habit.type == "Sleep" || widget.habit.type == "Study" || widget.habit.type == "Work" || widget.habit.type == "Other" ? 
                              tracking = {
                                "hours": hoursDone,
                                "intensity_quality": intqual
                              }
                              : widget.habit.type == "Hydration" ?
                              tracking = {
                                "glasses": glas
                              }
                              : widget.habit.type == "Nutrition" ?
                              tracking = {
                                "meals": meal,
                                "healthy": health
                              }
                              : tracking = {};
                              final habitTracking = HabitTracking(
                                date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
                                habit: widget.habit,
                                tracking: tracking
                              );
                              
                              final habitCubit = context.read<HabitCubit>();
                              habitCubit.addTracking(widget.habit, habitTracking);


                              // print(widget.habit.tracking);

                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 20,
          thickness: 1,
          color: Colors.grey.shade800,
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }
}
/*
BlocListener<HabitTrackingCubit, HabitTrackingState>(
  listener: (context, state) {
    if(state is HabitTrackingReceived) {
      if (!_showSlider) {
        final minGoal = widget.habit.goal[0]*60 + widget.habit.goal[1];
        final minDone = _sliderValue1 * minGoal;
        final hoursDone = minDone /60;
        final intqual = _sliderValue21.toInt();
        final glas = _sliderValue1.toInt();
        final meal = _sliderValue1.toInt();
        final health = _sliderValue22.toInt();
        final tracking;
        widget.habit.type == "Sport" || widget.habit.type == "Sleep" || widget.habit.type == "Study" || widget.habit.type == "Work" || widget.habit.type == "Other" ? 
        tracking = {
          "hours": hoursDone,
          "intensity_quality": intqual
        }
        : widget.habit.type == "Hydration" ?
        tracking = {
          "glasses": glas
        }
        : widget.habit.type == "Nutrition" ?
        tracking = {
          "meals": meal,
          "healthy": health
        }
        : tracking = {};
        final habitTracking = HabitTracking(
          date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          habit: widget.habit,
          tracking: tracking
        );
        //final habitTrackingCubit = context.read<HabitTrackingCubit>();
        //habitTrackingCubit.addHabitTracking(widget.habit, habitTracking);
        print(habitTracking);
      }
    }
  },
*/