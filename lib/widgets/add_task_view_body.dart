import 'package:flutter/material.dart';
import 'package:todo_app/widgets/add_task_form.dart';

class AddTaskViewBody extends StatelessWidget {
  const AddTaskViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 16,right: 16),
        child: AddTaskForm(),
        );
  }
}