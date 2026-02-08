import 'package:flutter/material.dart';

class ButtonWidget {

  final String text;
  final VoidCallback onClicked;
  ButtonWidget( {required this.onClicked,required this.text});
  
  Widget build(BuildContext context) =>ElevatedButton(
    child: Text(text,style: TextStyle(fontSize: 20),
    ),
    onPressed: onClicked
  );
}