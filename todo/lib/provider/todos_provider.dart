import 'package:flutter/cupertino.dart';
import 'package:todo/model/todo_model.dart';

class TodosProvider extends ChangeNotifier {
  final List<TodoModel> _todos = [
    TodoModel(
            createdTime: DateTime(2021, 8, 19), 
            title: "Hello World", 
            description: "This is my first Todo",
            isDone: false,
        ),
    TodoModel(createdTime: DateTime(2021, 4, 4), title: "Topcoder Open", 
      description: "Topcoder SRM 619. Attempt is must and upsolving later",
      isDone: false,
    ),
     TodoModel(createdTime: DateTime(2021, 4, 4), title: "Topcoder Open", 
      description: "Topcoder SRM 619. Attempt is must and upsolving later",
      isDone: false,
    ),
     TodoModel(createdTime: DateTime(2021, 4, 4), title: "Topcoder Open", 
      description: "Topcoder SRM 619. Attempt is must and upsolving later",
      isDone: false,
    ),
  ];
   List<TodoModel> get todos => _todos.where((task) => task.isDone == false).toList();
}