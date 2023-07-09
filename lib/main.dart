
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smth/app/app.dart';
import 'package:smth/page/todo_list_page/todo_list_model.dart';
import 'package:smth/page/todo_list_page/todo_list_wm.dart';
import 'package:smth/page/todo_page/todo_page_model.dart';
import 'package:smth/page/todo_page/todo_wm.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider<ToDoListWidgetModel>(
          create: (context) =>
              ToDoListWidgetModel(model: ToDoListModel(), context: context)),
      Provider<ToDoWidgetModel>(
          create: (context) =>
              ToDoWidgetModel(model: ToDoPageModel(), context: context)),
    ],
    child: const ToDoApp(),

  ));
}
