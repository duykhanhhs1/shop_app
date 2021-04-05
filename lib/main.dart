import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/theme/app_theme.dart';

import 'app/routes/app_pages.dart';

/*const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


/*  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);*/

  ///Background Notification
  // Future<void> _firebaseMessagingBackgroundHandler(
  //     RemoteMessage message) async {
  //   print("Handling a background message: ${message.messageId}");
  // }

//  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  //await FirebaseMessaging.instance.getToken();

/*
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    Map<String, dynamic> data = message.data;
    if (message.notification != null) {
      RemoteNotification remoteNotification = message.notification;
      Get.dialog(AlertDialog(
        title: Column(
          children: [
            Text(remoteNotification.title),
          ],
        ),
        content: Column(
          children: [
            Text(remoteNotification.body),
          ],
        ),
        actions: [
          RoundedButton(
            textContent: 'Close',
            onPressed: () {},
          )
        ],
      ));
    }
*/
/*    RemoteNotification notification = message.notification;
    AndroidNotification android = message.notification?.android;
    if (notification != null && android != null) {
      print(notification.title);
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ));
    }*/ /*

  });
*/

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: appThemeData,
      defaultTransition: Transition.fadeIn,
    ),
  );
}
