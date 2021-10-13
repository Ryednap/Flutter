import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/Api/firebase_api.dart';


/*
  TodosProvier Class

  Provides local instance of storage for the todo's list in the widget tree.
  The instance get's loaded in the main class and is referred only for getting 
  and setting data (Basic Provider functionality)

  Also provides an interface for direct API communication i.e fetching and 
  updating data.

*/


class TodosProvider extends ChangeNotifier {
  List<TodoModel> _todos = [];

  // getter for incompleted List
  List<TodoModel> get todos =>
      _todos.where((task) => task.isDone == false).toList();

  // getter for completed list
  List<TodoModel> get completedTodos =>
      _todos.where((task) => task.isDone == true).toList();

// add a Todo to the already existing list
  void addTodo(TodoModel object) => FirebaseAPI.createTodo(object);

// Set the todos list got from API to the local data _todos[] list
  void setTodo(List<TodoModel> _todos) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      this._todos = _todos;
      notifyListeners();
    });
  }

// update function
  void updateTodo(TodoModel object, String title, String description) {
    object.title = title;
    object.description = description;
    FirebaseAPI.updateTodo(object);
  }

// deleteion function
  void removeTodo(TodoModel object) {
    FirebaseAPI.deleteTodo(object);
  }

// toggle the status and update
  bool? toggleTodoStatus(TodoModel object) {
    object.isDone = (object.isDone! ^ true);
    FirebaseAPI.updateTodo(object);
    return object.isDone;
  }
}
