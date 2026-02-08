import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateContainer extends StatelessWidget {
  const DateContainer({super.key,  this.isSelected=false, required this.date});
    final bool isSelected;
     final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
      color: isSelected?Color(0xFF53ceaf):Colors.black,
        borderRadius: BorderRadius.circular(9),
      ),
      height: 65,
      width: 47,
      child: Column(children: [
        SizedBox(height: 9,),
        Text(
          DateFormat('E').format(date).toLowerCase(),
          style: TextStyle(color: Colors.white),),
        SizedBox(height: 4),
        Text(DateFormat('d').format(date),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
      ],),
    );
  }
}