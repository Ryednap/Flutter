// ignore_for_file: unnecessary_this, unnecessary_new

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/provider/todos_provider.dart';

/*
  Todo Edit Page

  Expects the todoModel object that has to be edited as argument
  whose existing content is displayed in the screen which user can
  edit and after clicking on save. The new state is updated.
  Updated in the sense the old one is deleted and new one with new 
  data is added (also preserving the id the we got from firebaseAPI).


*/

class EditTodoPage extends StatefulWidget {
  final TodoModel? todo;
  const EditTodoPage({Key? key, @required this.todo}) : super(key: key);

  @override
  EditTodoPageState createState() => EditTodoPageState();
}

class EditTodoPageState extends State<EditTodoPage> {
  String? title;
  String? description;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    title = widget.todo!.title;
    description = widget.todo!.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Todo"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              buildTitle(),
              const SizedBox(height: 10),
              buildDescription(),
              const SizedBox(height: 15),
              buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTitle() {
    return TextFormField(
      initialValue: title,
      maxLines: 1,
      validator: (value) {
        if (value!.isEmpty) return 'Title empty';
        return null;
      },
      onChanged: (title) {
        this.title = title;
      },
      decoration: const InputDecoration(
        label: Text("Title", style: TextStyle()),
        labelStyle: TextStyle(
          fontFamily: "Sans",
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.indigo,
        ),
        border: UnderlineInputBorder(),
      ),
    );
  }

  Widget buildDescription() {
    return TextFormField(
      maxLines: 3,
      initialValue: description,
      onChanged: (description) {
        this.description = description;
      },
      decoration: const InputDecoration(
        label: Text("Description", style: TextStyle()),
        labelStyle: TextStyle(
          fontFamily: 'Sans',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.indigo,
        ),
        border: UnderlineInputBorder(),
      ),
    );
  }

  Widget buildSaveButton() {
    return SizedBox(
      width: 80,
      child: ElevatedButton(
        onPressed: () => addTodo(),
        child: const Text(
          "Save",
          style: TextStyle(
            fontFamily: "Consolas",
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.amber.shade400),
        ),
      ),
    );
  }

  void addTodo() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    final newTodo = new TodoModel(
      id: DateTime.now().toString(),
      createdTime: DateTime.now(),
      title: this.title,
      description: this.description,
    );
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.addTodo(newTodo);
    provider.removeTodo(widget.todo!);
    Navigator.of(context).pop();
    return;
  }
}
