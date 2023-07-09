import 'package:flutter/material.dart';
import 'package:smth/models/todo_model.dart';
import 'package:smth/page/todo_list_page/todo_list_model.dart';

class ToDoListWidgetModel {
  final ToDoListModel model;
  final BuildContext context;

  ToDoListWidgetModel({required this.model, required this.context});



  List<ToDoModel> getToDos(bool active){
    return active? model.getActive() : model.getAll();
  }

  void changeToDoState(int index){
    model.changeToDoState(index);
  }



  void deleteTodo(int index) {
    model.deleteByIndex(index);
  }
}
