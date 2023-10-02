import 'package:flutter/material.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/theme.dart';
import 'package:todo_app/widgets/color_item.dart';
import 'package:todo_app/widgets/custome_widgets/customeButton.dart';
import 'package:todo_app/widgets/custome_widgets/customrTextField.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({super.key});

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
    final TaskController _taskController = Get.put(TaskController());
  final  _titleController= TextEditingController();
  final _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = DateFormat('hh:mm a').format(DateTime.now().add(const Duration(minutes: 15))).toString();
  
  int _selectedRemind = 5;  //default value
  List<int> remindList = [5,10,15,20];
  String _selectedRepeat = 'None';  //default value
  List<String> repeatList = ['None','Daily','Weekly','Monthly'];

  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics:BouncingScrollPhysics(),
            children: [
              Text('Add Task',style: headingStyle,textAlign: TextAlign.center),
              CustomeTextField(title: 'Title', hint: 'Enter title here',controller: _titleController),
              CustomeTextField(title: 'Note', hint: 'Enter note here',controller: _noteController),
              CustomeTextField(title: 'Date', hint: DateFormat.yMd().format(_selectedDate),widget: 
              IconButton(
                icon: Icon(Icons.calendar_today_outlined,color: Colors.grey,),onPressed: (){
                  _getDateFromUser();
                },)),
              Row(children: [
                Expanded(
                  child: CustomeTextField(title: 'Start Time', hint: startTime,widget: 
                              IconButton(
                  icon: Icon(Icons.access_time_rounded,color: Colors.grey,),onPressed: (){
                    _getTimeFromUser(isStartTime: true);
                  },)),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CustomeTextField(title: 'End Time', hint: endTime,widget: 
                              IconButton(
                  icon: Icon(Icons.access_time_rounded,color: Colors.grey,),onPressed: (){
                    _getTimeFromUser(isStartTime: false);
                  },)),
                ),
              ],),
              CustomeTextField(title: 'Remind', hint: '$_selectedRemind minutes early',widget: DropdownButton(
                items:remindList.map<DropdownMenuItem<String>>((int e) => DropdownMenuItem<String>(value: e.toString(),child: Text('$e',style: TextStyle(color: Colors.white),))).toList()
              , onChanged: (String? newValue){
                setState(() {
                  _selectedRemind = int.parse(newValue!);
                });
              },
              dropdownColor: Colors.blueGrey,
              borderRadius: BorderRadius.circular(15),
              elevation: 4,
              iconEnabledColor: Colors.grey,
              iconSize: 30,
              underline: Container(height: 0,),
              ),
              ),
              CustomeTextField(title: 'Repeat', hint: '$_selectedRepeat',widget: DropdownButton(
                items:repeatList.map<DropdownMenuItem<String>>((e) => DropdownMenuItem<String>(value: e,child: Text('$e',style: TextStyle(color: Colors.white),))).toList()
              , onChanged: (String? newValue){
                setState(() {
                  _selectedRepeat = newValue!;
                });
              },
              dropdownColor: Colors.blueGrey,
              borderRadius: BorderRadius.circular(15),
              elevation: 4,
              iconEnabledColor: Colors.grey,
              iconSize: 30,
              underline: Container(height: 0,),
              ),
              )
              ,SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Color',style: titleStyle,),
                      SizedBox(height: 10,),
                      //color palette
                      SizedBox(
                        height: 20*2,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index){
                            return GestureDetector(
                              onTap: (){
                                setState(() {
                                  _selectedColor = index;
                                });
                              },
                              child: ColorItem(color: kColors[index], isSelected: _selectedColor == index));
                          }, 
                          separatorBuilder: (context,index){
                            return SizedBox(width: 5);}, 
                            itemCount: kColors.length),
                      )
                    ],
                  ),
                  CustomeButton(label: 'Create Task', onTap: (){
                    _validateDate();
                  }),
                ],
              ),
              SizedBox(height: 10,),
            ],
          );
  }

  _validateDate()async{
    if(_titleController.text.isNotEmpty && _noteController.text.isNotEmpty){
      _addTaskToDb();
      Get.back();
    }else if(_titleController.text.isEmpty || _noteController.text.isEmpty){
      Get.snackbar('required', 'all fields required',
      margin: EdgeInsets.only(bottom: 10),
      colorText: pinkClr,
      backgroundColor: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      icon: Icon(Icons.warning_amber_rounded,color: pinkClr,size: 25,)
      );
    }
  }

  _addTaskToDb()async{
    await _taskController.addTask(
      task: Task(
        title: _titleController.text,
        note: _noteController.text,
        isCompleted: 0,
        color: _selectedColor,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: startTime,
        endTime: endTime,
        remind: _selectedRemind,
        repeat: _selectedRepeat,
      )
    );
    print('raw inserted successfully');
  }

  _getDateFromUser()async{
    DateTime? pickedDate =  await showDatePicker(context: context, 
    initialDate: _selectedDate, 
    firstDate: DateTime(2015), 
    lastDate: DateTime(2050),
    );
    setState(() {
      _selectedDate = pickedDate ?? _selectedDate;
    });
  }

  _getTimeFromUser({required bool isStartTime})async{
    TimeOfDay? pickedTime = await showTimePicker(context: context
    , initialTime: isStartTime ? 
    TimeOfDay.fromDateTime(DateTime.now())
    :TimeOfDay.fromDateTime(DateTime.now().add(const Duration(minutes: 15))),
    );
    String formattedTime ;
    if(pickedTime != null){
      formattedTime = pickedTime.format(context);
    }else{
      isStartTime ? 
      formattedTime = TimeOfDay.fromDateTime(DateTime.now()).format(context)
      :
      formattedTime = TimeOfDay.fromDateTime(DateTime.now().add(const Duration(minutes: 15))).format(context);
    }
    setState(() {
      isStartTime ? 
      startTime = formattedTime
      :
      endTime = formattedTime;
    });
  }
}