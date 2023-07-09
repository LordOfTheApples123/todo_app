import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smth/page/todo_list_page/todo_list_wm.dart';
import 'package:smth/page/todo_page/todo_widget.dart';

class ToDoListWidget extends StatefulWidget {
  const ToDoListWidget({Key? key}) : super(key: key);

  @override
  State<ToDoListWidget> createState() => _ToDoListWidgetState();
}

class _ToDoListWidgetState extends State<ToDoListWidget> {
  @override
  Widget build(BuildContext context) {
    ToDoListWidgetModel wm = context.read();

    final todos = wm.getToDos();

    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorTheme.background,
        title: Text(
          "Мои дела",
          style: textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        top: false,
        child: ListView.builder(
          //shrinkWrap: true, можно было бы обернуть listview в карточку,
          //чтобы карточка сжалась до размеров контента,
          //но портит производительность
          cacheExtent: 10,
          itemCount: todos.length + 1,
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 77),
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Выполнено ${wm.getDoneCount()}",
                      style: textTheme.bodyLarge?.copyWith(
                          color: colorTheme.outlineVariant,
                          fontWeight: FontWeight.w600),
                    ),
                    InkWell(
                      child: wm.showDone
                          ? Icon(
                              Icons.visibility,
                              color: colorTheme.primary,
                            )
                          : Icon(
                              Icons.visibility_off,
                              color: colorTheme.primary,
                            ),
                      onTap: () {
                        setState(() {
                          wm.showDone = !wm.showDone;
                        });
                      },
                    )
                  ],
                ),
              );
            }

            final todosIndex = index - 1;
            final double top = todosIndex == 0 ? 20 : 0;
            final double bottom = todosIndex == todos.length - 1 ? 20 : 0;

            //если оборачивать каждый tile material/card/...,
            //то тень ломается

            return Visibility(
              visible: !todos[todosIndex].done || wm.showDone,
              child: Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  setState(() {
                    if (direction == DismissDirection.startToEnd) {
                      wm.changeToDoState(todosIndex);
                    } else {
                      wm.deleteTodo(todosIndex);
                    }
                  });
                },
                background: Container(
                  color: colorTheme.secondary,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Icon(
                          Icons.check,
                          color: colorTheme.surface,
                          size: 40,
                        ),
                      )),
                ),
                secondaryBackground: Container(
                  color: colorTheme.error,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Icon(
                        Icons.delete_outline_sharp,
                        color: colorTheme.surface,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: colorTheme.surface,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(top),
                        bottom: Radius.circular(bottom)),
                  ),
                  child: ListTile(
                    horizontalTitleGap: 0,
                    contentPadding: EdgeInsets.zero,
                    leading: Checkbox(
                      value: todos[todosIndex].done,
                      onChanged: (value) {
                        setState(() {
                          wm.changeToDoState(todosIndex);
                        });
                      },
                      activeColor: colorTheme.surface,
                      checkColor: colorTheme.secondary,
                      side: MaterialStateBorderSide.resolveWith((states) {
                        if (states.contains(MaterialState.selected)) {
                          return BorderSide(color: colorTheme.secondary);
                        }
                        return BorderSide(color: colorTheme.onSurface);
                      }),
                      fillColor: MaterialStateProperty.resolveWith((states) {
                        return colorTheme.surface;
                      }),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => (ToDoWidget(index: todosIndex))));
                    },
                    title: Text(
                      "Заметка ${todosIndex + 1}",
                      style: textTheme.bodyLarge,
                    ),
                    subtitle: todos[todosIndex].date != null
                        ? Text(
                            DateFormat.yMd().format(todos[todosIndex].date!),
                            style: textTheme.bodyMedium,
                          )
                        : null,
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: colorTheme.surface,
        backgroundColor: colorTheme.primary,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
        elevation: 0,
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => (ToDoWidget(index: -1))));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
