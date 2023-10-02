import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/widgets/add_task_view_body.dart';
import 'package:todo_app/widgets/custome_widgets/custome_appBar.dart';


class AddTaskView extends StatelessWidget {
  const AddTaskView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: CustomeAppBar(context,false),
      body: Container(
        padding: EdgeInsets.only(left: 16,right: 16),
        child: AddTaskViewBody()
        ),
    );
  }
}


