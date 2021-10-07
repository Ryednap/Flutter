// ignore_for_file: avoid_print

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/model/todo_model.dart';

class FirebaseAPI {
  static Future<String> createTodo(TodoModel? todo) async {
    final FirebaseFirestore? _firestore = FirebaseFirestore.instance;
    dynamic todosDoc = _firestore!.collection('todos').doc();
    todo!.id = todosDoc.id;
    try {
      await todosDoc.set(todo.toJson());
    } catch (e) {
      print("Exception!!!!! $e");
    }
    return todosDoc.id;
  }

  static Stream<List<TodoModel>> readTodos() {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final StreamController<List<TodoModel>> controller =
        StreamController<List<TodoModel>>();
    Stream<QuerySnapshot> stream = _firestore.collection('todos').snapshots();
    List<TodoModel> todos = [];
    stream.listen((event) {
      todos.clear();
      for (var element in event.docs) {
        dynamic data = element.data();
        todos.add(TodoModel.fromJson(data));
      }
    });
    controller.add(todos);
    return controller.stream;
  }

// Infact this function is never used
// Because in edit todo_page we are removing the old one and adding the new one.
  static Future<String> updateTodo(TodoModel? todo) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final doc = _firestore.collection('todos').doc(todo?.id);
	 await doc.update(todo!.toJson());
	 return doc.id;
  }

  // static Future<String> deleteTodo(TodoModel? todo) async {} */
}
