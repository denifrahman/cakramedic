import 'dart:convert';

import 'package:cakramedic/models/dashboard.dart';
import 'package:cakramedic/providers/booking.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'indicator.dart';

class PieChartSample2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex;

  var dataInstalasi = List<Dashboard>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  _getData() {
    Api.getAllPasienPerInstalasi().then((value) {
      var result = json.decode(value.body);
      setState(() {
        Iterable list = result['data'];
        dataInstalasi = list.map((model) => Dashboard.fromMap(model)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2 + 50,
        child: Card(
            elevation: 5,
//        color: Colors.white,
            child: Column(children: <Widget>[
              const SizedBox(
                height: 18,
              ),
              Text(
                'Total Kunjungan per Instalasi',
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(),
              const SizedBox(
                height: 18,
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 3,
                  child: dataInstalasi.isEmpty
                      ? Container()
                      : PieChart(
                          PieChartData(
                              pieTouchData: PieTouchData(
                                  touchCallback: (pieTouchResponse) {
                                setState(() {
                                  if (pieTouchResponse.touchInput
                                          is FlLongPressEnd ||
                                      pieTouchResponse.touchInput is FlPanEnd) {
                                    touchedIndex = -1;
                                  } else {
                                    touchedIndex =
                                        pieTouchResponse.touchedSectionIndex;
                                  }
                                });
                              }),
                              borderData: FlBorderData(
                                show: false,
                              ),
                              sectionsSpace: 0,
                              centerSpaceRadius: 40,
                              sections: dataInstalasi == null
                                  ? showingSectionsOnNull()
                                  : showingSections()),
                        ),
                ),
              ),
              Container(
                height: 120,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 10),
                child: ListView.builder(
                    itemCount: dataInstalasi.length,
                    itemBuilder: (context, index) {
                      var label = dataInstalasi[index].label;
                      var jumlah = dataInstalasi[index].count;
                      var color = convertToColor(dataInstalasi[index].color);
                      return Column(
                        children: <Widget>[
                          Indicator(
                            size: 12,
                            color: color,
                            text: '$label ($jumlah)',
                            isSquare: true,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                        ],
                      );
                    }),
              )
            ])));
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(dataInstalasi.length, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      var label = (double.parse(dataInstalasi[i].count) /
              double.parse(dataInstalasi[i].total) *
              100)
          .round()
          .toString();
      var color = convertToColor(dataInstalasi[i].color);
      return PieChartSectionData(
        color: color,
        value: double.parse(dataInstalasi[i].count) /
            double.parse(dataInstalasi[i].total) *
            100,
        title: '$label%',
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff)),
      );
    });
  }

  Color convertToColor(String color, {String opacity = 'ff'}) {
    return Color(int.parse('$opacity$color', radix: 16));
  }

  List<PieChartSectionData> showingSectionsOnNull() {
    return List.generate(1, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.white,
            value: 1,
            title: '1',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}
