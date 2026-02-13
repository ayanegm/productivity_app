import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/screens/login_page.dart';

class VerficationPage extends StatelessWidget {
  const VerficationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          FirebaseAuth.instance.currentUser!.emailVerified?
          Text('Welcome'):
          ElevatedButton(onPressed: () {
            FirebaseAuth.instance.currentUser!.sendEmailVerification();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return LoginPage();
            },));
          }, child: Text('Verify'))
        ],
      ),
    );
  }
}