// ignore_for_file: depend_on_referenced_packages, body_might_complete_normally_nullable, prefer_const_constructors

//Librerias de flutter
import 'dart:ffi';
import 'package:flutter/material.dart';

//Servicios
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService{

  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService(){
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationService._internal();
  Future<Void?> initNotification() async{

    final AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/launcher_icon');


    final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  }

  Future<Void?> showNotification(int id, String title, String body) async{
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'main_channel',
          'Main Channel',
          channelDescription: 'Main channel notifications',
          importance: Importance.max,
          priority: Priority.max,
          icon: '@mipmap/launcher_icon'

        ),
      ),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  Future<Void?> imageNotification(int id, String title, String body) async{
    var bigPicture = const BigPictureStyleInformation(
      DrawableResourceAndroidBitmap("@mipmap/launcher_icon"),
      largeIcon: DrawableResourceAndroidBitmap("@mipmap/launcher_icon"),
      contentTitle: "Demo image notification",
      summaryText: "this is some text",
      htmlFormatContent: true,
      htmlFormatContentTitle: true
    );
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'main_channel',
          'Main Channel',
          channelDescription: 'Main channel notifications',
          styleInformation: bigPicture,
          importance: Importance.max,
          priority: Priority.max,
          icon: '@mipmap/launcher_icon'
        ),
      ),
    );
  }


  Future<Void?> stylishNotification(int id, String title, String body) async{

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'main_channel',
          'Main Channel',
          channelDescription: 'Main channel notifications',
          color: Color.fromARGB(255, 42, 146, 39),
          largeIcon: DrawableResourceAndroidBitmap("@mipmap/launcher_icon"),
          styleInformation: MediaStyleInformation(htmlFormatContent: true, htmlFormatTitle: true),
          importance: Importance.max,
          priority: Priority.max,
          icon: '@mipmap/launcher_icon'
        ),
      ),
    );
  }

}