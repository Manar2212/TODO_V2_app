import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/services/notification_services.dart';
import 'package:todo_app/theme.dart';
import 'package:todo_app/views/add_task_view.dart';
import 'package:todo_app/widgets/custome_widgets/customeButton.dart';

class TaskBarItem extends StatelessWidget {
  const TaskBarItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${DateFormat.yMMMEd().format(DateTime.now())}',style: subheadingStyle,),
            Text('Today',style: titleStyle,)
          ],
        ),
        CustomeButton(label: '+ Add Task', onTap: (){
          Get.to(AddTaskView());
        })
      ],
    );
  }
}