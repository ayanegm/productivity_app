import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:productivity_app/models/task_model.dart';
import 'package:productivity_app/widgets/bottom_navigator_bar.dart';
import 'package:productivity_app/widgets/task_container.dart';

class DisplayTasks extends StatefulWidget {
  const DisplayTasks({super.key});

  @override
  State<DisplayTasks> createState() => _AnothTasksState();
}

class _AnothTasksState extends State<DisplayTasks> {

      final String uid = FirebaseAuth.instance.currentUser!.uid;
    String todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());

  late final Stream<QuerySnapshot> tasksStreams=FirebaseFirestore.instance.collection('users').doc(uid).collection('tasks').where('date', isEqualTo: todayStr).snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigatorBar(selectedIndex: 1,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 29),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Column(
              children: [
                Text('Today\'s Task',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
                Text('February 31,2026'),
              ],
            ),          
          ],),
          SizedBox(height: 60,),
          
          Expanded(
            child: StreamBuilder<QuerySnapshot>(stream:tasksStreams , builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
              if(snapshot.hasError){
                return Text('Error');
              }
              if(snapshot.connectionState ==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    var doc = snapshot.data!.docs[index];
                    TaskModel taskModel = TaskModel.fromMap(doc.data() as Map<String, dynamic>);
                 
                }
              );},
         )
          )
          ] )
                )
    );
  }
  Future<void> _handleDelete(TaskModel task, String uid, String date) async {
  try {
    var firestore = FirebaseFirestore.instance;
    // 1. حذف المهمة
    await firestore.collection('users').doc(uid).collection('tasks').doc(task.taskId).delete();
    
    // 2. تحديث الإحصائيات لليوم الحالي
    var analyticDoc = firestore.collection('users').doc(uid).collection('analytics').doc(date);
    
    await analyticDoc.update({
      'totalTasks': FieldValue.increment(-1),
      'notAchieved': FieldValue.increment(-1),
      'categoryCounts.${task.taskCategory}': FieldValue.increment(-1),
    });
  } catch (e) {
    debugPrint("Error during delete: $e");
  }
  }
}