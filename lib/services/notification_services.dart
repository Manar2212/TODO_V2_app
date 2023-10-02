import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:todo_app/models/task.dart';
import 'package:todo_app/views/notification_view.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:intl/intl.dart';

class NotifyHelper {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

//initialization method
  initializeNotification()async{
  tz.initializeTimeZones(); 
    //tz.setLocalLocation(tz.getLocation(timeZoneName));

//android
  final AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('appicon');

//ios
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
    onDidReceiveLocalNotification: onDidReceiveLocalNotification,
  );

  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }


Future onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Get.to(NotificationView(payload: payload!));
}

// to display notification 
displayNotification({required String title,required String body}) async {

 AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');

  DarwinNotificationDetails iosNotificationDetails =
    DarwinNotificationDetails();

 NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails,iOS: iosNotificationDetails);

  await flutterLocalNotificationsPlugin.show(
    0, title, body, notificationDetails,
    payload: 'Default_sound');
}

// to display schedule notification
  scheduledNotification(int hour, int minutes, Task task) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      task.id!,
      task.title,
      task.note,
      //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      _nextInstanceOfTenAM(hour, minutes,task.remind!,task.repeat!,task.date!),
      const NotificationDetails(
        android: AndroidNotificationDetails(
            'your channel id', 'your channel name',channelDescription: 'your channel description'),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: '${task.title}|${task.note}|${task.startTime}|',
    );
  }

//cancel notification
  cancelNotification(Task task)async{
    await flutterLocalNotificationsPlugin.cancel(task.id!);
    print('cancel notification');
  }
//cancel all notifications
  cancelAllNotification()async{
    await flutterLocalNotificationsPlugin.cancelAll();
    print('cancel all notifications');
  }


  tz.TZDateTime _nextInstanceOfTenAM(int hour, int minutes,int remind,String repeat,String date) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
    
    scheduledDate = afterRemind(remind, scheduledDate);

    var formattedDate = DateFormat.yMd().parse(date);

    if (scheduledDate.isBefore(now)) {
      if(repeat == 'Daily'){
        scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, (formattedDate.day)+1, hour, minutes);
      }if(repeat == 'Weekly'){
        scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, (formattedDate.day)+7, hour, minutes);
      }if(repeat == 'Monthly'){
        scheduledDate = tz.TZDateTime(tz.local, now.year, (formattedDate.month)+1, formattedDate.day, hour, minutes);
      }

    }
    return scheduledDate;
  }

  tz.TZDateTime afterRemind(int remind, tz.TZDateTime scheduledDate) {
    if(remind == 5){
      scheduledDate = scheduledDate.subtract(Duration(minutes:5));
    }
    if(remind == 10){
      scheduledDate = scheduledDate.subtract(Duration(minutes:10));
    }
    if(remind == 15){
      scheduledDate = scheduledDate.subtract(Duration(minutes:15));
    }
    if(remind == 20){
      scheduledDate = scheduledDate.subtract(Duration(minutes:20));
    }
    return scheduledDate;
  }

Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

//ios  
void onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) async {
  Get.dialog(Text(body!));
}
}
