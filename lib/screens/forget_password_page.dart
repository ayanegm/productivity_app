import 'package:flutter/material.dart';
import 'package:productivity_app/screens/login_page.dart';
import 'package:productivity_app/widgets/button.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 16),
        child: Column(
          children: [
            Center(child: Column(
              children: [
                Text('FocalPoint',style: TextStyle(fontSize: 60,fontWeight: FontWeight.bold),),
                Text('stay',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                Text('Focus',style: TextStyle(fontSize: 60,fontWeight: FontWeight.bold),),
                SizedBox(height:20),
            ])),
            SizedBox(height: 20,),
            // TextFieldRegiter(field_title: 'Enter new password',), //change
            SizedBox(height: 18,),
            // TextFieldRegiter(field_title: 'Re-enter new password',), //change
            SizedBox(height: 21,),
            CustomButton(text: 'Submit',onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
            return LoginPage();
          },));}), 

            ]))
    );
  }
}