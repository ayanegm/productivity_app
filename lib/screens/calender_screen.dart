import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:productivity_app/models/task_model.dart';
import 'package:productivity_app/providers/task_provider.dart';
import 'package:productivity_app/widgets/bottom_navigator_bar.dart';
import 'package:productivity_app/widgets/task_container.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
//     final String uid=FirebaseAuth.instance.currentUser!.uid;
// List allTasks=[];
  DateTime today=DateTime.now();
  DateTime? selectedDay=DateTime.now();
  // bool isLoading=false;
  @override
  void initState() {
    super.initState();
WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchTasksForSelectedDay();
    });
      }
  // void _onDaySelected(DateTime day,DateTime focusedDay){
  //   setState(() {
  //     today=day;
  //     selectedDay=day;
  //     isLoading=true;
  //     getTasks();
  //   });
  // }
   
//   Future<void>getTasks()async{
// String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDay!);   
//      final String uid=FirebaseAuth.instance.currentUser!.uid;

//     if(uid !=null){
//       var snapshot=await FirebaseFirestore.instance.collection('users').doc(uid).collection('tasks').where('date',isEqualTo:formattedDate ).get();
    
//     List<TaskModel>fetchedTasks=snapshot.docs.map((doc){
//       return TaskModel.fromMap(doc.data());
//     }).toList();
//     setState(() {
//       allTasks=fetchedTasks;
//       isLoading=false;
//     });
//   }
//   }
void _fetchTasksForSelectedDay(){
String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDay!);   
context.read<TaskProvider>().fetchTasks(formattedDate);

}
void _onDaySelected(DateTime day,DateTime focusedDay){
  setState(() {
    today=day;
    selectedDay=day;
  });
  _fetchTasksForSelectedDay();
}
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigatorBar(),
      appBar: AppBar(
        title: Center(child: Text('calendar')),
      ),
      
      body:  Column(
          children: [
            Container(child: TableCalendar(onDaySelected: _onDaySelected,selectedDayPredicate: (day)=>isSameDay(day,today),rowHeight: 43,headerStyle: HeaderStyle(formatButtonVisible: false,titleCentered: true),focusedDay: today, firstDay: DateTime(2025,6,20), lastDay: DateTime(2030,3,14),
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Color(0xFF53ceaf),
                shape:BoxShape.circle
              ),
              todayDecoration: BoxDecoration(
                color: Color.fromARGB(255, 185, 238, 224),
                shape: BoxShape.circle,
              ),
            ),),),
            Expanded(
            child:
            Consumer<TaskProvider>(builder: (context, taskProvider, child) {
                if(taskProvider.isLoading){
                  return  Center(child: CircularProgressIndicator(),);
                }
                if(taskProvider.allTasks.isEmpty){
                  return Center(child: Text("No tasks for this day"));
                }
                return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                        itemCount: taskProvider.allTasks.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TaskContainer(task: taskProvider.allTasks[index]),
                          );
                        },
                      );
            },)
             
            )
        ],),
        
      
    );
  }

}