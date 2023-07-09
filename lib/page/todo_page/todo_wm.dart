import 'package:flutter/material.dart';
import 'package:smth/models/todo_model.dart';
import 'package:smth/page/todo_page/todo_page_model.dart';

class ToDoWidgetModel{
  final ToDoPageModel model;

  final BuildContext context;

  ToDoWidgetModel({required this.model, required this.context});

  String? currText;
  bool? deadline;
  DateTime? date;


  void save(ToDoModel toDoModel){
    model.add(toDoModel);
  }

  void saveCurrText(String text){
    currText = text;
  }

  void update(int index, ToDoModel toDoModel){
    model.update(index, toDoModel);
  }

  void delete(int index){
    model.deleteByIndex(index);
  }

  ToDoModel get(int index) {
    return model.get(index);
  }

  onDelete(int index) {
    model.deleteByIndex(index);
  }

  void onUpdate(int index) {
    model.update(index, ToDoModel(text: currText ?? "", date: date));
  }

  void onCreate() {
    model.add(ToDoModel(text: currText ?? "", date: date));
  }



}