// ignore_for_file: unnecessary_this

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/page/todo_form.dart';
import 'package:todo/provider/todos_provider.dart';

class TodoDialog extends StatefulWidget {
  const TodoDialog({Key? key}) : super(key: key);

  @override
  _TodoDialogState createState() => _TodoDialogState();
}

class _TodoDialogState extends State<TodoDialog> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

/*
  Utility function to addTodo to the list in todo_provider.dart 
  - get's called on savedTodo callback
  - uses globalKey validate method to validate all form_field in descendent
  - on successfull validation adds the new todo to the TodosProvider list with use of Provider.
  - finally pop off the dialog and exit
*/
  void addTodo() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    // ignore: unnecessary_new
    final newTodo = new TodoModel(
      id: DateTime.now().toString(),
      createdTime: DateTime.now(),
      title: this.title,
      description: this.description,
    );

    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.addTodo(newTodo);
    Navigator.of(context).pop(); // pop off the current screen (context);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Add Todo',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    fontFamily: "Merriweather",
                    color: Colors.deepOrangeAccent)),
            const SizedBox(height: 7),
            TodoForm(
              onChangedTitle: (title) => setState(() => this.title = title),
              onChangedDescription: (description) =>
                  setState(() => this.description = this.description),
              onSavedTodo: () {
                addTodo();
              },
            ),
          ],
        ),
      ),
    );
  }
}
