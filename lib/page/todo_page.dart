import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  bool _deadline = false;
  DateTime? date;

  @override
  Widget build(BuildContext context) {
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
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.close,
                color: colorTheme.onBackground,
              ),
            ),
            TextButton(
                onPressed: () => (), //add wm.onSave
                child: Text(
                  "СОХРАНИТЬ",
                  style: textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w700, color: colorTheme.primary),
                ))
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
              controller: TextEditingController(),
              //TODO move to wm
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
                subtitle: date == null
                    ? null
                    : Text(
                        DateFormat.yMd().format(date!),
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
                value: _deadline,
                onChanged: (value) {
                  setState(() {
                    _deadline = value ?? false;
                    if (_deadline) {
                      //TODO pick Date
                      date = DateTime.now();
                    } else {
                      date = null;
                    }
                  });
                }),
            Divider(
              color: colorTheme.outlineVariant,
              thickness: 1,
            ),
            TextButton(
                onPressed: () => (), //TODO wm.onDelete()

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
                ))
          ],
        ),
      ),
    );
  }
}
