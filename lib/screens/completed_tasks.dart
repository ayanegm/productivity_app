import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:productivity_app/models/task_model.dart';
import 'package:productivity_app/widgets/task_container.dart';

class CompletedTasks extends StatefulWidget {
   CompletedTasks({super.key});

  @override
  State<CompletedTasks> createState() => _CompletedTasksState();
}

class _CompletedTasksState extends State<CompletedTasks> {
String uid=FirebaseAuth.instance.currentUser!.uid;

List allTasks=[];



  @override
  Widget build(BuildContext context) {
    String todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        title: Text('Completed tasks'),
        
      ),
      body:  StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(uid).collection('tasks').where('date',isEqualTo: todayStr).where('isAchieved', isEqualTo: true).snapshots(),
        builder: (context,snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/man_work.jpg',height: 400,width: 400,scale: 0.1,),
            SizedBox(height: 10,),
            Text('No tasks Completed')
            ],
          ),);
          }
          List<TaskModel> completedTasks = snapshot.data!.docs.map((doc) {
            return TaskModel.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();
          return ListView.builder(
            itemCount: completedTasks.length,
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TaskContainer(task: completedTasks[index]),
              );
        }
          ); 
        }
      )
    );
  }
}