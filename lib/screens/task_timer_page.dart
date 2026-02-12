import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:productivity_app/models/task_model.dart';
import 'package:productivity_app/widgets/bottom_navigator_bar.dart';
import 'package:productivity_app/widgets/timer/task_container_timer_page.dart';
import 'package:productivity_app/widgets/timer/timer_icon_button.dart';

class TaskTimerPage extends StatefulWidget {
 TaskTimerPage({super.key,required this.taskModel});

TaskModel taskModel;

  @override
  State<TaskTimerPage> createState() => _TaskTimerPageState();
}

class _TaskTimerPageState extends State<TaskTimerPage> {
  late int seconds=maxSeconds;
  late int maxSeconds=60;
  Timer? timer;
  void startTimer({bool reset=true}){
    if(reset){
      resetTimer();
    }
    timer =Timer.periodic(Duration(seconds: 1), (_){
      if(seconds>0){
         setState(() {
        seconds--;
      });
      }
     else{
      stopTimer(reset: false);
      markTaskAsDone(widget.taskModel);
     }
      
    });
  }
  void stopTimer({bool reset=true}){
    if(reset){
      resetTimer();
    }
   setState(() {
      timer?.cancel();
   });
  }
  void resetTimer(){
    setState(() {
      seconds=maxSeconds;
    });
  }
  void _setupTimer(){
    List<String>parts=widget.taskModel.duration.split(':');
    Duration d=Duration(
      hours: int.parse(parts[0]),
      minutes: int.parse(parts[1]),
      seconds: int.parse(parts[2])
    );
    setState(() {
      maxSeconds=d.inSeconds;
      seconds=maxSeconds;
    });
  }
  Future<void> markTaskAsDone(TaskModel task)async{
            String todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());

    DocumentReference taskRef = FirebaseFirestore.instance
      .collection('users')
      .doc(task.userId)
      .collection('tasks')
      .doc(task.taskId);
      DocumentReference analyticsRef = FirebaseFirestore.instance
      .collection('users')
      .doc(task.userId)
      .collection('analytics')
      .doc(todayStr);
    WriteBatch batch=FirebaseFirestore.instance.batch();
batch.update(taskRef, {'isAchieved': true});
batch.set(analyticsRef, {
    'achievedTasks': FieldValue.increment(1),
    'notAchieved': FieldValue.increment(-1),
  }, SetOptions(merge: true));
    try {
    await batch.commit();
    print("Firebase Updated Successfully!");
  } catch (e) {
    print("Firebase Update Failed: $e");
  }

  }
  @override
  void initState(){
    super.initState();
    _setupTimer();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:CustomBottomNavigatorBar(selectedIndex: 1,),
      appBar: AppBar(
        
        title:   Center(child: Text('Timer',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),))
        
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0,right: 20,top: 15),
        child: Column(children: [
           TaskContainerTimerPage(task: widget.taskModel),
           SizedBox(height: 100,),
                buildTimer(),
                SizedBox(height: 40,),
                buildButtons(),
              
            
        ],),
      ),
    );
  }
  Widget buildButtons(){
    final isRunning=timer==null?false:timer!.isActive;
      final isCompleted=seconds==maxSeconds||seconds==0;

    return isRunning||!isCompleted ? Row(
    mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isRunning?TimerIconButton(icon:Icons.pause, onTap: (){
          stopTimer(reset: false);
        }, size:27 , color: Color(0xFF53ceaf)):TimerIconButton(icon:Icons.play_arrow, onTap: (){
          startTimer(reset: false);
        }, size:27 , color: Color(0xFF53ceaf)),
        
        
        SizedBox(width: 20,),
        
        Container(
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(
      color: Colors.grey.shade300, // لون الدائرة الخارجية (رمادي فاتح مثل الصورة)
      width: 2.0,                  // سمك الدائرة
    ),
  ),
  child: IconButton(
    icon: const Icon(Icons.replay),
    color: Colors.grey,         
    iconSize: 25.0,                
    onPressed: (){
      stopTimer(reset: true);
    }
  ),
)
      ],
   ):TimerIconButton(icon: Icons.play_arrow, onTap:startTimer , size: 40, color: Color(0xFFf69d5f));

  }
  Widget buildTimer(){
     return SizedBox(height:200 ,width:200 ,child: Stack(
    fit: StackFit.expand,
    children:[
       CircularProgressIndicator(
        value: seconds/maxSeconds,
        valueColor: AlwaysStoppedAnimation(Color(0xFFf9f9f9)),
        strokeWidth: 12,
        backgroundColor: Color(0xFF53ceaf),

       ),
       Center(child: buildTime(),)
     ])
     );
  }
  Widget buildTime(){
    if(seconds==0){
      return Icon(Icons.done,color: Color(0xFF53ceaf),size: 112,);
    }
    Duration remaining=Duration(seconds: seconds);
    String hours=remaining.inHours.toString().padLeft(2,'0');
    String minutes = (remaining.inMinutes % 60).toString().padLeft(2, '0');
    String secs = (remaining.inSeconds % 60).toString().padLeft(2, '0');
    return Text(
      remaining.inHours > 0 ? '$hours:$minutes:$secs' : '$minutes:$secs',
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 45),
    );
       
       
    

}
}
