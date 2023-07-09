import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smth/models/todo_model.dart';
import 'package:smth/page/todo_list_page/todo_list_widget.dart';
import 'package:smth/page/todo_page/todo_wm.dart';

class ToDoWidget extends StatefulWidget {
  final int index;
  final TextEditingController controller = TextEditingController();

  ToDoWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<ToDoWidget> createState() => _ToDoWidgetState();
}

class _ToDoWidgetState extends State<ToDoWidget> {


  @override
  Widget build(BuildContext context) {
    final ToDoWidgetModel wm = context.read();

    final ToDoModel? todo = widget.index == -1? null : wm.get(widget.index);
    debugPrint(widget.controller.value.text);
    debugPrint("${wm.currText}");
    debugPrint(todo?.text ?? "null");
    widget.controller.text = wm.currText ?? todo?.text ?? "";
    wm.date = wm.date ?? todo?.date;
    wm.deadline = wm.date != null;


    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorTheme.background,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                resetAndNavigateToMain(wm);
              },
              icon: Icon(
                Icons.close,
                color: colorTheme.onBackground,
              ),
            ),
            TextButton(
                onPressed: (){
                  wm.currText = widget.controller.value.text;
                  if(widget.index == -1){
                    wm.onCreate();
                  } else{
                    wm.onUpdate(widget.index);
                  }
                  resetAndNavigateToMain(wm);
                },
                child: Text(
                  "СОХРАНИТЬ",
                  style: textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w700, color: colorTheme.primary),
                )
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              cursorWidth: 1,
              cursorHeight: 10,
              cursorColor: colorTheme.onBackground,
              maxLines: 15,
              style: textTheme.bodyMedium,
              controller: widget.controller,
              decoration: InputDecoration(
                hintStyle:
                    textTheme.bodyMedium!.copyWith(color: colorTheme.onSurface),
                hintText: "Здесь будут мои заметки",
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: colorTheme.surface,
              ),
            ),
            //TODO change stateful widget to stl with streamBuilder from wm
            CheckboxListTile(
                title: Text(
                  "Дедлайн",
                  style: textTheme.bodyLarge,
                ),
                subtitle: wm.date == null
                    ? null
                    : Text(
                        DateFormat.yMd().format(wm.date!),
                        style: textTheme.bodyLarge,
                      ),
                activeColor: colorTheme.surface,
                checkColor: colorTheme.secondary,
                side: MaterialStateBorderSide.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return BorderSide(color: colorTheme.secondary);
                  }
                  return BorderSide(color: colorTheme.onSurface);
                }),
                fillColor: MaterialStateProperty.resolveWith((states) {
                  return colorTheme.background;
                }),
                controlAffinity: ListTileControlAffinity.trailing,
                value: wm.deadline ?? false,
                onChanged: (value) async {

                  final check = value ?? false;
                  if (check) {
                    DateTime? res = await pickDate();
                    if(res == null){
                      return;
                    }
                    wm.date = res;
                  } else {
                    wm.date = null;
                  }
                  wm.deadline = check;
                  setState(() {
                    wm.currText = widget.controller.value.text;
                  });
                }),
            Divider(
              color: colorTheme.outlineVariant,
              thickness: 1,
            ),

            Visibility(
              visible: widget.index != -1,
              child: TextButton(
                  onPressed: (){
                    wm.onDelete(widget.index);
                    resetAndNavigateToMain(wm);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete_outline_sharp,
                        color: colorTheme.error,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          "Удалить",
                          style: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: colorTheme.error),
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future<DateTime?> pickDate() async{


      final res = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate:
          DateTime.now().add(const Duration(days: 10)));
      return res;
  }

  resetAndNavigateToMain(ToDoWidgetModel wm){
    wm.date = null;
    wm.deadline = false;
    wm.currText = null;
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ToDoListWidget()));
  }
}
