import 'package:flutter/material.dart';

class selectedPeriodButton extends StatefulWidget {
   selectedPeriodButton({super.key,required this.onChanged});
final Function(String) onChanged;

  @override
  State<selectedPeriodButton> createState() => _selectedPeriodButtonState();
}

class _selectedPeriodButtonState extends State<selectedPeriodButton> {
 String selectedPeriod='AM';
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black
                ),
      child: Text(selectedPeriod,style: TextStyle(color: Colors.white),),
      onPressed: () {
        if(selectedPeriod=='AM'){
          setState(() {
            selectedPeriod = (selectedPeriod == 'AM') ? 'PM' : 'AM';
          });
          
        widget.onChanged(selectedPeriod);
        
        }
      },
    );
  }
}