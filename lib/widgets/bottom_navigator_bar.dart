import 'package:flutter/material.dart';
import 'package:productivity_app/screens/add_new_task_page.dart';
import 'package:productivity_app/screens/calender_screen.dart';
import 'package:productivity_app/screens/home_page.dart';
import 'package:productivity_app/screens/personal_page.dart';
import 'package:productivity_app/screens/tasks_for_today.dart';

class CustomBottomNavigatorBar extends StatelessWidget {
   CustomBottomNavigatorBar({super.key});
  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
      children: [
        IconButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return HomePage();
          },));
        }, icon: const Icon(Icons.home_outlined, size: 30),color: Colors.black,),
        IconButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return TasksForToday();
          },));
        }, icon: const Icon(Icons.grid_view_outlined, size: 30),color: Colors.black,),
        IconButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return AddNewTaskScreen();
          },));
        }, icon: const Icon(Icons.add_circle_sharp, size: 30),color: Colors.black),

        IconButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return CalenderScreen();
          },));
        }, icon: const Icon(Icons.calendar_today_outlined, size: 30),color: Colors.black),
]
      ),
       );
  }
}