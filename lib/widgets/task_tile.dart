import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/theme.dart';

class TaskTile extends StatelessWidget {
  const TaskTile(this.task,{Key? key}) : super(key: key);
final Task task;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: _getColor(task.color),
      ),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(task.title!,
              style: GoogleFonts.lato(
                  textStyle: const TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white)
                ),
              ),
              const SizedBox(height: 12,),
              Row(children: [
                Icon(Icons.access_time_rounded,color: Colors.grey[200],size: 18,),
                const SizedBox(width: 12,),
                Text('${task.startTime} - ${task.endTime}',
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                  fontSize: 13,
                  color: Colors.white)
                ),
                ),
              ],),
              const SizedBox(height: 12,),
              Text(task.note!,
              style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.white)
                ),
              ),
            ]),
          )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 0.5,
            color: Colors.grey[200]!.withOpacity(0.7),
          ),
          RotatedBox(quarterTurns: 3,child: Text(task.isCompleted == 0 ? 'TODO':'Completed',
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
            fontSize: 12,
            color: Colors.white)
          ),
          ),)
        ],
      ),
    );
  }
  
  _getColor(int? color) {
    switch (color){
      case 0:
        return bluishClr;
      case 1:
        return orangeClr;
      case 2:
        return pinkClr;
      default :
        return bluishClr;
    }
  }
}
