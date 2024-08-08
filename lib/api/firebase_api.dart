import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notifications/main.dart';
import 'package:notifications/page/notification_screen.dart';

@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await FirebaseService().initializeFirebaseApp();
  debugPrint("FIREBASE BACKGROUND HANDLER");
  debugPrint('---> A new Background event was published!');
  debugPrint(message.messageId);
  debugPrint(message.contentAvailable.toString());
  debugPrint("MESSAGE NOTIFICATION ${message.notification}");
  debugPrint("MESSAGE DATA ${message.data}");
  debugPrint("MESSAGE BODY ${message.notification?.body}");
  debugPrint("MESSAGE TITLE ${message.notification?.title}");
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.pushNamed(
      NotificationScreen.route,
      arguments: message,
    );
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    debugPrint('Token: $fCMToken');
    initPushNotifications();
  }
}
