import 'package:flutter/material.dart';

class StateCard extends StatelessWidget {
   StateCard({super.key,required this.color,required this.count,required this.icon,required this.title});
String title,count;
Color color;
IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(15), 
    ),
    child:Row(
      
      children: [
        Stack(
          children: [
            Container(
              
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25), 
              shape: BoxShape.circle,
              ),
              child:  Icon(icon,color: Colors.white,size: 22,),
            ),
            
          ],
        ),
                SizedBox(width: 12,),

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            Text(count, style: const TextStyle(color: Colors.white70, fontSize: 16)),
          ],
        ),
      ],
    ) ,
    );
  }
}