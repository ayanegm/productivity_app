import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:productivity_app/helper/get_category_style.dart';
import 'package:productivity_app/main.dart';
import 'package:productivity_app/models/task_model.dart';
import 'package:productivity_app/screens/tasks_for_today.dart';
import 'package:productivity_app/widgets/bottom_navigator_bar.dart';
import 'package:productivity_app/widgets/date_container_list.dart';
import 'package:productivity_app/widgets/random_color.dart';
import 'package:productivity_app/widgets/task_category_dropList.dart';
import 'package:productivity_app/widgets/tasks_text_field.dart';
import 'package:productivity_app/widgets/timer/selected_period_button.dart';
import 'package:productivity_app/widgets/timer/timer_picker.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
TextEditingController taskTitleController=TextEditingController();
TextEditingController taskDetailsController=TextEditingController();
TextEditingController durationController=TextEditingController();
TextEditingController reminderTimeController=TextEditingController();
GlobalKey<FormState>formState=GlobalKey<FormState>();
String selectedCategory = "Work";
DateTime selectedDate = DateTime.now();
Duration selectedDuration =Duration(hours: 0);
String finalPeriod = "AM";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigatorBar(),
      body: SingleChildScrollView(
        child: Form(
          key:formState ,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19),
            child: Column(children: [
              SizedBox(height: 60,),
              Text('NewTask',style: TextStyle(fontSize: 21,fontWeight: FontWeight.w900),),
              SizedBox(height: 23,),
              TasksTextField(hintText:'Task Title' ,controller: taskTitleController,validator: (value) {
                if(value==''){
                  return 'this field cannot be empty';
                }
              },),
              SizedBox(height: 21,),
              
             
              TasksTextField(hintText:'Duration' ,controller: durationController,validator: (value) {
                if(value==''){
                  return 'this field cannot be empty';
                }
              },readOnly: true,onTap: ()async {
                  final Duration? picked =await TimerPickerHelper.showDurationPicker(context, Duration(hours: 0));
                  if(picked!=null){
                    setState(() {
                  durationController.text = 
            "${picked.inHours.toString().padLeft(2, '0')}:${(picked.inMinutes % 60).toString().padLeft(2, '0')}:${(picked.inSeconds % 60).toString().padLeft(2, '0')}";
             });
                  }
              },),
              SizedBox(height: 21,),
              Row(
                children:[ Expanded(
                  child: TasksTextField(hintText:'Reminder Time' ,controller: reminderTimeController,readOnly: true,onTap: ()async {
                    int hours=0;
                      final Duration? picked =await TimerPickerHelper.showDurationPicker(context, Duration(hours: 0));
                      
                      if(picked!=null){
                        if(picked!.inHours==hours){
                        hours=1;
                    }
                    else{
                      hours=picked.inHours;
                    }
                        setState(() {
                      reminderTimeController.text = 
                              "${hours.toString().padLeft(2, '0')}:${(picked.inMinutes % 60).toString().padLeft(2, '0')}:${(picked.inSeconds % 60).toString().padLeft(2, '0')}";
                               });
                      }
                  },),
                ),
                SizedBox(width: 10,),
                Center(
                  child: selectedPeriodButton(onChanged: (newValue) {
                    setState(() {
                      finalPeriod = newValue;
                    });
                  },), 
                )
                
            ]),
              SizedBox(height: 21,),
              TaskCategoryDroplist(onChanged: (val) {
                selectedCategory=val!;
                
              },),
              SizedBox(height: 21,),
              TasksTextField(hintText:'Task Details' ,controller: taskDetailsController,),
              SizedBox(height: 21,),
              DateContainerList(onDataSelected: (value) {
                setState(() {
                  selectedDate=value;
                });
              },),
              SizedBox(height:25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black
                ),
                onPressed: ()async {
                TaskModel savedTask=await saveTask();
                if (reminderTimeController.text.isNotEmpty && reminderTimeController.text.contains(':')) {
                        startInAppReminder(reminderTimeController.text, finalPeriod);
                      }
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TasksForToday();
                },));
              }, child: Text('save',style: TextStyle(color: Colors.white)))
            ],),
          ),
        ),
      ),
    );
  }
  Future<TaskModel>saveTask()async{
    String uid=FirebaseAuth.instance.currentUser!.uid;
    var taskRef=FirebaseFirestore.instance.collection('users').doc(uid).collection('tasks').doc();
        String todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var analyticsRef=FirebaseFirestore.instance.collection('users').doc(uid).collection('analytics').doc(todayStr);
    final style = selectedCategoryHelper.getCategoriesStyle(selectedCategory);
    final color=RandomColor.getRandomColor();
  String taskDateStr = DateFormat('yyyy-MM-dd').format(selectedDate);
    TaskModel newTask=TaskModel(color:color,iconpath:style['image'],isAchieved: false,taskId:taskRef.id , userId: uid, taskTitle: taskTitleController.text, taskCategory: selectedCategory, duration: durationController.text, date: DateFormat('yyyy-MM-dd').format(selectedDate), taskDetails: taskDetailsController.text,reminderTime:reminderTimeController.text ,selectedPeriod: finalPeriod);
    
    WriteBatch batch=FirebaseFirestore.instance.batch();
    batch.set(taskRef, newTask.toMap());
    if (taskDateStr == todayStr) {
    batch.set(
      analyticsRef,
      {
        'totalTasks': FieldValue.increment(1),
        'notAchieved': FieldValue.increment(1),
selectedCategory.trim(): FieldValue.increment(1),
      },
      SetOptions(merge: true),
    );
  }

  try {
    await batch.commit(); 
    startInAppReminder(reminderTimeController.text, finalPeriod);
    return newTask;
  } catch (e) {
    print("Error committing batch: $e");
    rethrow; 
  }
}
////////////////////////////////////////////////////////////////////////
void startInAppReminder(String timeText, String period) {
  try {
    if (timeText.isEmpty || !timeText.contains(':')) return;

    List<String> parts = timeText.split(':');
    int hour = parts.isNotEmpty ? int.parse(parts[0]) : 0;
    int minute = parts.length > 1 ? int.parse(parts[1]) : 0;

    if (period == "PM" && hour < 12) hour += 12;
    if (period == "AM" && hour == 12) hour = 0;

    final now = DateTime.now();
    DateTime scheduledDate = DateTime(now.year, now.month, now.day, hour, minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    Duration delay = scheduledDate.difference(now);

    Future.delayed(delay, () {
      if (navigatorKey.currentContext != null) {
        showDialog(
          context: navigatorKey.currentContext!,
          builder: (context) => AlertDialog(
            title: const Text('Task Reminder ⏰'),
            content: Text('It is time for: ${taskTitleController.text}'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Got it!')),
            ],
          ),
        );
      }
    });
  } catch (e) {
    debugPrint("Reminder Format Error: $e");
  }
}
}