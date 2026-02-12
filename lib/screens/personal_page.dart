// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:productivity_app/widgets/bottom_navigator_bar.dart';

// class PersonalPage extends StatelessWidget {
//   const PersonalPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: CustomBottomNavigatorBar(),
//       appBar: AppBar(
//         title: const Center(child: Text('Your Progress', style: TextStyle(fontWeight: FontWeight.bold))),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             // يجب وضع البيانات داخل ويدجت BarChart وتحديد ارتفاع لها
//             SizedBox(
//               height: 250, // تحديد ارتفاع للرسم البياني ضروري جداً
//               child: BarChart(
//                 BarChartData(
//                   alignment: BarChartAlignment.spaceAround,
//                   maxY: 20, // أقصى قيمة للعمود
//                   barTouchData: BarTouchData(enabled: true),
//                   titlesData: FlTitlesData(
//                     show: true,
//                     // إعدادات العناوين السفلية (التواريخ)
//                     bottomTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         getTitlesWidget: (value, meta) {
//                           const days = ['Feb 28', 'Feb 29', 'Feb 30', 'Feb 31'];
//                           return Text(days[value.toInt() % days.length], 
//                                       style: const TextStyle(fontSize: 12));
//                         },
//                       ),
//                     ),
//                     leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                     topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                     rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                   ),
//                   gridData: const FlGridData(show: false), // إخفاء خطوط الشبكة
//                   borderData: FlBorderData(show: false),   // إخفاء الإطار
//                   barGroups: [
//                     // هنا نضع الـ BarChartGroupData التي كتبتها
//                     _makeGroupData(0, 12, Colors.orangeAccent),
//                     _makeGroupData(1, 18, Colors.greenAccent),
//                     _makeGroupData(2, 15, Colors.yellowAccent),
//                     _makeGroupData(3, 10, Colors.orange), // Today
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text("Today", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.black,
//                 minimumSize: const Size(double.infinity, 50),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
//               ),
//               child: const Text("View History", style: TextStyle(color: Colors.white)),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   // دالة مساعدة لإنشاء المجموعات بسهولة
//   BarChartGroupData _makeGroupData(int x, double y, Color color) {
//     return BarChartGroupData(
//       x: x,
//       barRods: [
//         BarChartRodData(
//           toY: y,
//           color: color,
//           width: 22,
//           borderRadius: BorderRadius.circular(10), // لجعل الحواف مستديرة كالصورة
//           backDrawRodData: BackgroundBarChartRodData(
//             show: true,
//             toY: 20,
//             color: Colors.grey.shade100, // خلفية العمود الباهتة
//           ),
//         ),
//       ],
//     );
//   }
// }