import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/theme.dart';
import 'package:todo_app/widgets/custome_widgets/custome_appBar.dart';
import 'package:todo_app/widgets/notification_view_body.dart';

class NotificationView extends StatelessWidget {
  NotificationView({super.key,required this.payload});
  final String payload;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: CustomeAppBar(context, false),
      body: NotificationViewBody(payload: payload)
    );
  }
}
