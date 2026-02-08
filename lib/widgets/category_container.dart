import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/helper/get_category_style.dart';
import 'package:productivity_app/models/task_model.dart';

class CategoryContainer extends StatelessWidget {
   CategoryContainer({super.key,required this.onTapShow,required this.name,required this.count});
   final String name;
   final int count;
   final VoidCallback onTapShow;
  @override
  Widget build(BuildContext context) {
    final String uid=FirebaseAuth.instance.currentUser!.uid;
    final style = selectedCategoryHelper.getCategoriesStyle(name);
    final String imagePath = style['image'];
    return Container(
            padding: EdgeInsets.only(left: 13),
            height: 110,width: 250,
          decoration: BoxDecoration(
            color: Color(0xFFddf6f0),
            borderRadius: BorderRadius.circular(15),
            
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                
                height: 27,
                width: 27,
                decoration: BoxDecoration(
                shape: BoxShape.circle,
                ),
                child:  Image.asset(imagePath,height: 10,width: 10,),
              ),
              SizedBox(width: 13,),
              Text('${name} Plan',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  ],
                ),
                SizedBox(height: 17,),
                Text('${count}Plans Remaining',style: TextStyle(fontSize: 12,color: Color.fromARGB(255, 103, 102, 102),fontWeight: FontWeight.bold),),
                SizedBox(height: 15,),
                InkWell(
              onTap: onTapShow,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Show',
                    style: TextStyle(
                      color: Color(0xFF2d3142),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 5),
                ],
              ),
            ),
              ],
            ),
          ),);
  }
}