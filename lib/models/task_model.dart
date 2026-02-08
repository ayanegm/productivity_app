import 'package:flutter/material.dart';

class TaskModel {
  final String taskTitle;
  final String taskCategory;
  final String duration;
  final String date;
  final String taskDetails;
  final String taskId;
  final String userId;
  final String iconpath;
  final Color color;
   final String? reminderTime;
  final String? selectedPeriod;
 bool isAchieved;
  TaskModel({this.selectedPeriod,this.reminderTime,required this.iconpath,required this.color, required this.taskId, this.isAchieved=false,required this.userId,required this.taskTitle, required this.taskCategory, required this.duration, required this.date, required this.taskDetails}); 
  factory TaskModel.fromMap(Map<String,dynamic>map){
    return TaskModel(selectedPeriod:map['selectedPeriod'],reminderTime: map['reminderTime'],color: Color(map['color'] ?? 0xFF4CAF50),iconpath:map['icon'],taskTitle:map['taskTitle'], isAchieved: map['isAchieved'],taskCategory: map['taskCategory'], duration: map['duration'], date: map['date'], taskDetails: map['taskDetails'], taskId: map['taskId'], userId: map['userId']);

  }
  Map<String,dynamic>toMap(){
    return {
      'taskTitle':taskTitle,
      'taskCategory':taskCategory,
      'duration':duration,
      'date':date,
      'taskDetails':taskDetails,
      'userId':userId,
      'taskId':taskId,
      'isAchieved':isAchieved,
      'color':color.value,
      'icon':iconpath,
      'reminderTime':reminderTime,
      'selectedPeriod':selectedPeriod
    };
  }
}