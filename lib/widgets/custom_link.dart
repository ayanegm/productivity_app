import 'package:flutter/material.dart';

class CustomLink extends StatelessWidget {
   CustomLink({super.key,required this.link_text});
String link_text;
  @override
  Widget build(BuildContext context) {
    return Text(link_text,style: TextStyle(
              color:  Color(0xFF4CAF50), 
              
              fontSize: 16,
              decorationColor: Color(0xFF4CAF50),
              decoration: TextDecoration.underline, 
              decorationThickness: 2, 
            ),);
  }
}