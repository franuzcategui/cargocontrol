import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/notification_model.dart';

class LocalNotificationService {
  // static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final DarwinInitializationSettings initializationSettingsDarwin =
  const DarwinInitializationSettings();

  static Future<bool> requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      '[Utils.requestPermission()] - Permission ${permission.toString()} was already granted';
      return true;
    } else {
      final result = await permission.request();
      if (result == PermissionStatus.granted) {
        '[Utils.requestPermission()] - Permission ${permission.toString()} granted!';
        return true;
      } else {
        '[Utils.requestPermission()] - Permission ${permission.toString()} denied!';
        return false;
      }
    }
  }

  static void initialize() {
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
       iOS: DarwinInitializationSettings(

       )
    );

    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static void display({
    required RemoteMessage message,
    required BuildContext context,
    required GlobalKey<NavigatorState> navigatorKey,
  }) async{

    Map<String, dynamic> notificationData = parseNotificationString(message.data['screen']);
    NotificationModel model = NotificationModel(
      notificationId: notificationData['notificationId'],
      title: notificationData['title'],
      description: notificationData['description'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(int.parse(notificationData['createdAt'])),
      screenName: notificationData['screenName'],
    );
    showNotification(model);
  }

  static void displayBackgroundNotifications({
    required RemoteMessage message,
    required BuildContext context,
    required GlobalKey<NavigatorState> navigatorKey,
  }) async{

    Map<String, dynamic> notificationData = parseNotificationString(message.data['screen']);
    NotificationModel model = NotificationModel(
        notificationId: notificationData['notificationId'],
        title: notificationData['title'],
        description: notificationData['description'],
        createdAt: DateTime.fromMillisecondsSinceEpoch(int.parse(notificationData['createdAt'])),
        screenName: notificationData['screenName'],
    );
    showNotification(model);
  }

  static showNotification(NotificationModel model)async{
    try {
      Random random = Random();
      int id = random.nextInt(1000);
      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            "mychanel",
            "my chanel",
            importance: Importance.max,
            priority: Priority.high,
          )

      );
      await _flutterLocalNotificationsPlugin.show(
        id,
        model.title,
        model.description,
        notificationDetails,
      );
    } on Exception catch (e) {
      print('Error>>>$e');
    }
  }


  static Map<String, dynamic> parseNotificationString(String notificationString) {
    List<String> keyValuePairs = notificationString
        .replaceAll('{', '')
        .replaceAll('}', '')
        .split(', ')
        .where((element) => element.isNotEmpty)
        .toList();

    Map<String, dynamic> notificationData = {};
    for (String pair in keyValuePairs) {
      List<String> parts = pair.split(': ');
      if (parts.length == 2) {
        notificationData[parts[0].trim()] = parts[1].trim();
      }
    }

    return notificationData;
  }
}