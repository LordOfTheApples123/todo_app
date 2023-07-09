class ToDoModel {
  final String text;
  final DateTime? date;
  final bool done;

  const ToDoModel({required this.text, this.date, this.done = false});

  ToDoModel copyWith({
    String? text,
    DateTime? date,
    bool? done,
  }) {
    return ToDoModel(
        text: text ?? this.text,
        date: date ?? this.date,
        done: done ?? this.done);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToDoModel &&
          runtimeType == other.runtimeType &&
          text == other.text &&
          date == other.date &&
          done == other.done;

  @override
  int get hashCode => text.hashCode ^ date.hashCode ^ done.hashCode;
}
