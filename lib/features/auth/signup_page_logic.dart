
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/features/auth/getting_personal_info.dart';
import 'package:productivity_app/features/auth/login_page.dart';
import 'package:productivity_app/widgets/back_icon_button.dart';
import 'package:productivity_app/widgets/button.dart';
import 'package:productivity_app/widgets/custom_link.dart';
import 'package:productivity_app/widgets/snackbar.dart';
import 'package:productivity_app/widgets/text_field_regiter.dart';

class SignupPageLogic extends StatelessWidget {
final TextEditingController emailController=TextEditingController();
final TextEditingController passwordController=TextEditingController();
GlobalKey<FormState>formState=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27.0,vertical: 21),
        child: Form(
          key: formState,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(children: [
              BackIconButton(),
              SizedBox(width: 15,),
              Text('Log in',style: TextStyle(fontSize: 15),)
            ],),
            SizedBox(height: 30,),
            Center(child: Column(children: [
              Text('Create account',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 27,color: const Color.fromARGB(255, 99, 99, 99)),),
              Text('using Email',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 27,color: const Color.fromARGB(255, 99, 99, 99)),),
            ],),),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left:7.0),
              child: Text('Your Email',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,),),
            ),
            SizedBox(height: 6,),
            
            TextFieldRegiter(field_title: '',controller: emailController,validator: (val) {
              if(val==''){
                return 'Can\'t to be empty';
              }
            },),
            SizedBox(height: 13,),
            Padding(
              padding: const EdgeInsets.only(left:7.0),
              child: Text('Your Password',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,),),
            ),
            SizedBox(height: 6,),
            TextFieldRegiter(field_title: '',controller: passwordController,validator: (val) {
              if(val==''){
                return 'Can\'t to be empty';
              }
            },),
            
           
            SizedBox(height: 50,),
            Center(child: CustomButton(text: 'Create an account',onTap: ()async{
             
          
            if(formState.currentState!.validate()){
               try {
              final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: emailController.text,
                password: passwordController.text,
              );
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return GettingPersonalInfo(email: emailController.text,uid: credential.user!.uid);
              },));
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                CustomSnackBar.show(context,'The password provided is too weak.');
              } else if (e.code == 'email-already-in-use') {
               CustomSnackBar.show(context,'The account already exists for that email.');
              }
              else{
                CustomSnackBar.show(context,'Wrong email or password');
              }
            } catch (e) {
              CustomSnackBar.show(context,e.toString());
            }
            }
            else{
              CustomSnackBar.show(context,'this not valid');
            }
            },))
          ],
          
              ),
        ),
      ),
  );
}
}