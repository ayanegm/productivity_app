import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:productivity_app/models/task_model.dart';
import 'package:productivity_app/providers/task_provider.dart';
import 'package:productivity_app/widgets/bottom_navigator_bar.dart';
import 'package:productivity_app/widgets/task_container.dart';
import 'package:provider/provider.dart';

class TasksForToday extends StatefulWidget {
  //  TasksForToday({super.key,required this.task});
      TasksForToday({super.key});

// TaskModel task;

  @override
  State<TasksForToday> createState() => _TasksForTodayState();
}

class _TasksForTodayState extends State<TasksForToday> {
  List<TaskModel> allTasks=[];
  bool isLoading=true;
  int? selectedIndex;
  @override
  void initState(){
    super.initState();
    // getTasks();
Future.microtask(() {
      String todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
      context.read<TaskProvider>().fetchTasks(todayStr);
    });
  }
  // Future<void>getTasks()async{
  //       String todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());

  //   // var snapshot=await FirebaseFirestore.instance.collection('users').doc(widget.task.userId).collection('tasks').get();
  //   String? uid=FirebaseAuth.instance.currentUser?.uid;
  //   if(uid !=null){
  //     var snapshot=await FirebaseFirestore.instance.collection('users').doc(uid).collection('tasks').where('date',isEqualTo:todayStr).get();
    
  //   List<TaskModel>fetchedTasks=snapshot.docs.map((doc){
  //     return TaskModel.fromMap(doc.data());
  //   }).toList();
  //   setState(() {
  //     allTasks=fetchedTasks;
  //     isLoading=false;
  //   });
  // }
  // }
  Widget build(BuildContext context) {
        String todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());

    return Scaffold(
      bottomNavigationBar: CustomBottomNavigatorBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 29),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Column(
              children: [
                Text('Today\'s Task',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
                Text(todayStr.toString()),
              ],
            ),          
          ],),
          SizedBox(height: 60,),

          Expanded(
            child: Consumer<TaskProvider>(builder: (context, taskProvider, child) {
              if(taskProvider.isLoading){
                return Center(child: CircularProgressIndicator(),);
              }
              if(taskProvider.allTasks.isEmpty){
              return  Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/man_work.jpg',height: 400,width: 400,scale: 0.1,),
            SizedBox(height: 10,),
            Text('No tasks for today')
            ],
          ),
                );
              }
              return ListView.builder(
            
            itemBuilder: (context, index) {
              final task=taskProvider.allTasks[index];
              bool isExpanded = selectedIndex == index;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  
                  onTap: () {
                    setState(() {
                      selectedIndex = isExpanded ? null : index;
                    });
                  },
                  child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300), // سرعة الحركة
                      curve: Curves.easeInOut, // نوع الحركة
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TaskContainer(task: task),

              if (isExpanded) ...[
                const Divider(height: 20, thickness: 1),
                const Text(
                  "Description:",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                const SizedBox(height: 5),
                Text(
                  task.taskDetails, // جلب الوصف من الموديل
                  style: const TextStyle(fontSize: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                          String uid = FirebaseAuth.instance.currentUser!.uid;
                          taskProvider.deleteTask(task, uid);
                          setState(() {
                          selectedIndex = null;
                        });
                      }, 
                      icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                      label: const Text("Delete Task", style: TextStyle(color: Colors.redAccent)),
                    ),
                  ],
                ),
              ],
            ],
          )
                  ),
                  
          ));

          },itemCount:taskProvider.allTasks.length,physics: const BouncingScrollPhysics(),);
            },)
            
          
          
          
  )],),
      ),
    );
  }
//   Future<void> _handleDelete(TaskModel task, String uid, String date) async {
//   try {
//     var firestore = FirebaseFirestore.instance;
//     await firestore.collection('users').doc(uid).collection('tasks').doc(task.taskId).delete();
    
//     var analyticDoc = firestore.collection('users').doc(uid).collection('analytics').doc(date);
    
//     await analyticDoc.update({
//       'totalTasks': FieldValue.increment(-1),
//       'notAchieved': FieldValue.increment(-1),
// task.taskCategory.trim(): FieldValue.increment(-1),
//    });
//   } catch (e) {
//     debugPrint("Error during delete: $e");
//   }
//   }
}