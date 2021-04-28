import 'package:app/config/themes/light_theme.dart';
import 'package:app/modules/dashboard/screens/stats_screen.dart';
import 'package:app/utils/models/user_model.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class DashboardScreen extends StatefulWidget {
  final UserModel user; // receives the value

  DashboardScreen({Key key, this.user}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color color;
}

class _DashboardScreenState extends State<DashboardScreen> {
  SelectionBehavior _selectionBehavior;

  @override
  void initState() {
    _selectionBehavior = SelectionBehavior(
        enable: true,
        unselectedOpacity: 1,
        selectedColor: LightThemeColors.orange,
        unselectedColor: Color(0xffc5dfec));
    super.initState();
  }

  final List<ChartData> studentsData = [
    ChartData('Unk', 17),
    ChartData('Upf', 83),
  ];
  final List<ChartData> weekData = [
    ChartData('Mo', 6, Color(0xffc5dfec)),
    ChartData('Tu', 8, LightThemeColors.orange),
    ChartData('We', 4, Color(0xffc5dfec)),
    ChartData('Th', 2, Color(0xffc5dfec)),
    ChartData('Fr', 4, Color(0xffc5dfec)),
    ChartData('Sa', 0, Color(0xffc5dfec)),
    ChartData('Su', 0, Color(0xffc5dfec)),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: false,
        backgroundColor: LightThemeColors.mainColor,
        title: Text(
          '  Dashboard',
          style: TextStyle(
            fontStyle: FontStyle.normal,
            color: Colors.black,
            fontSize: 35,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              EvaIcons.bell,
              color: LightThemeColors.secondBlack,
            ),
            onPressed: () {},
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Container(
        color: Color(0xfff1f4f9),
        alignment: Alignment.center,
        child: ListView(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20),
          children: [
            Container(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                  color: Color(0xffdfe9fb),
                  borderRadius: BorderRadius.circular(20),
                  border: Border(left: BorderSide.none)),
              child: Column(
                children: [
                  Card(
                    margin: EdgeInsets.only(bottom: 1),
                    color: Colors.white,
                    elevation: 0.1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      height: 200,
                      child: SfCircularChart(
                        title: ChartTitle(
                            text: "  University Students",
                            alignment: ChartAlignment.near),
                        legend: Legend(
                          isVisible: true,
                          // Templating the legend item
                          legendItemBuilder: (String name, dynamic series,
                              dynamic point, int index) {
                            return Container(
                                child: Container(
                                    child: Text(
                              point.y.toString() + '%',
                              style: TextStyle(
                                  fontSize: point.y < 50 ? 20 : 35,
                                  color: point.color ?? Colors.black),
                            )));
                          },
                        ),
                        series: <CircularSeries>[
                          DoughnutSeries<ChartData, String>(
                            dataSource: studentsData,
                            // enableSmartLabels: true,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            dataLabelMapper: (ChartData data, _) => data.x,
                            dataLabelSettings: DataLabelSettings(
                                isVisible: true,
                                labelPosition: ChartDataLabelPosition.outside,
                                useSeriesColor: true),
                            innerRadius: '85%',
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 45,
                    width: double.maxFinite,
                    child: TextButton(
                      onPressed: () {},
                      child: Text('see more stats'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Activity',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 220,
              child: SfCartesianChart(
                backgroundColor: Color(0xfff1f4f9),
                plotAreaBorderColor: Colors.transparent,
                primaryXAxis: CategoryAxis(
                  majorGridLines: MajorGridLines(width: 0),
                  majorTickLines: MajorTickLines(width: 0),
                  axisLine: AxisLine(width: 0),
                ),
                primaryYAxis: NumericAxis(
                  majorTickLines: MajorTickLines(width: 0),
                  axisLine: AxisLine(width: 0),
                  interval: 2,
                  maximum: 11,
                  maximumLabelWidth: 15,
                ),
                series: <CartesianSeries>[
                  ColumnSeries<ChartData, String>(
                    pointColorMapper: (ChartData data, _) => data.color,
                    selectionBehavior: _selectionBehavior,
                    borderRadius: BorderRadius.circular(10),
                    dataSource: weekData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    dataLabelMapper: (ChartData data, _) => data.x,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'This week',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 15),
                    ),
                    Text(
                      '10 classes',
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Time',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 15),
                    ),
                    Text(
                      '17 hours',
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}

// appBar: AppBar(
//   toolbarHeight: 66,
//   backgroundColor: LightThemeColors.mainColor,
//   title: Text(
//     'DASHBOARD',
//     style: TextStyle(
//         color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
//   ),
//   leading: IconButton(
//       iconSize: 20,
//       icon: Icon(EvaIcons.search),
//       onPressed: () {},
//       color: LightThemeColors.secondBlack),
//   actions: [
//     Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: IconButton(
//         icon: Icon(EvaIcons.logOutOutline),
//         onPressed: () {
//           BlocProvider.of<AuthenticationBloc>(context).add(
//             LoggedOut(),
//           );
//         },
//         color: LightThemeColors.secondBlack,
//       ),
//     )
//   ],
// ),

//CODIGO UTIL
//      body: Container(
//   color: Colors.white,
//   child: ListView.builder(
//     itemCount: 20,
//     itemBuilder: (context, i) {
//       return ListTile(
//         title: Text("$i"),
//         onTap: () {
//           Navigator.of(context).pushNamed(Routes.statsScreen);
//         },
//       );
//     },
//   ),
// ),
