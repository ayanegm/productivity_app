import 'package:flutter/material.dart';

class TextFieldRegiter extends StatelessWidget {
   TextFieldRegiter({super.key,required this.field_title,required this.controller,required this.validator});
String field_title;
TextEditingController controller;
String? Function(String?)?validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator:validator,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                focusColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color.fromARGB(255, 101, 101, 101), width: 1,),
                  borderRadius: BorderRadius.circular(15),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color.fromARGB(255, 197, 197, 197), width: 1.0),
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color.fromARGB(255, 197, 197, 197), width: 1.0),
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: field_title,
                hintStyle: const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),
              ),
            );
  }
}