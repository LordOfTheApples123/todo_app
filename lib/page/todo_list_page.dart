import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smth/models/todo_model.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({Key? key}) : super(key: key);

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  final List<ToDoModel> _todos = [];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorTheme.background,
        title: Text(
          "Мои дела",
          style: textTheme.headlineLarge,
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
          itemCount: _todos.length,
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 77),
          itemBuilder: (BuildContext context, int index) {
            final double top = index == 0 ? 20 : 0;
            final double bottom = index == _todos.length - 1 ? 20 : 0;

            //если оборачивать каждый tile material/card/...,
            //то тень ломается

            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction){
                if(direction == DismissDirection.startToEnd){
                  //done
                } else{
                  //delete
                }
              },
              background: Container(
                color: colorTheme.secondary,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Icon(Icons.check, color: colorTheme.surface,
                      size: 40,),
                    )),
              ),
              secondaryBackground: Container(
                color: colorTheme.error,
                child: Align(
                  alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Icon(Icons.delete_outline_sharp,
                      color: colorTheme.surface,
                          size: 40,),
                    ),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: colorTheme.surface,
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(top), bottom: Radius.circular(bottom)),
                ),
                child: ListTile(
                  horizontalTitleGap: 0,
                  contentPadding: EdgeInsets.zero,
                  leading: Checkbox(
                    value: _todos[index].done,
                    onChanged: (value) {
                      final check = value ?? false;
                      setState(() {
                        _todos[index] = _todos[index].copyWith(
                          done: check,
                        );
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
                  onTap: () {},
                  title: Text(
                    _todos[index].text,
                    style: textTheme.bodyLarge,

                  ),
                  subtitle: _todos[index].date != null
                      ? Text(
                          DateFormat.yMd().format(_todos[index].date!),
                          style: textTheme.bodyMedium,
                        )
                      : null,
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
          setState(() {
            _todos.add(ToDoModel(text: "data", date: DateTime.now()));
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
