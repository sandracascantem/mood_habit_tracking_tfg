// ignore_for_file: sort_child_properties_last

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class IndividualBar {
  final int x;  //posicion eje x
  final double y1; //posicion eje y

  IndividualBar({
    required this.x,
    required this.y1,
  });
}

class BarData {
  final double valor1dia1;
  final double valor1dia2;
  final double valor1dia3;
  final double valor1dia4;
  final double valor1dia5;
  final double valor1dia6;
  final double valor1dia7;
  final double valor1dia8;
  final double valor1dia9;
  final double valor1dia10;
  final double valor1dia11;
  final double valor1dia12;
  final double valor1dia13;
  final double valor1dia14;
  final double valor1dia15;

  BarData({
    required this.valor1dia1,
    required this.valor1dia2,
    required this.valor1dia3,
    required this.valor1dia4,
    required this.valor1dia5,
    required this.valor1dia6,
    required this.valor1dia7,
    required this.valor1dia8,
    required this.valor1dia9,
    required this.valor1dia10,
    required this.valor1dia11,
    required this.valor1dia12,
    required this.valor1dia13,
    required this.valor1dia14,
    required this.valor1dia15,
  });

  List<IndividualBar> barData = [];

  //Inicializar barData
  void initializeBarData() {
    barData = [
      IndividualBar(x: 0, y1: valor1dia1),
      IndividualBar(x: 1, y1: valor1dia2),
      IndividualBar(x: 2, y1: valor1dia3),
      IndividualBar(x: 3, y1: valor1dia4),
      IndividualBar(x: 4, y1: valor1dia5),
      IndividualBar(x: 5, y1: valor1dia6),
      IndividualBar(x: 6, y1: valor1dia7),
      IndividualBar(x: 7, y1: valor1dia8),
      IndividualBar(x: 8, y1: valor1dia9),
      IndividualBar(x: 9, y1: valor1dia10),
      IndividualBar(x: 10, y1: valor1dia11),
      IndividualBar(x: 11, y1: valor1dia12),
      IndividualBar(x: 12, y1: valor1dia13),
      IndividualBar(x: 13, y1: valor1dia14),
      IndividualBar(x: 14, y1: valor1dia15),
    ];
  }
}

class MyBarGraph extends StatefulWidget {
  const MyBarGraph({super.key, required this.sumario1, required this.objetivo, required this.tipo, required this.orden, required this.dias});
    
    final List sumario1;  
    final objetivo;
    final tipo;
    final orden;
    final List<String> dias;

  @override
  State<MyBarGraph> createState() => _MyBarGraphState();
}
List<String> dias = [];

class _MyBarGraphState extends State<MyBarGraph> {

  @override
  Widget build(BuildContext context) {
    
    //inicializar barData
    BarData myBarData;
    myBarData = BarData(
      valor1dia1: widget.sumario1[0], 
      valor1dia2: widget.sumario1[1], 
      valor1dia3: widget.sumario1[2], 
      valor1dia4: widget.sumario1[3],  
      valor1dia5: widget.sumario1[4],  
      valor1dia6: widget.sumario1[5],  
      valor1dia7: widget.sumario1[6],
      valor1dia8: widget.sumario1[7], 
      valor1dia9: widget.sumario1[8], 
      valor1dia10: widget.sumario1[9], 
      valor1dia11: widget.sumario1[10],  
      valor1dia12: widget.sumario1[11],  
      valor1dia13: widget.sumario1[12],  
      valor1dia14: widget.sumario1[13], 
      valor1dia15: widget.sumario1[14], 
    );
    myBarData.initializeBarData();

    //dias para el eje x:
    List<String> diasMal = (widget.dias).map((dia) => formatDate(dia)).toList();
    dias = (diasMal).map((dia) => formatDateStr(dia)).toList();

    return AspectRatio(
      aspectRatio: 2,
      child: BarChart(
        BarChartData(
          maxY: widget.objetivo,
          minY: 0,
          gridData: FlGridData(
            show: true, 
          ),
          borderData: FlBorderData(
            show: false,
          ),
          
          titlesData: FlTitlesData(
            show: true,
            topTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: (widget.orden == 1 || ((widget.tipo == 'Hidratación' || widget.tipo == 'Alimentación') && widget.orden == 0))
                  ? 1 
                  : 0.5,
                reservedSize: 30,
              ),
            ),
            bottomTitles: AxisTitles(
              drawBehindEverything: false,
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: getBotomTitles,
              ),
            ),
          ),
          
          barGroups: myBarData.barData.map((data) => BarChartGroupData(
            x: data.x,
            barRods: [
              BarChartRodData(
                toY: data.y1,
                color: widget.orden == 0 ? Colors.blue : Colors.red,
                width: 8,
                borderRadius: BorderRadius.circular(3),
                borderSide: BorderSide(
                  width: 1,
                ),
              )
            ],
          )).toList(),
        ),
      ),
    );
  }
}

