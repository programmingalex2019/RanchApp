import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:the_ranch_app/models/ranch_user.dart';
import 'package:the_ranch_app/services/database.dart';

class HeartPieChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Grades Pie-Chart'),
      ),
      body: FutureBuilder<List<RanchUser>>(
        future: database.getRanchMembers(),
        builder: (context, snapshot) {
          if (snapshot == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            List<RanchUser> ranchMembers = snapshot.data;

            Map<String, double> dataMap = Map();

            List<Color> colorList = [
              Color(0xffd50000),
              Color(0xffC6FF00),
              Color(0xff00BCD4),
              Color(0xffC2185B),
              Color(0xff388E3C),
              Color(0xff6200EA),
              Color(0xffFFC107),
              Color(0xff03A9F4),
            ];

            if (ranchMembers != null) {
              for (RanchUser user in ranchMembers) {
                dataMap.putIfAbsent('${user.name} - ${user.grade}',
                    () => int.parse(user.grade).toDouble());
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }

            return PieChart(
              dataMap: dataMap,
              animationDuration: Duration(milliseconds: 800),
              chartLegendSpacing: 70.0,
              chartRadius: MediaQuery.of(context).size.width / 1.2,
              showChartValuesInPercentage: true,
              showChartValues: true,
              showChartValuesOutside: false,
              chartValueBackgroundColor: Colors.grey[200],
              colorList: colorList,
              showLegends: true,
              legendStyle:
                  TextStyle(color: Theme.of(context).textSelectionColor),
              legendPosition: LegendPosition.bottom,
              decimalPlaces: 1,
              showChartValueLabel: true,
              initialAngle: 0,
              chartValueStyle: defaultChartValueStyle.copyWith(
                color: Colors.blueGrey[900].withOpacity(0.9),
              ),
              chartType: ChartType.disc,
            );
          }
        },
      ),
    );
  }
}
