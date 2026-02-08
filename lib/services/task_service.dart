import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:productivity_app/helper/get_category_style.dart';
import 'package:productivity_app/models/task_model.dart';
import 'package:productivity_app/widgets/random_color.dart';

class TaskService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;


Future<List<TaskModel>> getTasks(String date) async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return [];

    var snapshot = await _db
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .where('date', isEqualTo: date)
        .get();

    return snapshot.docs.map((doc) => TaskModel.fromMap(doc.data())).toList();
  }

    Future<TaskModel>saveTask(TaskModel task,String todayStr)async{
    String uid=FirebaseAuth.instance.currentUser!.uid;
    var taskRef=FirebaseFirestore.instance.collection('users').doc(uid).collection('tasks').doc(task.taskId);
    var analyticsRef=FirebaseFirestore.instance.collection('users').doc(uid).collection('analytics').doc(todayStr);
  
    
    WriteBatch batch=FirebaseFirestore.instance.batch();
    batch.set(taskRef, task.toMap());
    if (task.date == todayStr) {
    batch.set(
      analyticsRef,
      {
        'totalTasks': FieldValue.increment(1),
        'notAchieved': FieldValue.increment(1),
        task.taskCategory.trim(): FieldValue.increment(1),
      },
      SetOptions(merge: true),
    );
  }

  try {
    await batch.commit(); 
    return task;
  } catch (e) {
    print("Error committing batch: $e");
    rethrow; 
  }
}
  Future<void> delteTask(TaskModel task, String uid, String date) async {
  try {
    var firestore = FirebaseFirestore.instance;
    await firestore.collection('users').doc(uid).collection('tasks').doc(task.taskId).delete();
    
    var analyticDoc = firestore.collection('users').doc(uid).collection('analytics').doc(date);
    
    await analyticDoc.update({
      'totalTasks': FieldValue.increment(-1),
      'notAchieved': FieldValue.increment(-1),
task.taskCategory.trim(): FieldValue.increment(-1),
   });
  } catch (e) {
    print("Error during delete: $e");
  }
  }

}