import "package:flutter/material.dart";

class TodoForm extends StatelessWidget {
  final String title;
  final String description;
  final ValueChanged<String>? onChangedTitle;
  final ValueChanged<String>? onChangedDescription;
  final VoidCallback? onSavedTodo;
  const TodoForm(
      {Key? key,
      @required this.onChangedTitle,
      @required this.onChangedDescription,
      @required this.onSavedTodo,
      this.title = '',
      this.description = ''})
      : super(key: key);

  Widget buildTitle() {
    return TextFormField(
      maxLines: 1,
      initialValue: title,
      onChanged: onChangedTitle,
      validator: (title) {
        if (title!.isEmpty) return 'Title should not be empty';
        return null; // successful case
      },
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Title',
        labelStyle:
            TextStyle(fontSize: 14, fontFamily: 'Sans', color: Colors.indigo),
      ),
    );
  }

  Widget buildDescription() {
    return TextFormField(
      maxLines: null,
      initialValue: description,
      onChanged: onChangedDescription,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Description',
        labelStyle:
            TextStyle(fontSize: 14, fontFamily: 'Sans', color: Colors.indigo),
      ),
    );
  }

  Widget saveButton() {
    return SizedBox(
      width: 100,
      child: ElevatedButton(
          onPressed: onSavedTodo,
          child: const Text(
            "Save",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Consolas",
              fontStyle: FontStyle.italic,
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.amber.shade700),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildTitle(),
          const SizedBox(height: 10),
          buildDescription(),
          const SizedBox(height: 10),
          saveButton(),
        ],
      ),
    );
  }
}
