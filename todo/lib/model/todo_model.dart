// Todo class Model for storing data that's needs to passed around
import 'package:flutter/foundation.dart';

class TodoModel {
  DateTime? createdTime;
  String? title;
  String? description;
  String? id;
  bool? isDone;

  TodoModel(
      {@required this.createdTime,
      @required this.title,
      this.description,
      this.id,
      this.isDone = false});
  TodoModel.fromTodo(TodoModel other) {
    createdTime = other.createdTime;
    title = other.title;
    id = other.id;
    isDone = other.isDone;
  }

  @override
  String toString() {
    String res = "";
    res += "id: $id \n";
    res += "createdTime : $createdTime \n";
    res += "title : $title \n";
    res += "description : $description \n";
    res += "isDone : $isDone \n";
    return res;
  }
}
