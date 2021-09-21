import 'package:flutter/cupertino.dart';
import 'package:todo/model/todo_model.dart';

class TodosProvider extends ChangeNotifier {
  final List<TodoModel> _todos = [];

  // getter with filter for todos list.
  List<TodoModel> get todos =>
      _todos.where((task) => task.isDone == false).toList();

  void addTodo(TodoModel object) {
    //print("add called\n object : $object");
    _todos.add(object);
    notifyListeners();
  }
}
