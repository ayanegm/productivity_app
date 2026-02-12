import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/helper/bar_chart_data.dart';
import 'package:productivity_app/screens/add_new_task_page.dart';
import 'package:productivity_app/screens/calender_screen.dart';
import 'package:productivity_app/screens/fake_page.dart';
import 'package:productivity_app/screens/home_page.dart';
import 'package:productivity_app/screens/personal_page.dart';
import 'package:productivity_app/screens/tasks_for_today.dart';

class CustomBottomNavigatorBar extends StatelessWidget {
   CustomBottomNavigatorBar({super.key, required this.selectedIndex});
  final int selectedIndex;
  @override
  Widget build(BuildContext context) {
    Color getIconColor(int index){
      return selectedIndex ==index?Color(0xFF53ceaf):Colors.black;
    }
    return  Container(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
      children: [
        IconButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return HomePage();
          },));
        }, icon: const Icon(Icons.home_filled, size: 30),color: getIconColor(0)),
        IconButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return TasksForToday();
          },));
        }, icon: const Icon(Icons.grid_view, size: 30),color: getIconColor(1)),
        IconButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return AddNewTaskScreen();
          },));
        }, icon: const Icon(Icons.add_circle_sharp, size: 30),color: getIconColor(2)),

        IconButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return CalenderScreen();
          },));
        }, icon: const Icon(Icons.calendar_today_outlined, size: 30),color: getIconColor(3)),
        
]
      ),
       );
  }

  }