import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/models/user_model.dart';
import 'package:productivity_app/screens/home_page.dart';
import 'package:productivity_app/features/auth/login_page.dart';
import 'package:productivity_app/widgets/button.dart';
import 'package:productivity_app/widgets/text_field_regiter.dart';

class GettingPersonalInfo extends StatelessWidget {
  
final TextEditingController nameController=TextEditingController();
final TextEditingController bioController=TextEditingController();

GlobalKey<FormState> formState=GlobalKey<FormState>();
final String email;
final String uid;
 GettingPersonalInfo({super.key, required this.email, required this.uid});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal:15,vertical: 24 ),
        child: Form(
          key:formState ,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            Text('Setup your Profile',style: TextStyle(fontSize: 28,fontWeight: FontWeight.w600,color: Colors.black87),),
            SizedBox(height: 30,),
            const SizedBox(height: 8),
                const Text(
                  'Tell us a bit about yourself to get started',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 96, 96, 96)),
                ),
            const SizedBox(height: 40),
            Padding(padding: EdgeInsetsGeometry.only(left: 7,bottom: 7),child: Text('Name',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),)),
            TextFieldRegiter(field_title: 'Enter your name',controller:nameController ,validator: (value) {
              if(value==null){
                return 'this field cannot be empty';
              }
            },

            ),
            SizedBox(height: 30,),
            Padding(padding: EdgeInsetsGeometry.only(left: 7,bottom: 7),child: Text('Bio',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),)),
            TextFieldRegiter(field_title: 'I love productivity...',controller:bioController ,validator: (value) {
              if(value==null){
                return 'this field cannot be empty';
              }
            },),
            SizedBox(height: 40,),
            CustomButton(text: 'Next', onTap: ()async{
              
              UserModel user=UserModel(uid: uid, name: nameController.text, email: email, bio: bioController.text);
              await FirebaseFirestore.instance.collection('users').doc(uid).set(user.toMap());
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginPage();
              },));
            },)
          ],),
        ),
      ),
    );
  }
}