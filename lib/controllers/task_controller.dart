import 'package:get/get.dart';
import 'package:todo_app/db/db_helper.dart';
import 'package:todo_app/models/task.dart';
import 'package:intl/intl.dart';
class TaskController extends GetxController{
  final RxList<Task> tasksList = <Task>[].obs;


   Future<void> getTasks()async{
    final List<Map<String, dynamic>> tasks = await DBHelper.query();
    tasksList.assignAll(tasks.map((e) => Task.fromJson(e)).toList());
  }

   addTask({required Task task})async{
    await DBHelper.insert(task);
    await getTasks();
  }

  void deleteTasks({required Task task})async{
    await DBHelper.delete(task);
    await getTasks();
  }

  void markTaskCompleted({required int id})async{
    await DBHelper.update(id);
    await getTasks();
  }

  void deleteAllTasks()async{
    await DBHelper.deleteAll();
    await getTasks();
  }

}
