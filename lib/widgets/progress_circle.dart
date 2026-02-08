import 'package:flutter/material.dart';

class ProgressCircle extends StatelessWidget {
   ProgressCircle({super.key,required this.percentage});
double percentage;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(height: 60,
        width: 60,
        child: CircularProgressIndicator(
            value: percentage/100,
            strokeWidth: 10,
            backgroundColor: Colors.white,
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF53ceaf)),
        ),),
        Text('${percentage.toInt()}%',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16
        ),)
      ],
    );
  }
}