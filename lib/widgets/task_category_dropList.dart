import 'package:flutter/material.dart';

class TaskCategoryDroplist extends StatefulWidget {
  const TaskCategoryDroplist({super.key,required this.onChanged});
final void Function(String?) onChanged;
  @override
  State<TaskCategoryDroplist> createState() => _TaskCategoryDroplistState();
}

class _TaskCategoryDroplistState extends State<TaskCategoryDroplist> {
  final items =['Design','Development','Education','Meeting','Fitness','Meditation','Relaxing time','work','Coding'];
  String? value;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 17,),
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
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          icon: const Icon(Icons.arrow_drop_down),
          items: items.map(buildMenuItem).toList(),
          isExpanded: true,
          value: value,
          onChanged: (newValue) {
            setState(() {
              value = newValue; // تحديث القيمة داخلياً لتغيير النص المختار
            });
            widget.onChanged(newValue); 
          },
        ),
      ),
    );
  }
  DropdownMenuItem<String> buildMenuItem(String item) =>
  DropdownMenuItem(value:item,
  child: Text(item,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),), );
}