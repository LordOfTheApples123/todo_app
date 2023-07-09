import 'package:flutter/material.dart';
import 'package:smth/models/todo_model.dart';
import 'package:smth/page/todo_list_page/todo_list_model.dart';

class ToDoListWidgetModel {
  final ToDoListModel model;
  final BuildContext context;

  List<ToDoModel> _allTodos = [];

  ToDoListWidgetModel({required this.model, required this.context});

  bool showDone = false;



  List<ToDoModel> getToDos(){
    _allTodos = model.getAll();
    return _allTodos;
  }

  int getDoneCount(){
    return _allTodos.where((todo) => todo.done).length;
  }



  void changeToDoState(int index){
    model.changeToDoState(index);
  }



  void deleteTodo(int index) {
    model.deleteByIndex(index);
  }
}
