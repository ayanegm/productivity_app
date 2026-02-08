import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:productivity_app/models/task_model.dart';
import 'package:productivity_app/services/task_service.dart';

class TaskProvider with ChangeNotifier {
  final TaskService _taskService = TaskService();
  
  List<TaskModel> _allTasks = [];
  bool _isLoading = false;

  List<TaskModel> get allTasks => _allTasks;
  bool get isLoading => _isLoading;

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