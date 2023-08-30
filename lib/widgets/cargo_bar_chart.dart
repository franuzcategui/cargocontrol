import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cargocontrol/constants.dart' as constants;

class CargoBarChart extends StatelessWidget {
  const CargoBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.07 * MediaQuery.of(context).size.height,
      width: 0.8 * MediaQuery.of(context).size.width,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.start,
          titlesData: const FlTitlesData(
            show: false,
          ),
          borderData: FlBorderData(
            show: false,
          ),

          groupsSpace: 2,

          // add bars
          barGroups: [
            BarChartGroupData(x: 1, barRods: [
              BarChartRodData(
                toY: 5,
                width: 0.14 * MediaQuery.of(context).size.width,
                color: constants.kMainColor,
                borderRadius: BorderRadius.zero,
                backDrawRodData: BackgroundBarChartRodData(
                  fromY: 0,
                  toY: 10,
                  color: constants.kOutlineTextFieldColor,
                  show: true,
                ),
              ),
            ]),
            BarChartGroupData(x: 2, barRods: [
              BarChartRodData(
                toY: 5,
                width: 0.14 * MediaQuery.of(context).size.width,
                color: constants.kMainColor,
                borderRadius: BorderRadius.zero,
                backDrawRodData: BackgroundBarChartRodData(
                  fromY: 0,
                  toY: 10,
                  color: constants.kOutlineTextFieldColor,
                  show: true,
                ),
              ),
            ]),
            BarChartGroupData(x: 3, barRods: [
              BarChartRodData(
                toY: 4,
                width: 0.14 * MediaQuery.of(context).size.width,
                color: constants.kBrandColor,
                borderRadius: BorderRadius.zero,
                backDrawRodData: BackgroundBarChartRodData(
                  fromY: 0,
                  toY: 10,
                  color: constants.kOutlineTextFieldColor,
                  show: true,
                ),
              ),
            ]),
            BarChartGroupData(x: 4, barRods: [
              BarChartRodData(
                toY: 2,
                width: 0.14 * MediaQuery.of(context).size.width,
                color: constants.kMainColor,
                borderRadius: BorderRadius.zero,
                backDrawRodData: BackgroundBarChartRodData(
                  fromY: 0,
                  toY: 10,
                  color: constants.kOutlineTextFieldColor,
                  show: true,
                ),
              ),
            ]),
            BarChartGroupData(x: 5, barRods: [
              BarChartRodData(
                toY: 7,
                width: 0.14 * MediaQuery.of(context).size.width,
                color: constants.kMainColor,
                borderRadius: BorderRadius.zero,
                backDrawRodData: BackgroundBarChartRodData(
                  fromY: 0,
                  toY: 10,
                  color: constants.kOutlineTextFieldColor,
                  show: true,
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
