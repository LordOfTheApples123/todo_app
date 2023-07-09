import 'package:smth/models/todo_model.dart';
import 'package:smth/todo_repo.dart';

class ToDoPageModel{
  final ToDoRepo repo = ToDoRepo();





  update(int index, ToDoModel toDoModel){
    repo.update(index, toDoModel);
  }

  add(ToDoModel toDoModel){
    repo.add(toDoModel);
  }

  deleteByIndex(int index){
    repo.deleteByIndex(index);
  }

  ToDoModel get(int index) {
    return repo.get(index);
  }


}