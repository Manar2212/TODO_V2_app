import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../models/task.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tablesName = 'tasks';


//initialization
  static Future<void> initDb()async{
    if(_db != null){
      debugPrint('not null db');
      return;
    }else{
      try{
        String databasesPath = await getDatabasesPath() + 'task.db';
        _db = await openDatabase(databasesPath,
        version:_version ,
        onCreate: ((Database db, int version) async{
          await db.execute(
      'CREATE TABLE $_tablesName('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
      'title STRING, note TEXT, date STRING, '
      'startTime STRING, endTime STRING, '
      'remind INTEGER, repeat INTEGER, '
      'color INTEGER, '
      'isCompleted INTEGER)'
      );
        })
        );
        debugPrint('Database Created Successfully');
      }catch(e){
        print(e.toString());
      }
    }
  }

// insert to database
static Future<int> insert(Task task)async{
  debugPrint('insert to database');
  return await _db!.insert(_tablesName,task.toJson());
}

//delete
static Future<int> delete(Task task)async{
  print('delete');
  return await _db!.delete(_tablesName,where: 'id = ?',whereArgs: [task.id]);
}

//delete all
static  deleteAll()async{
  print('delete all');
  return await _db!.delete(_tablesName);
}

//update
static Future<int> update(int id)async{
  print('update');
  return await _db!.rawUpdate(
    '''
    UPDATE tasks
    SET isCompleted = ? 
    WHERE id = ?
    '''
  ,[1,id]);
}

//query
static Future<List<Map<String, dynamic>>> query()async{
  print('query');
  return await _db!.query(_tablesName);
}
}
