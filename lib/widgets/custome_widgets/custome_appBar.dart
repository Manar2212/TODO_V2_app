import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/services/notification_services.dart';
import 'package:todo_app/services/theme_services.dart';
import 'package:todo_app/theme.dart';

AppBar CustomeAppBar(BuildContext context,bool isInHome){
  final TaskController _taskController = Get.put(TaskController());
  return AppBar(
    backgroundColor: context.theme.backgroundColor,
    elevation: 0,
    leading:  isInHome ? 
    IconButton(onPressed: (){
      ThemeServices().switchTheme();
      // NotifyHelper().displayNotification(title: 'Theme Changed', body: 'it works well');
      // NotifyHelper().scheduleNotification();
    }, icon: Icon(
      Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.mode_night_outlined,size: 24,
      color: Get.isDarkMode ? Colors.white : darkGreyClr,
    )
    )  
    
    : IconButton(
      icon: Icon(Icons.arrow_back_rounded,size: 24,color: primaryClr,),
      onPressed: (){
        Get.back();
      },
    ),
    actions: [
      isInHome ? IconButton(onPressed: (){
        NotifyHelper().cancelAllNotification();
        _taskController.deleteAllTasks();
      }, icon:Icon(
      Icons.cleaning_services_outlined,size: 24,
      color: Get.isDarkMode ? Colors.white : darkGreyClr, ))
      :
      Container(),
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/person.jpeg'),
            radius: 18,
          ),
          SizedBox(width: 15),
    ],
  );
}