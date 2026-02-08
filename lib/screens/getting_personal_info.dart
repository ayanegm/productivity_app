import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/models/user_model.dart';
import 'package:productivity_app/screens/home_page.dart';
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
            SizedBox(
              height: 220,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(color: Colors.amber,height: 170,width: double.infinity,),
                  Positioned(
                    top: -20,
                    right: 10,
                    child: GestureDetector(
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFFD9D9D9),
                          shape: BoxShape.circle,
                          boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        ),
                       
                        child:Icon(Icons.add_photo_alternate_outlined),
                      ),
                    )),
                  Positioned(top: 70,left: 0,right: 0,child: CircleAvatar(backgroundColor: Colors.black,radius: 95,)),
                   Positioned(
                    bottom: 100,
                    right: 0,
                    left: 120,
                    child: GestureDetector(
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFFD9D9D9),
                          shape: BoxShape.circle,
                          boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        ),
                       
                        child:Icon(Icons.add_photo_alternate_outlined),
                      ),
                    )),
                ],
              ),
            ),
            SizedBox(height: 40,),
            Padding(padding: EdgeInsetsGeometry.only(left: 7,bottom: 7),child: Text('Name',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),)),
            TextFieldRegiter(field_title: '',controller:nameController ,validator: (value) {
              if(value==null){
                return 'this field cannot be empty';
              }
            },),
            SizedBox(height: 30,),
            Padding(padding: EdgeInsetsGeometry.only(left: 7,bottom: 7),child: Text('Bio',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),)),
            TextFieldRegiter(field_title: '',controller:bioController ,validator: (value) {
              if(value==null){
                return 'this field cannot be empty';
              }
            },),
            CustomButton(text: 'Next', onTap: ()async{
              // await FirebaseFirestore.instance.collection('users').doc(uid).set({
              //   'uid':uid,
              //   'email':email,
              //   'name':nameController.text,
              //   'bio':bioController.text
              // });
              UserModel user=UserModel(uid: uid, name: nameController.text, email: email, bio: bioController.text);
              await FirebaseFirestore.instance.collection('users').doc(uid).set(user.toMap());
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return HomePage();
              },));
            },)
          ],),
        ),
      ),
    );
  }
}