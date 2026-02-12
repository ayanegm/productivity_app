import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:productivity_app/models/task_model.dart';
import 'package:productivity_app/services/task_service.dart';

class TaskProvider with ChangeNotifier {
  final TaskService _taskService = TaskService();
  List<BarChartGroupData> dailyProgress = [];
  List<TaskModel> _allTasks = [];
  bool _isLoading = false;

  List<TaskModel> get allTasks => _allTasks;
  bool get isLoading => _isLoading;


Future<void>fetchLast7Days()async{
  String uid=FirebaseAuth.instance.currentUser!.uid;
  List<BarChartGroupData>tempList=[];
  for (int i=6;i>=0;i--){
DateTime date = DateTime.now().subtract(Duration(days: i));
    String docId = DateFormat('yyyy-MM-dd').format(date);
    var doc=await FirebaseFirestore.instance.collection('users').doc(uid).collection('analytics').doc(docId).get();
    double notAchieved=0;
    double total=0;
    double achieved=0;
   if(doc.exists){
    total=(doc.data()?['totalTasks']??0).toDouble();
    notAchieved=(doc.data()?['notAchieved']??0).toDouble();
   achieved=total-notAchieved;
  }
  else{
    achieved=0;
    notAchieved=0;
  }
  tempList.add(BarChartGroupData(x: 6-i,
  barRods: [
    BarChartRodData(toY: total,color: Color(0xFF53ceaf),width:10),
    BarChartRodData(toY: achieved,color: Colors.red,width: 10),
  ]));
  }
  dailyProgress=tempList;
  notifyListeners();
}


  // 1. دالة العرض (Fetch) - تستدعى عند فتح الصفحة
  Future<void> fetchTasks(String date) async {
    _isLoading = true;
    // لا نضع notifyListeners هنا مباشرة لتجنب خطأ Build
    
    try {
      _allTasks = await _taskService.getTasks(date);
    } catch (e) {
      print("Error fetching: $e");
    } finally {
      _isLoading = false;
      notifyListeners(); // نحدث الواجهة مرة واحدة بعد جلب البيانات
    }
  }

  // 2. دالة الحفظ (Save) - التحديث اللحظي (نفس الثانية)
  Future<void> addNewTask(TaskModel newTask) async {
    // أ- أضيفي المهمة للقائمة المحلية فوراً
    _allTasks.add(newTask);
    
    // ب- أبلغي الواجهة بالتحديث "في نفس الثانية"
    notifyListeners(); 

    try {
      String todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
      
      // ج- الحفظ في Firebase (في الخلفية)
      await _taskService.saveTask(newTask, todayStr);
      
      print("Saved successfully");
    } catch (e) {
      // د- إذا فشل الحفظ، نحذفها من القائمة المحلية لضمان دقة البيانات
      _allTasks.removeWhere((t) => t.taskId == newTask.taskId);
      notifyListeners();
      print("Error saving task: $e");
    }
  }

  // 3. دالة الحذف
  Future<void> deleteTask(TaskModel task, String uid) async {
    // حذف لحظي
    _allTasks.removeWhere((t) => t.taskId == task.taskId);
    notifyListeners();

    try {
      await _taskService.delteTask(task, uid, task.date);
    } catch (e) {
      // إعادة المهمة للقائمة إذا فشل الحذف في السيرفر
      _allTasks.add(task);
      notifyListeners();
    }
  }
}