import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/services/notification_services.dart';
import 'package:todo_app/size_config.dart';
import 'package:todo_app/theme.dart';
import 'package:todo_app/widgets/bottomSheet_body.dart';
import 'package:todo_app/widgets/svg_picture.dart';
import 'package:todo_app/widgets/taskBar_item.dart';
import'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/widgets/task_tile.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  DateTime selectedDate = DateTime.now();
  final TaskController _taskController = Get.put(TaskController());

  @override
  void initState() {
    _taskController.getTasks();
    super.initState();
  }
   Future<void>_onRefresh()async{
   await _taskController.getTasks();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          TaskBarItem(),
          SizedBox(height: 10,),
          _dateBar(),
          SizedBox(height: 10,),
          Expanded(
            child: Obx(
              () {
                if(_taskController.tasksList.isEmpty){
                  return RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: SVGPicture());
                }else{
                  return RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context,index){
                      var task = _taskController.tasksList[index];
                            
                    if(task.repeat == 'Daily'|| task.date == DateFormat.yMd().format(selectedDate)
                    || (task.repeat == 'Weekly' && selectedDate.difference(DateFormat.yMd().parse(task.date!)).inDays %7 ==0  )
                    || (task.repeat == 'Monthly' && selectedDate.day ==  DateFormat.yMd().parse(task.date!).day )
                    ){
                      var hour = task.startTime.toString().split(':')[0];
                      var minutes = task.startTime.toString().split(':')[1];
                              
                      var date = DateFormat.jm().parse(task.startTime!);
                      var myTime = DateFormat('HH:mm').format(date);
                              
                      NotifyHelper().scheduledNotification(
                    int.parse(myTime.toString().split(':')[0])
                    , int.parse(myTime.toString().split(':')[1])
                    , task);
                      return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 1375),
                    child: SlideAnimation(
                    horizontalOffset: 300,
                    child: FadeInAnimation(
                      child: GestureDetector(
                        onTap: (){
                         Get.bottomSheet(BottomSheetBody(task: task));
                        },
                        child: TaskTile(task)),
                    ),
                                  ),
                                );
                    }else{
                      return SizedBox(height: 0,);
                    }
                        }, 
                    separatorBuilder: (context,index){
                      return const SizedBox(height: 10);
                        },
                    itemCount: _taskController.tasksList.length),
                  );
                }
              },
              
            ))
        ],
      ),
    );
  }
  _dateBar(){
    return  Container(
      height: 100,
      width: double.infinity,
      child: DatePicker(
        DateTime.now(),
        width: 70,
        height: 100,
        initialSelectedDate: DateTime.now(),
        selectedTextColor: Colors.white,
        selectionColor: primaryClr,
        onDateChange: (newDate){
          setState(() {
            selectedDate = newDate;
          });
        },
        dateTextStyle: GoogleFonts.lato(
          color: Colors.grey,
        ),
        dayTextStyle: GoogleFonts.lato(
          color: Colors.grey,
        ),
        monthTextStyle: GoogleFonts.lato(
          color: Colors.grey,
        ),
      ),
    );
  }
 
}







