import 'package:flutter/cupertino.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/page/todo_widget.dart';

class TodoWrapper extends StatelessWidget {
  const TodoWrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TodoWidget(
        todo: Todo(
            createdTime: DateTime(2021, 8, 19), 
            title: "Hello World", 
            description: "This is my first Todo",
            isDone: false,
        ),
    );
  }
}