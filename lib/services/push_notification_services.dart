import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationServices {

  static FirebaseMessaging messaging=FirebaseMessaging.instance;
  static Future init()async{
   await messaging.requestPermission();
String? token = await messaging.getToken(
      vapidKey: "BJYOtrMMiD-L26xaYEGpsUoBKaLHI-cNc0XLt-7dFhdRVOZG19Dzvrhnd7C9G58NDHPh56Dyjmrh96opQTyt2JU",
    );
        print('token is ${token}');
    FirebaseMessaging.onBackgroundMessage(handlebackgroundMessage); //thiis for background and killed
  }
  static Future<void> handlebackgroundMessage(RemoteMessage message)async{
  await  Firebase.initializeApp();
  log(message.notification?.title ??'null');
  
  }
}