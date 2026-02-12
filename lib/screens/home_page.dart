import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:productivity_app/helper/bar_chart_data.dart';
import 'package:productivity_app/models/user_model.dart';
import 'package:productivity_app/providers/task_provider.dart';
import 'package:productivity_app/screens/account_page.dart';
import 'package:productivity_app/screens/home_page_with_tasks.dart';
import 'package:productivity_app/widgets/bottom_navigator_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskProvider>().fetchLast7Days(); //
    });
  }
  Widget build(BuildContext context) {
  final String uid=FirebaseAuth.instance.currentUser!.uid;
  String todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final taskProvider = context.watch<TaskProvider>(); 
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigatorBar(selectedIndex: 0,),
      body:SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
            builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              
              var userData=snapshot.data!.data() as Map<String,dynamic>;
              UserModel userModel=UserModel.fromMap(userData);
              return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                      
                      SizedBox(width: 9,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hi,${userModel.name}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          SizedBox(height: 1,),
                          Row(
                            children: [
                              Text('Your daily adventure starts now',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 123, 123, 123)),),
                              const Icon(
                                Icons.front_hand, 
                                color: Colors.amber, 
                                size: 20,
                              ),
              
                            ],
                          ),
                          const SizedBox(height: 30),                    
                        ],
                      ),
                    ],),
                    const Text('Weekly Activity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    _buildWeeklyChart(taskProvider),
                    SizedBox(height: 50,),
                   Consumer<TaskProvider>(
                    builder:(context,TaskProvider,child){
                     return StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance.collection('users').doc(userModel.uid).collection('analytics').doc(todayStr).snapshots(),
                     builder: (context,snapshot){
                      if(!snapshot.hasData || !snapshot.data!.exists){
                        return _buildEmptyState();
                      }
                      var data=snapshot.data!.data() as Map<String,dynamic>;
                      int totalTasks=data['totalTasks'] ??0;
                      int achievedTasks=data['achievedTasks']??0;
                      if(totalTasks ==0){
                       return _buildEmptyState();
                      }
                      else{
                        return Column(
                          children: [
                            
                            HomePageWithTasks(userModel: userModel,achievedTasks:achievedTasks,totalTasks: totalTasks,),
                          ],
                        );
                    
                      }
                    });
                    }
                   )
                    
              
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }
Widget _buildWeeklyChart(TaskProvider provider) {
    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          maxY: 10, // يمكن جعلها ديناميكية لاحقاً
          barGroups: provider.dailyProgress, // البيانات من الـ Provider
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  DateTime date = DateTime.now().subtract(Duration(days: 6 - value.toInt()));
                  return Text(DateFormat('MMM dd').format(date), style: const TextStyle(fontSize: 10, color: Colors.grey));
                }, //
              ),
            ),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
        ),
      ),
    );
  }
  Widget _buildEmptyState(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
              Image.asset('images/man_work.jpg',height: 400,width: 400,scale: 0.1,),
              SizedBox(height: 10,),
              Text('No tasks for today')
      ],),
    );
  }
}