Widget getBotomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.white,
    fontSize: 10,
  );
  Widget text;
  switch(value.toInt()) {
    case 0:
      text = Text(
        dias[0], 
        style: style,
      );
      break;
    case 1:
      text = Text(
        dias[1], 
        style: style,
      );
      break;
    case 2:
      text = Text(
        dias[2], 
        style: style,
      );
      break;
    case 3:
      text = Text(
        dias[3], 
        style: style,
      );
      break;
    case 4:
      text = Text(
        dias[4], 
        style: style,
      );
      break;
    case 5:
      text = Text(
        dias[5], 
        style: style,
      );
      break;
    case 6:
      text = Text(
        dias[6], 
        style: style,
      );
      break;
    case 7:
      text = Text(
        dias[7], 
        style: style,
      );
      break;
    case 8:
      text = Text(
        dias[8], 
        style: style,
      );
      break;
    case 9:
      text = Text(
        dias[9], 
        style: style,
      );
      break;
    case 10:
      text = Text(
        dias[10], 
        style: style,
      );
      break;
    case 11:
      text = Text(
        dias[11], 
        style: style,
      );
      break;
    case 12:
      text = Text(
        dias[12], 
        style: style,
      );
      break;
    case 13:
      text = Text(
        dias[13], 
        style: style,
      );
      break;
    case 14:
      text = Text(
        dias[14], 
        style: style,
      );
      break;
    default:
      text = const Text(
        '', 
        style: style,
      );
      break;
  }
  return SideTitleWidget(
    child: text, 
    axisSide: meta.axisSide,
    space: 10,
    angle: pi/5,
  );
}

String formatDate(String date) {
  if(date.contains('-')) {
    List<String> partes = date.split('-');
    return '${partes[2]}-${partes[1]}';
  } else {
    return date;
  }
}

String formatDateStr(String date) {
  if(date.contains('-')) {
    List<String> partes = date.split('-');
    if(partes[1] == '01') {
      partes[1] = 'En';
    } else if(partes[1] == '02') {
      partes[1] = 'Fe';
    } else if(partes[1] == '03') {
      partes[1] = 'Mz';
    } else if(partes[1] == '04') {
      partes[1] = 'Ab';
    } else if(partes[1] == '05') {
      partes[1] = 'My';
    } else if(partes[1] == '06') {
      partes[1] = 'Jn';
    } else if(partes[1] == '07') {
      partes[1] = 'Jl';
    } else if(partes[1] == '08') {
      partes[1] = 'Ag';
    } else if(partes[1] == '09') {
      partes[1] = 'Se';
    } else if(partes[1] == '10') {
      partes[1] = 'Oc';
    } else if(partes[1] == '11') {
      partes[1] = 'No';
    } else if(partes[1] == '12') {
      partes[1] = 'Di';
    }
    return '${partes[0]} ${partes[1]}';
  } else {
    return date;
  }
}