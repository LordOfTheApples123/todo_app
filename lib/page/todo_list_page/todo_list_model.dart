import 'package:smth/models/todo_model.dart';
import 'package:smth/todo_repo.dart';

class ToDoListModel{

final ToDoRepo repo = ToDoRepo();

//класс получился крайне бесполезным,
// потому что все запросы в repo довольно простые,
// но соблюли MVVM

  List<ToDoModel> getAll(){
    return repo.getAll();
  }

  List<ToDoModel> getActive(){
    return getAll().where((todo) => !todo.done).toList();
  }

  add(ToDoModel toDoModel){
    repo.add(toDoModel);
  }

  deleteByIndex(int index){
    repo.deleteByIndex(index);
  }

  deleteByValue(ToDoModel toDoModel){
    repo.deleteByValue(toDoModel);
  }

  changeToDoState(int index){
    repo.changeToDoState(index);
  }


}