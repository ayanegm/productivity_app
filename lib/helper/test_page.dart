import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
 getToken() async {
  try {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // 3. جلب التوكن باستخدام الـ VAPID Key الذي استخرجتيه
      String? myToken = await messaging.getToken(
        vapidKey: "BJYOtrMMiD-L26xaYEGpsUoBKaLHI-cNc0XLt-7dFhdRVOZG19Dzvrhnd7C9G58NDHPh56Dyjmrh96opQTyt2JU", 
      );

      print('=============================');
      print('the token is: $myToken');
    } else {
      print('User declined or has not accepted permission');
    }
  } catch (e) {
    // طباعة الخطأ في حال حدوث مشكلة في الاتصال بالـ Server
    print('Error fetching token: $e');
  }
}

  @override
  void initState(){
    getToken();
    super.initState();
  }
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}