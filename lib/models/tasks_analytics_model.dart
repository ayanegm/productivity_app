class TaskAnalyticsModel {
static const List<String> items = [
    'Design', 'Development', 'Education', 'Meeting', 
    'Fitness', 'Meditation', 'Relaxing time', 'Work', 'Coding'
  ];  
  final int totalTasks;
  final int achievedTasks;
  final String userId;
  final Map<String,int>categoryCounts;
   TaskAnalyticsModel({
     this.totalTasks=0,
     this.achievedTasks=0,
required this.categoryCounts,
    required this.userId,
  }) ;
   
    
    
   factory TaskAnalyticsModel.fromMap(Map<String, dynamic> data, String uid) {
    return TaskAnalyticsModel(
      userId: uid,
      totalTasks: data['totalTasks'] ?? 0,
      categoryCounts: {
        for (var item in items) item: (data['categoryCounts']?[item] ?? 0),
      },
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'totalTasks': totalTasks,
      'achievedTasks': achievedTasks,
      'categoryCounts': categoryCounts,
      'userId':userId
    };
  }
}