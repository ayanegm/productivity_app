import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key,required this.text,required this.onTap});
final String text;
final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed:onTap, child: Text(text,style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w100),),style: ElevatedButton.styleFrom(backgroundColor:Colors.black,),);
  }
}