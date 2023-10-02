import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/services/notification_services.dart';
import 'package:todo_app/theme.dart';
import '../controllers/task_controller.dart';

class BottomSheetBody extends StatelessWidget {
   BottomSheetBody({super.key,required this.task});
final Task task;
final TaskController _taskController = Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: task.isCompleted == 0 ? 50*4.5 : 50*3.5,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Get.isDarkMode ? darkHeaderClr : Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end
            ,children: [
              buildBottomSheet(label: 'Cancel', onTap: (){
              Get.back();
            }),
            buildBottomSheet(label: 'delete task', onTap: (){
              NotifyHelper().cancelNotification(task);
              _taskController.deleteTasks(task: task);
              Get.back();
            }),
            task.isCompleted == 1 ? 
            SizedBox(height: 0):
            buildBottomSheet(label: 'Task Completed', onTap: (){
              NotifyHelper().cancelNotification(task);
              _taskController.markTaskCompleted(id: task.id!);
              Get.back();
            }),
          ],),
        ),
      );
  }

  buildBottomSheet({required String label,required Function()onTap}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: primaryClr,
        ),
        child: Center(child: Text(label,style: titleStyle.copyWith(color: Colors.white),),),
      ),
    );
  }
}