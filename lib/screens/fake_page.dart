import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FakePage extends StatelessWidget {
  const FakePage({super.key});

  @override
  Widget build(BuildContext context) {
    final fakeData = [3.0, 6.0, 4.0, 2.0];
final labels = ["Feb 28", "Feb 29", "Feb 30", "Today"];
    return Scaffold(
      appBar: AppBar(
        title: Text('analytics demo'),

      ),
      body: Center(
        child: SizedBox(
          height: 220,
          child: BarChart(
            BarChartData(
              maxY: 10,
              barGroups: [
                BarChartGroupData(x: 0, barRods: [
                  BarChartRodData(toY: 3, width: 16, borderRadius: BorderRadius.circular(12)),
                ]),
                BarChartGroupData(x: 1, barRods: [
                  BarChartRodData(toY: 6, width: 16, borderRadius: BorderRadius.circular(12)),
                ]),
                BarChartGroupData(x: 2, barRods: [
                  BarChartRodData(toY: 4, width: 16, borderRadius: BorderRadius.circular(12)),
                ]),
                BarChartGroupData(x: 3, barRods: [
                  BarChartRodData(toY: 2, width: 16, borderRadius: BorderRadius.circular(12)),
                ]),
              ],
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      const labels = ["Feb 28", "Feb 29", "Feb 30", "Today"];
                      return Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(labels[value.toInt()]),
                      );
                    },
                  )
                ),
                ///////
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              )
            )
          ),
        ),
      ),
    );
  }
}