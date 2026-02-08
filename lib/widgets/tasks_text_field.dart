import 'package:flutter/material.dart';

class TasksTextField extends StatelessWidget {
   TasksTextField({super.key, required this.hintText,required this.controller, this.validator,this.onTap,this.readOnly=false});
  final String hintText;
  TextEditingController controller;
  String? Function(String?)?validator;
  final bool readOnly;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: const Border(
          top: BorderSide(color: Colors.black, width: 1.5),
          left: BorderSide(color: Colors.black, width: 1.5),
          right: BorderSide(color: Colors.black, width: 1.5),
          bottom: BorderSide(color: Colors.black, width: 4.5), 
        ),
      ),
     
     child: TextFormField(
      readOnly: readOnly,
      onTap: onTap,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color.fromARGB(255, 145, 145, 145),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
     )
    );
  }
}