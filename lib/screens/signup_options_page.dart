import 'package:flutter/material.dart';
import 'package:productivity_app/screens/login_page.dart';
import 'package:productivity_app/screens/signup_page.dart';
import 'package:productivity_app/widgets/button.dart';

class SignupOptionsPage extends StatelessWidget {
  const SignupOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
           
              Center(child: Column(
                children: [
                  Text('FocalPoint',style: TextStyle(fontSize: 60,fontWeight: FontWeight.bold),),
                  Text('stay',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                  Text('Focus',style: TextStyle(fontSize: 60,fontWeight: FontWeight.bold),),
                  SizedBox(height:20),
              ])),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account? '),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    },));
                  },
                  child: Text(
                          'Log in',
                          style: TextStyle(
                            color:  Color(0xFF4CAF50), 
                            fontSize: 16,
                            decoration: TextDecoration.underline, 
                          ),
                        ),
                ),
              ],
            ),
            SizedBox(height: 15,),
            CustomButton(text: 'Sign up with email',onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SignupPage();
              },));
            },)
          ]),
    );
  }
}