import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    await Firebase.initializeApp();

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid,);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    await firebaseMessaging.requestPermission(alert: true, badge: true, sound: true,);

    FirebaseMessaging.onMessage.listen(_handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    _getToken();
  }

  void _handleMessage(RemoteMessage message) {
    if (message.notification != null) {
      _showLocalNotification(message.notification!.title, message.notification!.body);
    }
  }

  void _handleMessageOpenedApp(RemoteMessage message) {
    debugPrint('Mensagem clicada: ${message.notification?.title}');
  }

  void _showLocalNotification(String? title, String? body) {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics,);

    flutterLocalNotificationsPlugin.show(0, title, body, platformChannelSpecifics, payload: 'item x',);
  }

  void _getToken() async {
    String? token = await firebaseMessaging.getToken();
    debugPrint("FCM Token: $token");
  }
}
