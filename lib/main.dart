import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/app/app.dart';
import 'package:productivity_app/firebase_options.dart';
import 'package:productivity_app/helper/firebase_notification.dart';
import 'package:productivity_app/helper/test_page.dart';
import 'package:productivity_app/providers/task_provider.dart';
import 'package:productivity_app/screens/login_page.dart';
import 'package:productivity_app/services/push_notification_services.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PushNotificationServices.init();
runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override 
@override 
void initState() {
  super.initState();
  
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Message received in foreground!');

    if (message.notification != null) {
      if (navigatorKey.currentContext != null) {
        showDialog(
          context: navigatorKey.currentContext!,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: Text(message.notification!.title ?? 'Notification'),
            content: Text(message.notification!.body ?? ''),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('ok'),
              ),
            ],
          ),
        );
      }
    }
  });
}
  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
    dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch, PointerDeviceKind.trackpad},
  ),
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
          home: LoginPage(),
          // home: PushNotification(),
          theme: ThemeData(
            scaffoldBackgroundColor: Color(0xFFf9f9f9),
            appBarTheme: AppBarTheme(
              backgroundColor:Color(0xFFf9f9f9) ,
              elevation: 0,
            )
          ),
    );
  }
}
