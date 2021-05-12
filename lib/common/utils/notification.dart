import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future showNotification({String id = '0', String title, String content}) async {
  flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      id, title, content,
      importance: Importance.max, priority: Priority.high);

  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

  var platformChannelSpecifics = new NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );

  if (id.length > 9) {
    id = id.substring(id.length - 9);
  }

  int newId = int.parse(id);

  await flutterLocalNotificationsPlugin.show(
      newId, title, content, platformChannelSpecifics,
      payload: 'complete');
}
