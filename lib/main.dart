import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app/db/db_helper.dart';
import 'package:todo_app/services/notification_services.dart';
import 'package:todo_app/views/home_view.dart';
import 'package:todo_app/views/notification_view.dart';
import 'package:todo_app/services/theme_services.dart';
import 'package:todo_app/theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await NotifyHelper().initializeNotification();
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
      darkTheme: Themes.dark,
      theme: Themes.light,
      themeMode: ThemeServices().theme,
    );
  }
}

