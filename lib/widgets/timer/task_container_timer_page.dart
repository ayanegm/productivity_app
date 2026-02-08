import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:productivity_app/models/task_model.dart';


class TaskContainerTimerPage extends StatelessWidget {
   TaskContainerTimerPage({super.key,required this.task});
TaskModel task;
int? totalTasks;
int? achievedTasks;
  String todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 12,top: 17,bottom: 17),
      width:double.infinity,
      decoration: BoxDecoration(
      color: Color(0xFFffffff),
        borderRadius:BorderRadius.circular(10),
        
      ),
      
      child: Column(
        mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Container(decoration: BoxDecoration(
              color: task.color,
              borderRadius:BorderRadius.circular(10),
            ),
            height: 55,
            width: 55,
            child: Center(child:Image.asset(task.iconpath,height: 40,width: 40,)),
            ),
            SizedBox(width: 11,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                SizedBox(height: 4,),
                Text(task.taskTitle,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),),
                SizedBox(height: 7,),
                Text(task.duration),
                
              ],),
            ),
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('users').doc(task.userId).collection('analytics').doc(todayStr).snapshots(),
              builder:(context,snapshot){
                if (snapshot.hasData && snapshot.data!.exists) {
              var data = snapshot.data!.data() as Map<String, dynamic>;
               totalTasks=data['totalTasks'];
               achievedTasks=data['achievedTasks']??0;
              }
              
              return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 4,),
                      Text('${achievedTasks.toString()}\/${totalTasks.toString()}',style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: 7,),
                        Text(task.date, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                    ],
                  ),
                  SizedBox(width: 7,),
                  
              ],);
             } )
            
          ],),
       
  if (task.taskDetails.isNotEmpty) ...[
            const Divider(height: 20, thickness: 0.5), // خط فاصل بسيط
            Text(
              "Description:",
              style: TextStyle(
                fontSize: 12, 
                fontWeight: FontWeight.bold, 
                color: Colors.grey[700]
              ),
            ),
            const SizedBox(height: 4),
            Text(
              task.taskDetails,
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ],
      ])
    );
  }
}