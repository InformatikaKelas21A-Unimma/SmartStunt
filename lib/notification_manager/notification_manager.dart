import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NotificationManager {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('smartstunt');

    DarwinInitializationSettings initializationIos =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationIos);
    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {},
    );
  }

  Future<void> simpleNotificationShow() async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'Channel_id',
      'Channel_title',
      priority: Priority.high,
      importance: Importance.max,
      icon: 'flutter_logo',
      channelShowBadge: true,
      largeIcon: DrawableResourceAndroidBitmap('smartstunt'),
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await notificationsPlugin.show(
        0, 'Simple Notification', 'New User send message', notificationDetails);
  }

  Future<void> scheduleNotification(
      DateTime scheduledDateTime, String title, String body) async {
    tz.initializeTimeZones(); // Initialize timezone
    final String timeZoneName =
        await FlutterNativeTimezone.getLocalTimezone(); // Get local timezone
    final tz.TZDateTime scheduledTime = tz.TZDateTime.from(
      scheduledDateTime,
      tz.getLocation(timeZoneName),
    );

    final AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('channel_id', 'channel_title',
            priority: Priority.high, importance: Importance.max);

    final NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await notificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      scheduledTime,
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
