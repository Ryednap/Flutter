import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/Api/firebase_api.dart';

class TodosProvider extends ChangeNotifier {
  List<TodoModel> _todos = [];

  // getter for incompleted List
  List<TodoModel> get todos =>
      _todos.where((task) => task.isDone == false).toList();

  // getter for completed list
  List<TodoModel> get completedTodos =>
      _todos.where((task) => task.isDone == true).toList();

  void addTodo(TodoModel object) => FirebaseAPI.createTodo(object);
  void setTodo(List<TodoModel> _todos) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      this._todos = _todos;
      notifyListeners();
    });
  }

  void updateTodo(TodoModel object, String title, String description) {
    object.title= title;
    object.description = description;
    FirebaseAPI.updateTodo(object);
  }

  void removeTodo(TodoModel object) {
    FirebaseAPI.deleteTodo(object);
  }

  bool? toggleTodoStatus(TodoModel object) {
    object.isDone = (object.isDone! ^ true);
    FirebaseAPI.updateTodo(object);
    return object.isDone;
  }
}
