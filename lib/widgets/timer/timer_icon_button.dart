import 'package:flutter/material.dart';

class TimerIconButton extends StatelessWidget {
   TimerIconButton({super.key,required this.icon,required this.onTap, required this.size, required this.color, this.backgroundColor});
 IconData icon;
final VoidCallback onTap;
final double size;
final Color color;
final Color?backgroundColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Icon(icon,color: Colors.white,size: size,),

      ),
    );
  }
}