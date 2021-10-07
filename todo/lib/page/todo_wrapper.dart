import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Widgets/todo_widget.dart';
import 'package:todo/provider/todos_provider.dart';

class TodoWrapper extends StatelessWidget {
  const TodoWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(
        context); // We want to listen for change here
    final todos = provider.todos;
    if (todos.isEmpty) {
      return const Center(
        child: Text(
          "No Todos",
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.deepPurpleAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return ListView.separated(
        padding: const EdgeInsets.all(10.0),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (content, index) {
          return TodoWidget(todo: todos[index]);
        },
        separatorBuilder: (content, index) {
          return const SizedBox(height: 12);
        },
        itemCount: todos.length,
      );
    }
  }
}
