import 'package:flutter/material.dart';
import 'package:productivity_app/widgets/back_icon_button.dart';
import 'package:productivity_app/widgets/bottom_navigator_bar.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body:Padding(
        padding: const EdgeInsets.symmetric(vertical: 13.0,horizontal: 10),
        child: Column(
          children: [
            Row(children: [
             BackIconButton(),
             SizedBox(width: 13,),
              Text('Home',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
              Spacer(),
              IconButton(onPressed: () {
                
              }, icon: Icon(Icons.more_vert))
            ],),
            SizedBox(height: 10,),
            SizedBox(
              height: 200,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(color: Colors.amber,height: 180,width: double.infinity,),
                  Positioned(top: 90,left: 0,right: 0,child: CircleAvatar(backgroundColor: Colors.black,radius: 100,))
                ],
              ),
            ),
            SizedBox(height: 97,),
            Text('Juan Dela'),
            Text('believe it!'),
          //   CustomButton(text: 'Edit Profile',onTap: () {
          //         Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return HomePage();
          // },));}), //this root need to change
          //   Text('Your Progress',style: TextStyle(fontSize: 20),),
          //   CustomButton(text: 'View History',onTap: () {
          //         Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return HomePage();
          // },));}), //this root need to change
          //   Text('My Favorites',style: TextStyle(fontSize: 20),),
          //   Center(child: Text('Usage'),),
          //   CustomButton(text: 'Log Out',onTap: () {
          //         Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return HomePage();
          // },));}), //this root need to change
            
          ],
        ),
      ),
       bottomNavigationBar: CustomBottomNavigatorBar()
    );
  }
}