import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationsService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  ///create channel
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'ruimy_channel', // id
    'Ruimy Channel', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  Future<void> initialize() async {
    _initSetting();
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  /* ===================================== Show notification ===================================== */
  void showNotification(RemoteMessage remoteMessage, AndroidNotification? android) async {
    RemoteNotification? notification = remoteMessage.notification;
    print('LOCAL NOTIFICATION :: $notification');

    if (notification != null && android != null) {
      AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      );
      NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
      await _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        notificationDetails,
        payload: 'item x',
      );
    }
  }

  /* ===================================== Remove notification ===================================== */
  Future removeNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  /* ============================= Initialize Settings for android and ios ============================= */
  void _initSetting() async {
    /// init plugin ...
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// android
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    /// darwin/IOS
    const DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
      defaultPresentSound: true,
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    /// InitializationSettings for Android/IOS
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

/* ===================================== On select notification ===================================== */
  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    print('onDidReceiveNotificationResponse called');
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
    // );
  }
}
