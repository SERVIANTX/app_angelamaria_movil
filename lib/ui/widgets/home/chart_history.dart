// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/data/data_remote/data_consult/data_chart_order.dart';
import '../../../app/data/helpers/http.dart';
import '../../../app/data/helpers/http_method.dart';
import '../../../config/global_variables.dart';

class BarChartSample1 extends StatefulWidget {
  final List<Color> availableColors = const [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  const BarChartSample1({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {

  bool loading = true;
  var count = 0;
  var count1 = 0;
  var count2 = 0;
  var count3 = 0;
  var count4 = 0;
  var count5 = 0;
  var count6 = 0;
  var count7 = 0;

  //DIAS DE LA SEMANA
  List<String> dates = [];

  List<data_Chart_Orders> data_at_destination = <data_Chart_Orders>[];


  Future<List<data_Chart_Orders>?> cargar_datos_at_destination() async{

        SharedPreferences prefs = await SharedPreferences.getInstance();

        //PUGLIN

          //fecha actual
          final DateTime now = DateTime.now();
          //Fechas
          var fecha1 = now.toString().substring(0, 10);
          var fecha2 = now.subtract(const Duration(days: 1)).toString().substring(0, 10);
          var fecha3 = now.subtract(const Duration(days: 2)).toString().substring(0, 10);
          var fecha4 = now.subtract(const Duration(days: 3)).toString().substring(0, 10);
          var fecha5 = now.subtract(const Duration(days: 4)).toString().substring(0, 10);
          var fecha6 = now.subtract(const Duration(days: 5)).toString().substring(0, 10);
          var fecha7 = now.subtract(const Duration(days: 6)).toString().substring(0, 10);

          //Dias

          switch (DateFormat.EEEE().format(now).toString()) {
            case 'Monday':
              dates = ["Martes", "Miércoles", "Jueves", "Viernes","Sábado", "Domingo", "Lunes"];
              break;
            case 'Tuesday':
              dates = ["Miércoles", "Jueves", "Viernes","Sábado", "Domingo", "Lunes", "Martes"];
              break;
            case 'Wednesday':
              dates = ["Jueves", "Viernes","Sábado", "Domingo", "Lunes", "Martes", "Miércoles"];
              break;
            case 'Thursday':
              dates = ["Viernes","Sábado", "Domingo", "Lunes", "Martes", "Miércoles", "Jueves"];
              break;
            case 'Friday':
              dates = ["Sábado", "Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes"];
              break;
            case 'Saturday':
              dates = ["Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado"];
              break;
            case 'Sunday':
              dates = ["Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo"];
              break;
            default:
              return throw Error();
          }

        var id = prefs.getString('id');
        final http = Http(baseUrl: urlGlobal().url);
        final result = await http.request('/orders?select=id_order,date_updated_order,id_user_order&linkTo=date_updated_order&between1=$fecha7&between2=$fecha1&filterTo=status_order&inTo=3',
        method: HttpMethod.get,
        headers: {
          "Authorization": keyGlobal().key,
        },
        );
        if( result.statusCode == 200){
          count = result.data['total'];
          var datos = result.data['results'];
          var registros = <data_Chart_Orders>[];
          for(var i = 0; i < count; i++){
            if(datos[i]["id_user_order"] == id){
              if (datos[i]["date_updated_order"] == fecha1) {
                count1++;
            } else if (datos[i]["date_updated_order"] == fecha2) {
                count2++;
            } else if (datos[i]["date_updated_order"] == fecha3) {
                count3++;
            } else if (datos[i]["date_updated_order"] == fecha4) {
                count4++;
            } else if (datos[i]["date_updated_order"] == fecha5) {
                count5++;
            } else if (datos[i]["date_updated_order"] == fecha6) {
                count6++;
            } else if (datos[i]["date_updated_order"] == fecha7) {
                count7++;
            }
            }

            var datos2 = datos[i];
            registros.add(data_Chart_Orders.fromJson(datos2));
          }
          return registros;
        }
        return [];
  }

  @override
  void initState() {

    super.initState();
    cargar_datos_at_destination().then((value){
      setState(() {
        data_at_destination.addAll(value!);
        loading = false;
      });
    });

  }

  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: loading == false ?
        Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: Theme.of(context).cardColor,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    ' Historial de',
                    style: TextStyle(
                        color: Theme.of(context).canvasColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    '  Pedidos completados',
                    style: TextStyle(
                        color: Theme.of(context).canvasColor.withOpacity(0.8),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: BarChart(
                        mainBarData(),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      )
        :Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: Theme.of(context).cardColor,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    ' Historial de',
                    style: TextStyle(
                        color: Theme.of(context).canvasColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    '  Pedidos completados',
                    style: TextStyle(
                        color: Theme.of(context).canvasColor.withOpacity(0.8),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: BarChart(
                        mainBarData(),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.deepPurple,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? Colors.deepPurple : barColor,
          width: width,
          borderSide: isTouched
              ? const BorderSide(color: Colors.deepPurple, width: 1)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: Theme.of(context).canvasColor.withOpacity(0.3),
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, count7.toDouble(), isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, count6.toDouble(), isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, count5.toDouble(), isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, count4.toDouble(), isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, count3.toDouble(), isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, count2.toDouble(), isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, count1.toDouble(), isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = dates[0];
                  break;
                case 1:
                  weekDay = dates[1];
                  break;
                case 2:
                  weekDay = dates[2];
                  break;
                case 3:
                  weekDay = dates[3];
                  break;
                case 4:
                  weekDay = dates[4];
                  break;
                case 5:
                  weekDay = dates[5];
                  break;
                case 6:
                  weekDay = dates[6];
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                '$weekDay\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.toY - 1).toString(),
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    Widget text;
    final DateTime now = DateTime.now();
    List<String> dateIni = [];
    switch (DateFormat.EEEE().format(now).toString()) {
        case 'Monday':
          dateIni = ["Martes", "Miércoles", "Jueves", "Viernes","Sábado", "Domingo", "Lunes"];
          break;
        case 'Tuesday':
          dateIni = ["Miércoles", "Jueves", "Viernes","Sábado", "Domingo", "Lunes", "Martes"];
          break;
        case 'Wednesday':
          dateIni = ["Jueves", "Viernes","Sábado", "Domingo", "Lunes", "Martes", "Miércoles"];
          break;
        case 'Thursday':
          dateIni = ["Viernes","Sábado", "Domingo", "Lunes", "Martes", "Miércoles", "Jueves"];
          break;
        case 'Friday':
          dateIni = ["Sábado", "Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes"];
          break;
        case 'Saturday':
          dateIni = ["Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado"];
          break;
        case 'Sunday':
          dateIni = ["Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo"];
          break;
        default:
          return throw Error();
      }

    switch (value.toInt()) {
      case 0:
          text = Text(dateIni[0].substring(0,1), style: TextStyle(
      color: Theme.of(context).canvasColor,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ));
        break;
      case 1:
          text = Text(dateIni[1].substring(0,1), style: TextStyle(
      color: Theme.of(context).canvasColor,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ));
        break;
      case 2:
          text = Text(dateIni[2].substring(0,1), style: TextStyle(
      color: Theme.of(context).canvasColor,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ));
        break;
      case 3:
          text = Text(dateIni[3].substring(0,1), style: TextStyle(
      color: Theme.of(context).canvasColor,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ));
        break;
      case 4:
          text = Text(dateIni[4].substring(0,1), style: TextStyle(
      color: Theme.of(context).canvasColor,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ));
        break;
      case 5:
          text = Text(dateIni[5].substring(0,1), style: TextStyle(
      color: Theme.of(context).canvasColor,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ));
        break;
      case 6:
          text = Text(dateIni[6].substring(0,1), style: TextStyle(
      color: Theme.of(context).canvasColor,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ));
        break;
      default:
          text = Text('', style: TextStyle(
      color: Theme.of(context).canvasColor,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ));
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
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
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 1:
            return makeGroupData(1, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 2:
            return makeGroupData(2, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 3:
            return makeGroupData(3, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 4:
            return makeGroupData(4, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 5:
            return makeGroupData(5, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 6:
            return makeGroupData(6, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          default:
            return throw Error();
        }
      }),
      gridData: FlGridData(show: false),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
        animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      await refreshState();
    }
  }
}


// // ignore_for_file: no_leading_underscores_for_local_identifiers

// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// class BarChartSample2 extends StatefulWidget {
//   const BarChartSample2({Key? key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => BarChartSample2State();
// }

// class BarChartSample2State extends State<BarChartSample2> {
//   final Color leftBarColor = const Color(0xff53fdd7);
//   final Color rightBarColor = const Color(0xffff5182);
//   final double width = 7;

//   late List<BarChartGroupData> rawBarGroups;
//   late List<BarChartGroupData> showingBarGroups;

//   int touchedGroupIndex = -1;

//   @override
//   void initState() {
//     super.initState();
//     final barGroup1 = makeGroupData(0, 5, 12);
//     final barGroup2 = makeGroupData(1, 16, 12);
//     final barGroup3 = makeGroupData(2, 18, 5);
//     final barGroup4 = makeGroupData(3, 20, 16);
//     final barGroup5 = makeGroupData(4, 17, 6);
//     final barGroup6 = makeGroupData(5, 19, 1.5);
//     final barGroup7 = makeGroupData(6, 10, 1.5);

//     final items = [
//       barGroup1,
//       barGroup2,
//       barGroup3,
//       barGroup4,
//       barGroup5,
//       barGroup6,
//       barGroup7,
//     ];

//     rawBarGroups = items;

//     showingBarGroups = rawBarGroups;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1,
//       child: Card(
//         elevation: 3,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
//         color: Theme.of(context).cardColor,
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             mainAxisAlignment: MainAxisAlignment.start,
//             mainAxisSize: MainAxisSize.max,
//             children: <Widget>[
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   makeTransactionsIcon(),
//                   const SizedBox(
//                     width: 38,
//                   ),
//                   Text(
//                     'Historial',
//                     style: TextStyle(color: Theme.of(context).canvasColor, fontSize: 22),
//                   ),
//                   const SizedBox(
//                     width: 4,
//                   ),
//                   Text(
//                     'de pedidos',
//                     style: TextStyle(color: Theme.of(context).canvasColor, fontSize: 16),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 38,
//               ),
//               Expanded(
//                 child: BarChart(
//                   BarChartData(
//                     maxY: 20,
//                     barTouchData: BarTouchData(
//                         touchTooltipData: BarTouchTooltipData(
//                           tooltipBgColor: Colors.grey,
//                           getTooltipItem: (_a, _b, _c, _d) => null,
//                         ),
//                         touchCallback: (FlTouchEvent event, response) {
//                           if (response == null || response.spot == null) {
//                             setState(() {
//                               touchedGroupIndex = -1;
//                               showingBarGroups = List.of(rawBarGroups);
//                             });
//                             return;
//                           }

//                           touchedGroupIndex =
//                               response.spot!.touchedBarGroupIndex;

//                           setState(() {
//                             if (!event.isInterestedForInteractions) {
//                               touchedGroupIndex = -1;
//                               showingBarGroups = List.of(rawBarGroups);
//                               return;
//                             }
//                             showingBarGroups = List.of(rawBarGroups);
//                             if (touchedGroupIndex != -1) {
//                               var sum = 0.0;
//                               for (var rod
//                                   in showingBarGroups[touchedGroupIndex]
//                                       .barRods) {
//                                 sum += rod.toY;
//                               }
//                               final avg = sum /
//                                   showingBarGroups[touchedGroupIndex]
//                                       .barRods
//                                       .length;

//                               showingBarGroups[touchedGroupIndex] =
//                                   showingBarGroups[touchedGroupIndex].copyWith(
//                                 barRods: showingBarGroups[touchedGroupIndex]
//                                     .barRods
//                                     .map((rod) {
//                                   return rod.copyWith(toY: avg);
//                                 }).toList(),
//                               );
//                             }
//                           });
//                         }),
//                     titlesData: FlTitlesData(
//                       show: true,
//                       rightTitles: AxisTitles(
//                         sideTitles: SideTitles(showTitles: false),
//                       ),
//                       topTitles: AxisTitles(
//                         sideTitles: SideTitles(showTitles: false),
//                       ),
//                       bottomTitles: AxisTitles(
//                         sideTitles: SideTitles(
//                           showTitles: true,
//                           getTitlesWidget: bottomTitles,
//                           reservedSize: 42,
//                         ),
//                       ),
//                       leftTitles: AxisTitles(
//                         sideTitles: SideTitles(
//                           showTitles: true,
//                           reservedSize: 28,
//                           interval: 1,
//                           getTitlesWidget: leftTitles,
//                         ),
//                       ),
//                     ),
//                     borderData: FlBorderData(
//                       show: false,
//                     ),
//                     barGroups: showingBarGroups,
//                     gridData: FlGridData(show: false),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget leftTitles(double value, TitleMeta meta) {
//     var style = TextStyle(
//       color: Theme.of(context).canvasColor,
//       fontWeight: FontWeight.bold,
//       fontSize: 14,
//     );
//     String text;
//     if (value == 0) {
//       text = '1';
//     } else if (value == 10) {
//       text = '5';
//     } else if (value == 19) {
//       text = '10';
//     } else {
//       return Container();
//     }
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       space: 0,
//       child: Text(text, style: style),
//     );
//   }

//   Widget bottomTitles(double value, TitleMeta meta) {
//     List<String> titles = ["LU", "MA", "MI", "JU", "VI", "SA", "DO"];

//     Widget text = Text(
//       titles[value.toInt()],
//       style: TextStyle(
//         color: Theme.of(context).canvasColor,
//         fontWeight: FontWeight.bold,
//         fontSize: 14,
//       ),
//     );

//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       space: 16, //margin top
//       child: text,
//     );
//   }

//   BarChartGroupData makeGroupData(int x, double y1, double y2) {
//     return BarChartGroupData(barsSpace: 4, x: x, barRods: [
//       BarChartRodData(
//         toY: y1,
//         color: leftBarColor,
//         width: width,
//       ),
//       BarChartRodData(
//         toY: y2,
//         color: rightBarColor,
//         width: width,
//       ),
//     ]);
//   }

//   Widget makeTransactionsIcon() {
//     const width = 4.5;
//     const space = 3.5;
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         Container(
//           width: width,
//           height: 10,
//           color: Theme.of(context).canvasColor.withOpacity(0.4),
//         ),
//         const SizedBox(
//           width: space,
//         ),
//         Container(
//           width: width,
//           height: 28,
//           color: Theme.of(context).canvasColor.withOpacity(0.8),
//         ),
//         const SizedBox(
//           width: space,
//         ),
//         Container(
//           width: width,
//           height: 42,
//           color: Theme.of(context).canvasColor.withOpacity(1),
//         ),
//         const SizedBox(
//           width: space,
//         ),
//         Container(
//           width: width,
//           height: 28,
//           color: Theme.of(context).canvasColor.withOpacity(0.8),
//         ),
//         const SizedBox(
//           width: space,
//         ),
//         Container(
//           width: width,
//           height: 10,
//           color: Theme.of(context).canvasColor.withOpacity(0.4),
//         ),
//       ],
//     );
//   }
// }