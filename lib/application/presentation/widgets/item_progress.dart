import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_habit_tracking_tfg/application/presentation/widgets/bar_graph.dart';
import 'package:mood_habit_tracking_tfg/core/constants/colors.dart';
import 'package:mood_habit_tracking_tfg/core/functions/functions.dart';

// ignore: must_be_immutable
class ItemProgress extends StatelessWidget {
  const ItemProgress ({super.key, this.habit});

  final habit;

  @override
  Widget build(BuildContext context) {
    double goal = 0.0;
    double inten = 0.0;
    List<String> diasTotales = [];
    List<String> dias = [];
    List<double> sumario1 = [];
    List<double> sumario2 = [];
    if (habit.type == 'Sport' || habit.type == 'Sleep' || habit.type == 'Study' || habit.type == 'Work' || habit.type == 'Other') {
      goal = habit.goal[0] + habit.goal[1]/60;  //num horas
      inten = 5;
      //print(inten);
      //calcular cuantos dias han pasado desde que comenzó el hábito (para ultimos 15 dias)
      DateTime fecha = DateTime.parse(habit.startDate);
      print(fecha);
      diasTotales = getDays(habit.repeat, fecha);
      print(diasTotales);
      diasTotales.length >= 15 ?  dias = diasTotales.take(15).toList() 
        : dias = [...diasTotales, ...List.filled(15 - diasTotales.length, '')];
      print(dias);
      for (String fecha in dias) {
        var tracking;
        for (var habitTracking in habit.tracking) {
          if (fecha != '') {
            if (habitTracking.date == formatDateInfo(fecha)) {
              tracking = habitTracking;
              break;
            }
          }
        }
        print('tracking: $tracking');
        if (tracking != null) {
          sumario1.add(tracking.tracking["hours"]);
          sumario2.add(double.parse(tracking.tracking["intensity_quality"].toString()));
        } else {
          sumario1.add(0.0);
          sumario2.add(0.0);
        }
      }
      print(sumario1);
      print(sumario2);
    } else if (habit.type == 'Hydration') {
      goal = double.parse((habit.goal[0]).toString());  //num vasos
      //calcular cuantos dias han pasado desde que comenzó el hábito (para ultimos 15 dias)
      DateTime fecha = DateTime.parse(habit.startDate);
      diasTotales = getDays(habit.repeat, fecha);
      print(diasTotales);
      diasTotales.length >= 15 ?  dias = diasTotales.take(15).toList() 
        : dias = [...diasTotales, ...List.filled(15 - diasTotales.length, '')];
      print(dias);
      for (String fecha in dias) {
        var tracking = habit.tracking.firstWhere(
          (tracking) => tracking.date == formatDate(fecha),
          orElse: () => null,
        );
        
        if (tracking != null) {
          sumario1.add(double.parse(tracking.tracking["glasses"].toString()));
        } else {
          sumario1.add(0.0);
        }
      }
      print(sumario1);
    } else {
      goal = double.parse((habit.goal[0]).toString());   //num comidas
      inten = double.parse((habit.goal[1]).toString());   //num sanas
      print(inten);
      //calcular cuantos dias han pasado desde que comenzó el hábito (para ultimos 15 dias)
      DateTime fecha = DateTime.parse(habit.startDate);
      diasTotales = getDays(habit.repeat, fecha);
      print(diasTotales);
      diasTotales.length >= 15 ?  dias = diasTotales.take(15).toList() 
        : dias = [...diasTotales, ...List.filled(15 - diasTotales.length, '')];
      print(dias);
      for (String fecha in dias) {
        var tracking = habit.tracking.firstWhere(
          (tracking) => tracking.date == formatDate(fecha),
          orElse: () => null,
        );
        
        if (tracking != null) {
          sumario1.add(double.parse(tracking.tracking["meals"].toString()));
          sumario2.add(double.parse(tracking.tracking["healthy"].toString()));
        } else {
          sumario1.add(0.0);
          sumario2.add(0.0);
        }
      }
      print(sumario1);
      print(sumario2);
    }

    return Scaffold(
      backgroundColor: bgcolor,
      appBar: CupertinoNavigationBar(
        automaticallyImplyLeading: true,
        backgroundColor: bgcolor,
        middle: Text(
          habit.name ?? 'Progress',
          style: GoogleFonts.roboto(
            fontSize: 26,
            color: clarocolor,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [ 
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 15,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'The last 15 days are displayed:',
                style: TextStyle(
                  color: clarocolor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.visible,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 15,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              alignment: Alignment.centerLeft,
              child: Text(
                (habit.type == 'Sport' || habit.type == 'Sleep' || habit.type == 'Study' || habit.type == 'Work' || habit.type == 'Other') ? 'Hours'
                  : habit.type == 'Hydration' ? 'Glasses'
                    : habit.type == 'Nutrition' ? 'Meals'
                      : '',
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 15,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                height: 300,
                child: MyBarGraph(
                  sumario1: sumario1,
                  objetivo: goal,
                  tipo: habit.type,
                  orden: 0,
                  dias: dias,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              alignment: Alignment.centerLeft,
              child: Text(
                (habit.type == 'Sport' || habit.type == 'Study' || habit.type == 'Work' || habit.type == 'Other') ? 'Intensity'
                  : habit.type == 'Sleep' ? 'Sleep quality'
                    : habit.type == 'Nutrition' ? 'Healthy meals'
                      : '',
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 15,
            ),
          ),
          habit.type == 'Hydration'
          ? const SliverToBoxAdapter(
            child: SizedBox(
              height: 5,
            ),
          )
          : SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                height: 250,
                child: MyBarGraph(
                  sumario1: sumario2,
                  objetivo: inten,
                  tipo: habit.type,
                  orden: 1,
                  dias: dias,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
            ),
          ),
        ],
      ),
    );
  }
}

