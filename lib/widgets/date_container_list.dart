import 'package:flutter/material.dart';
import 'package:productivity_app/widgets/date_container.dart';

class DateContainerList extends StatefulWidget {
  const DateContainerList({super.key, required this.onDataSelected});
final void Function(DateTime) onDataSelected;
  @override
  State<DateContainerList> createState() => _DateContainerListState();
}

class _DateContainerListState extends State<DateContainerList> {
  DateTime today = DateTime.now();
    DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
        height: 70,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          
          itemBuilder: (context, index) {
            DateTime targetDate =today.add(Duration(days: index));
            bool isSelected = targetDate.day == selectedDate.day &&
                            targetDate.month == selectedDate.month &&
                            targetDate.year == selectedDate.year;
           return GestureDetector(child: DateContainer(date:targetDate ,isSelected: isSelected,),
           onTap: () {
              setState(() {
                selectedDate=targetDate;
              });
             widget.onDataSelected(targetDate);
           },
           );
          },
          itemCount: 30,
        ),
      
    );
  }
}