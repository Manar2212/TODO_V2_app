import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/views/notification_view.dart';
import 'package:todo_app/services/theme_services.dart';
import 'package:todo_app/size_config.dart';
import 'package:todo_app/widgets/custome_widgets/customeButton.dart';
import 'package:todo_app/widgets/custome_widgets/custome_appBar.dart';
import 'package:todo_app/widgets/custome_widgets/customrTextField.dart';
import 'package:todo_app/widgets/home_view_body.dart';
import 'add_task_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: CustomeAppBar(context, true),
      body: HomeViewBody()
    );
  }
}
