import 'package:flutter/material.dart';

class BackIconButton extends StatelessWidget {
  const BackIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  IconButton(
                style: IconButton.styleFrom(
                    backgroundColor: Color(0xFFE8F5E9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    ),
                    padding: EdgeInsets.all(9)
                ),
                onPressed: () {
                
              }, icon:Icon( Icons.arrow_back_ios_new_rounded,color: Color(0xFF4CAF50),));
  }
}