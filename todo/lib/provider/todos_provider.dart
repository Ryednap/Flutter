import 'package:flutter/cupertino.dart';
import 'package:todo/model/todo_model.dart';

class TodosProvider extends ChangeNotifier {
  final List<TodoModel> _todos = [];

  // getter for incompleted List
  List<TodoModel> get todos =>
      _todos.where((task) => task.isDone == false).toList();

  // getter for completed list
  List<TodoModel> get completedTodos =>
      _todos.where((task) => task.isDone == true).toList();

  void addTodo(TodoModel object) {
    //print("add called\n object : $object");
    _todos.add(object);
    notifyListeners();
  }

  void removeTodo(TodoModel object) {
    _todos.remove(object);
    notifyListeners();
  }

  bool? toggleTodoStatus(TodoModel object) {
    final int idx = _todos.indexOf(object);
    if (_todos[idx].isDone == true) {
      _todos[idx].isDone = false;
    } else {
      _todos[idx].isDone = true;
    }
    notifyListeners();
    return _todos[idx].isDone;
  }
}
