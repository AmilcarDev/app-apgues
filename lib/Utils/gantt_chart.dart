import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pgues_app/models/period_model.dart';
import 'package:pgues_app/models/stage_model.dart';
import 'package:date_utils/date_utils.dart';

class GanttChart extends StatelessWidget {
  final AnimationController animationController;
  final DateTime fromDate;
  final DateTime toDate;
  final List<Stage> data;
  final Period period;
  int viewRange;
  int viewRangeToFitScreen = 10;
  Animation<double> width;

  GanttChart(
      {this.animationController,
      this.fromDate,
      this.toDate,
      this.data,
      this.period}) {
    viewRange = calculateNumberOfMonthsBetween(fromDate, toDate) + 10;
    print(viewRange);
  }

  Color randomColorGenerator() {
    var r = new Random();
    return Color.fromRGBO(r.nextInt(256), r.nextInt(256), r.nextInt(256), 0.75);
  }

  int calculateNumberOfMonthsBetween(DateTime from, DateTime to) {
    return to.month - from.month + 12 * (to.year - from.year) + 1;
  }

  int calculateDistanceToLeftBorder(DateTime projectStartedAt) {
    if (projectStartedAt.compareTo(fromDate) <= 0) {
      return 0;
    } else
      return calculateNumberOfMonthsBetween(fromDate, projectStartedAt) - 1;
  }

  int calculateRemainingWidth(
      DateTime projectStartedAt, DateTime projectEndedAt) {
    int projectLength =
        calculateNumberOfMonthsBetween(projectStartedAt, projectEndedAt);
    if (projectStartedAt.compareTo(fromDate) >= 0 &&
        projectStartedAt.compareTo(toDate) <= 0) {
      if (projectLength <= viewRange)
        return projectLength;
      else
        return viewRange -
            calculateNumberOfMonthsBetween(fromDate, projectStartedAt);
    } else if (projectStartedAt.isBefore(fromDate) &&
        projectEndedAt.isBefore(fromDate)) {
      return 0;
    } else if (projectStartedAt.isBefore(fromDate) &&
        projectEndedAt.isBefore(toDate)) {
      return projectLength -
          calculateNumberOfMonthsBetween(projectStartedAt, fromDate);
    } else if (projectStartedAt.isBefore(fromDate) &&
        projectEndedAt.isAfter(toDate)) {
      return viewRange;
    }
    return 0;
  }

  Widget buildHeader(double chartViewWidth, Color color) {
    List<Widget> headerItems = new List();

    DateTime tempDate = fromDate;

    headerItems.add(Container(
      width: (chartViewWidth * 10) / viewRangeToFitScreen,
      child: new Text(
        'ACTIVIDADES',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 10.0,
        ),
      ),
    ));

    for (int i = 0; i < viewRange; i++) {
      headerItems.add(Container(
        width: (chartViewWidth * 4) / viewRangeToFitScreen,
        child: new Text(
          tempDate.month.toString() + '/' + tempDate.year.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10.0,
          ),
        ),
      ));
      tempDate = Utils.nextMonth(tempDate);
    }

    return Container(
      height: 25.0,
      color: randomColorGenerator().withAlpha(100),
      child: Row(
        children: headerItems,
      ),
    );
  }

  Widget buildGrid(double chartViewWidth) {
    List<Widget> gridColumns = new List();

    for (int i = 0; i <= viewRange; i++) {
      gridColumns.add(Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              color: Colors.grey.withAlpha(100),
              width: 1.0,
            ),
          ),
        ),
        width: (chartViewWidth) * 4.10 / viewRangeToFitScreen,
        height: 300.0,
      ));
    }

    return Row(
      children: gridColumns,
    );
  }

  List<Widget> buildChartBars(
      List<Stage> data, double chartViewWidth, Color color) {
    List<Widget> chartBars = new List();

    for (int i = 0; i < data.length; i++) {
      var remainingWidth =
          calculateRemainingWidth(data[i].startTime, data[i].endTime);
      if (remainingWidth > 0) {
        chartBars.add(Container(
          decoration: BoxDecoration(
              color: randomColorGenerator().withAlpha(100),
              borderRadius: BorderRadius.circular(10.0)),
          height: 55.0,
          width: remainingWidth * chartViewWidth / viewRangeToFitScreen,
          margin: EdgeInsets.only(
              left: calculateDistanceToLeftBorder(data[i].startTime) *
                  chartViewWidth /
                  viewRangeToFitScreen,
              top: 4.0,
              bottom: 4.0),
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              data[i].name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 10.0),
            ),
          ),
        ));
      }
    }

    return chartBars;
  }

  Widget buildChart(List<Stage> userData, double chartViewWidth, Period user) {
    Color color = randomColorGenerator();
    var chartBars = buildChartBars(userData, chartViewWidth, color);
    return Container(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: ListView(
        physics: new ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Stack(fit: StackFit.loose, children: <Widget>[
            buildGrid(chartViewWidth),
            buildHeader(chartViewWidth, color),
            Container(
                margin: EdgeInsets.only(top: 25.0),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                                width: (chartViewWidth * 10) /
                                    viewRangeToFitScreen,
                                height: chartBars.length * 65.0,
                                color: color.withAlpha(100),
                                child: Center(
                                  child: new RotatedBox(
                                    quarterTurns:
                                        chartBars.length * 29.0 + 4.0 > 50
                                            ? 0
                                            : 0,
                                    child: new Text(
                                      user.name,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: chartBars,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ]),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final safe = Scaffold(
        body: SafeArea(
      child: buildChart(this.data, 300.0, this.period),
    ));
    return safe;
  }
}
