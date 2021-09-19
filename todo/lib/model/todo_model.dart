


// Todo class Model for storing data that's needs to passed around
import 'package:flutter/foundation.dart';

class Todo {
  DateTime? createdTime;
  String? title;
  String? description;
  String? id;
  bool? isDone;

  Todo ({@required this.createdTime, @required this.title, 
        this.description, this.id, this.isDone});
  Todo.fromTodo(Todo other) {
    createdTime = other.createdTime;
    title = other.title;
    id = other.id;
    isDone = other.isDone;
  }
  
  
}