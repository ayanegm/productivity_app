import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotification {
  //create instance of firebase messaging
  final firebaseMessaging=FirebaseMessaging.instance;
  //functionn to initalize notification
  Future<void> initNotification()async{
    await firebaseMessaging.requestPermission();
    String? token =await firebaseMessaging.getToken();
    print('the token is ${token}');
  }
  //handle notifiation
  //handle notification if the app is terminated
}