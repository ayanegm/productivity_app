import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/models/user_model.dart';
import 'package:productivity_app/screens/forget_password_page.dart';
import 'package:productivity_app/screens/home_page.dart';
import 'package:productivity_app/features/auth/signup_page_logic.dart';
import 'package:productivity_app/widgets/button.dart';
import 'package:productivity_app/widgets/snackbar.dart';
import 'package:productivity_app/widgets/text_field_regiter.dart';

class LoginPage extends StatefulWidget {
   LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
final TextEditingController emailController=TextEditingController();

final TextEditingController passwordController=TextEditingController();

GlobalKey<FormState>formState=GlobalKey<FormState>();

 bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:isLoading?Center(child: CircularProgressIndicator()): Padding(
        padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 16),
        child: Form(
          key: formState,
          child: Column(
            children: [
              Center(child: Column(
                children: [
                  Text('FocalPoint',style: TextStyle(fontSize: 60,fontWeight: FontWeight.bold),),
                  Text('stay',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                  Text('Focus',style: TextStyle(fontSize: 60,fontWeight: FontWeight.bold),),
                  Text('Please log into your existing account',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                  SizedBox(height:20),
                  TextFieldRegiter(field_title: 'Your Email',controller: emailController,validator: (val) {
            if(val==''){
              return 'Can\'t to be empty';
            }
          },),
                  SizedBox(height:15 ,),
                  TextFieldRegiter(field_title: 'Your Password',controller: passwordController,validator: (val) {
            if(val==''){
              return 'Can\'t to be empty';
            }
          },),
                  SizedBox(height: 20,),
               
                  SizedBox(height: 25,),
                  CustomButton(text: 'Log in',
                  onTap: ()async{
                   
                  if(formState.currentState!.validate()){
                       try {
                        
                        setState(() {
                          isLoading=true;
                        });
                    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text
                    );
                    final doc = await FirebaseFirestore.instance
                    .collection('users')
                    .doc(credential.user!.uid)
                    .get();
                    // UserModel user=UserModel.fromMap(doc.data() as Map<String ,dynamic>);
                    if (doc.exists && doc.data() != null) {
                      UserModel user = UserModel.fromMap(doc.data() as Map<String, dynamic>);
                    if(mounted){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                     return HomePage();
                    },));
                    }
                    }else{
                      // FirebaseAuth.instance.currentUser!.sendEmailVerification();
                      CustomSnackBar.show(context,'User data not found in database.');
                    }

                  } 
                  
                  on FirebaseAuthException catch (e) {
                    String errorMessage = 'An error occurred';
                    if (e.code == 'user-not-found') {
                      errorMessage='No user found for that email.';
                    } else if (e.code == 'wrong-password') {
                      errorMessage='Wrong password provided for that user.';
                    }
                    else{
                        errorMessage = e.message ?? 'Authentication failed';    
                    }
                 CustomSnackBar.show(context, errorMessage);
      } catch (e) {
        CustomSnackBar.show(context, 'Error: ${e.toString()}');
      } finally {
        // الـ finally بتضمن إن الـ loading يقف سواء نجحنا أو فشلنا
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    } else {
      CustomSnackBar.show(context, 'Please fill in all fields correctly');
    }
                  },),
                  SizedBox(height: 7,),
                  CustomButton(text: 'Sign up',onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SignupPageLogic();
            },));}),
            SizedBox(height: 20,),
            
                ],
              )),
              
            ],
          ),
        ),
      ),
    );
  }
}