import 'package:flutter/material.dart';
import 'package:productivity_app/models/task_model.dart';
import 'package:productivity_app/screens/task_timer_page.dart';

class TaskContainer extends StatelessWidget {
   TaskContainer({super.key,required this.task});
TaskModel task;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 12,top: 17,bottom: 17),
      height: 90,
      width:double.infinity,
      decoration: BoxDecoration(
      color:  Colors.white,
        borderRadius:BorderRadius.circular(10),
      ),
      
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Container(decoration: BoxDecoration(
          color: task.color,
          borderRadius:BorderRadius.circular(10),
        ),
        height: 55,
        width: 60,
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
            Text(task.taskCategory),
            
          ],),
        ),
        Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                SizedBox(height: 4,),
                Text(task.duration,style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 7,),
                  Text(task.date, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
              ],
            ),
            SizedBox(width: 7,),
            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return TaskTimerPage(taskModel: task,);
              },));
            }, icon: Icon(Icons.play_circle_outline,size: 32,)),

            if(task.isAchieved)
              Icon(Icons.check_circle_outline,size: 32,color: Color(0xFF53ceaf))
            
        ],)
        
      ],),
    );
  }
}