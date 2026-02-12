import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:productivity_app/models/task_model.dart';
import 'package:productivity_app/models/user_model.dart';
import 'package:productivity_app/providers/task_provider.dart';
import 'package:productivity_app/screens/completed_tasks.dart';
import 'package:productivity_app/screens/tasks_for_today.dart';
import 'package:productivity_app/widgets/category_container.dart';
import 'package:productivity_app/widgets/state_card.dart';
import 'package:productivity_app/widgets/task_container.dart';
import 'package:provider/provider.dart';

class HomePageWithTasks extends StatefulWidget {
  const HomePageWithTasks({super.key,required this.userModel,required this.totalTasks,required this.achievedTasks});
final UserModel userModel;
final int totalTasks;
final int achievedTasks;

  @override
  State<HomePageWithTasks> createState() => _HomePageWithTasksState();
}

class _HomePageWithTasksState extends State<HomePageWithTasks> {
  String? selectedCategory;
  @override
  Widget build(BuildContext context) {
    String todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());

   final totalsStream= FirebaseFirestore.instance.collection('users').doc(widget.userModel.uid).collection('analytics').doc(todayStr).snapshots();
    return  StreamBuilder<DocumentSnapshot>(
      stream: totalsStream,
      builder: (context, snapshot) {
        Map<String, dynamic> data = snapshot.data?.data() as Map<String, dynamic>? ?? {};
       
       Map<String,int>categoryCounts={};
       List<String>excludedKeys=['totalTasks','notAchieved','achievedTasks'];
       data.forEach((key,value){
        if(!excludedKeys.contains(key)&& value is num){
          categoryCounts[key]=value.toInt();
        }
       });

List<String> activeCategories = categoryCounts.keys
    .where((cat) => (categoryCounts[cat] ?? 0) > 0)
    .toList();        return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      
              GridView.count(crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              padding: const EdgeInsets.all(15),
              shrinkWrap: true, 
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 3,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return TasksForToday();
                    },));
                  },
                  child: StateCard(color: Colors.blue.shade400, count: ' ${widget.totalTasks.toString()} tasks', icon: Icons.list, title: 'To DO')),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return CompletedTasks();
                    },));
                  },
                  child: StateCard(color: Colors.orange.shade400, count: '${widget.totalTasks-widget.achievedTasks} tasks', icon: Icons.pending_actions, title: 'On Going')),
                StateCard(color: Color(0xFF53ceaf), count:'${widget.achievedTasks.toString()} tasks', icon: Icons.check_circle, title: 'Completed'),
              
              ],),
              SizedBox(height: 20,),
            Text('Category',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23),),
            SizedBox(height: 20,),
             SizedBox(
                height: 130, // حددي الارتفاع المناسب لشكل الكارت
                child: ListView.builder(
              scrollDirection: Axis.horizontal, // 👈 هذا ما يجعل التمرير لليمين
              itemCount: activeCategories.length,
              itemBuilder: (context, index) {
                String name=activeCategories[index];
                int count=categoryCounts[name]??0;

                return Padding(
                  padding: const EdgeInsets.only(right: 15), // مسافة بين الكروت
                  child: CategoryContainer(
                    count: count,
                    name: name,
                    onTapShow: (){
                      setState(() {
                        selectedCategory=name;
                      });
                    },
                  ) 
                );
              },
                      ),
                    ),
            if(selectedCategory!=null)...[
              Consumer<TaskProvider>(builder: (context, taskProvider, child) {
                if(taskProvider.isLoading){
                  return const Center(child: CircularProgressIndicator());
                }
                final filteredTasks=taskProvider.allTasks.where((t)=>t.taskCategory ==selectedCategory).toList();
                if (filteredTasks.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(child: Text("No tasks found for today in $selectedCategory")),
                  );
                }
                 return 
                 ListView.builder(
                  shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredTasks.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TaskContainer(task: filteredTasks[index]),
                            );
                          },
                        
              );
              },)
        
            
            ]
          ],
        
      ),
    );
   } );}
}