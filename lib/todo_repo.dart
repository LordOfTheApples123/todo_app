import 'models/todo_model.dart';

class ToDoRepo{

static ToDoRepo? _singleton;

factory ToDoRepo(){
  return _singleton ??= ToDoRepo._();
}


ToDoRepo._();

//TODO: Shared Preference
  final List<ToDoModel> _todos = [];

  ToDoModel get(int index){
    return _todos[index];
  }

  List<ToDoModel> getAll(){
    return _todos;
  }

  void changeToDoState(int index){
    final check = _todos[index].done;
    _todos[index] = _todos[index].copyWith(done: !check);
  }



  void update(int index, ToDoModel toDoModel){
    _todos[index] = toDoModel;
  }

  add(ToDoModel toDoModel){
    _todos.add(toDoModel);
  }

  deleteByIndex(index){
    _todos.removeAt(index);
  }

  deleteByValue(ToDoModel toDoModel){
    _todos.remove(toDoModel);
  }
}