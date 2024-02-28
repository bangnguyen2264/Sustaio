import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_2024/backgrounds/home_background.dart';
import 'package:gdsc_2024/firebase_options.dart';
import 'package:gdsc_2024/model/push_noti.dart';
import 'package:gdsc_2024/pages/collabdetails_screen.dart';
import 'package:gdsc_2024/pages/onboarding_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

// Function to listen to background changes
Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Some notification received");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //On background notification tapped
  FirebaseMessaging.onMessageOpenedApp.listen(
    (RemoteMessage message) {
      if (message.notification != null) {
        print("Background Notification Tapped");
        navigatorKey.currentState!.pushNamed("/message", arguments: message);
      }
    },
  );
  PushNotification.init();
  PushNotification.localNotiInit();

  //Listen to background notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  // to handle foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    print("Got a message in foreground");
    if (message.notification != null) {
      PushNotification.showSimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData);
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: OnboardingScreen(),
      ),
    );
  }
}
