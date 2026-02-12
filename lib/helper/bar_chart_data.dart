import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:productivity_app/providers/task_provider.dart';
import 'package:productivity_app/widgets/bottom_navigator_bar.dart';
import 'package:provider/provider.dart';

class DailyChartDemo extends StatelessWidget {
  const DailyChartDemo({super.key, required this.total, required this.achieved});
final int total;
  final int achieved;
  

// void initState() {
//   super.initState();
//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     context.read<TaskProvider>().fetchLast7Days();
//   });
// }

  @override
  Widget build(BuildContext context) {
// final taskProvider=context.watch<TaskProvider>();
  
double achievedDouble = achieved.toDouble();
double totalDouble = total.toDouble();
    return Container(
            height: 180,
            padding: const EdgeInsets.all(10),
            child: BarChart(
              BarChartData(
                maxY: 10,
                
                barGroups: [
                  BarChartGroupData(x: 0,
                  barRods: [
                    BarChartRodData(
                      toY: totalDouble,
                      width: 20,
                      borderRadius: BorderRadius.circular(4),
                      rodStackItems: [
                    BarChartRodStackItem(0, achievedDouble, const Color(0xFF53ceaf)), // لون المكتمل
                    BarChartRodStackItem(achievedDouble, totalDouble, Colors.grey.withOpacity(0.2)), // المتبقي
                  ],
                  
                    )
                  ])
                ],
                titlesData: const FlTitlesData(show: false),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
                
              ),
            ),
          
        
    );
  }
}
