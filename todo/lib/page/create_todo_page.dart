import 'package:flutter/material.dart';
import 'package:todo/model/todo_model.dart';

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
            padding: const EdgeInsets.all(10.0),
            child: Form(
              child: Column(
                children: <Widget>[
                  buildTitle(),
                  const SizedBox(height: 10),
                  buildDescription(),
                  const SizedBox(height: 12),
                  buildSaveButton(),
                ],
              ),
            )));
  }

  Widget buildTitle() {
    return TextFormField(
        initialValue: title,
        maxLines: 1,
        validator: (value) {},
        onSaved: (value) {},
        decoration: const InputDecoration(
          label: Text("Title", style: TextStyle()),
        ));
  }

  Widget buildDescription() {
    return TextFormField(
      initialValue: description,
    );
  }

  Widget buildSaveButton() {
    return ElevatedButton(onPressed: () {}, child: const Text("Save"));
  }
}
