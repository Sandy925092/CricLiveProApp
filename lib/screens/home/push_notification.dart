import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';

//final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class FirebaseNotifications {
  String notificationValue = "";

  Future<void> setupInteractedMessage() async {
    await Firebase.initializeApp();
    await FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.onMessageOpenedApp
        .listen((RemoteMessage? remoteMessage) async {
      print("remoteeeeeeeeeeeee");

        // navigatorKey.currentState!.push(
        //   MaterialPageRoute(
        //     builder: (context) => Notifications(isFireBaseNotification: true,),
        //   ),
        // );
    });

    await _enableIOSNotifications();
    await _registerNotificationListeners();
  }

  _enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
  }

  androidNotificationChannel() => const AndroidNotificationChannel(
      'high_importance_channel', 'High Importance Notifications',
      importance: Importance.high);

  _registerNotificationListeners() async {
    print("enter listener");
    AndroidNotificationChannel channel = androidNotificationChannel();

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .getNotificationAppLaunchDetails()
        .then((notificationAppLaunchDetail) {
      // log("@@ = ${notificationAppLaunchDetail?.payload}" ?? '');
    });

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    var androidSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var iOSSettings = const DarwinInitializationSettings(
        requestSoundPermission: true,
        requestAlertPermission: true,
        requestBadgePermission: true);

    var initSettings =
        InitializationSettings(android: androidSettings, iOS: iOSSettings);

    flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onDidReceiveNotificationResponse: (message) async {


      // navigatorKey.currentState!.push(
      //   MaterialPageRoute(
      //     builder: (context) => Notifications(isFireBaseNotification: true,),
      //   ),
      // );
    });

    /** called when app is in foreground state */

    FirebaseMessaging.onMessage.listen((remoteMessage) {
      RemoteNotification? remoteNotification = remoteMessage.notification;
      AndroidNotification? androidNotification =
          remoteMessage.notification?.android;
      AppleNotification? appleNotification = remoteMessage.notification?.apple;


      if (remoteNotification != null && androidNotification != null) {
        flutterLocalNotificationsPlugin.show(
            remoteNotification.hashCode,
            remoteNotification.title,
            remoteNotification.body,
            payload: "${jsonEncode(remoteMessage.data)}",
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    icon: androidNotification.smallIcon,
                    playSound: true,
                    importance: Importance.high),
                iOS: const DarwinNotificationDetails(
                  presentAlert: true,
                  presentBadge: true,
                  presentSound: true,
                )));
      }
    });
  }
}
