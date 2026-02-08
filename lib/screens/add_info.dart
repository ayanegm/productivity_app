import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/widgets/button.dart';

class AddInfo extends StatefulWidget {
  @override
  State<AddInfo> createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
CollectionReference users = FirebaseFirestore.instance.collection('users');
    Future<void> addUser() {
      
      return users
          .add({
            'name':'ahmed','id':FirebaseAuth.instance.currentUser!.uid
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    List <QueryDocumentSnapshot>data=[];
bool isLoading=true;
    getData()async{
    QuerySnapshot querySnapshot=  await FirebaseFirestore.instance.collection('users').where('id',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
      data.addAll(querySnapshot.docs);
      isLoading=false;
      setState(() {
        
      });
    }

    @override
    void initState(){
      getData();
      super.initState();
      
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading? CircularProgressIndicator():Column(
        children: [
          CustomButton(text: 'add', onTap:addUser),
          // Container(
          //   height:100,
          //   width: 400,
          //   child: ListView.builder(itemCount: data.length,itemBuilder: (context, index) {
          //   return  InkWell(
          //     onDoubleTap: ()async {
          //       await FirebaseFirestore.instance.collection('users').doc(data[index].id).delete();
          //       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
          //         // return HomePage();
          //       },),(route) => false,);
          //     },
          //     child: Text("${data[index]['name']}"));
          //   },),
          // )
        ],
      ),
    );
  }
}