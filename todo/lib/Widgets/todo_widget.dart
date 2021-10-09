import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/page/edit_todo_page.dart';
import 'package:todo/provider/todos_provider.dart';

class TodoWidget extends StatelessWidget {
  final TodoModel? todo;
  const TodoWidget({Key? key, @required this.todo}) : super(key: key);
  static const List<int> colorIndex = [0, 1, 2, 4, 5, 6, 9, 10, 11, 12, 13];

/*
  Builds the title Widget for each single 
  Todo Instance. The title widget is put in 
  column with description Widget and both are
  in turn put in row with Checkbox. Finally 
  a Container Wrapper is provided to add 
  padding and bcgColor.
*/

  // Titlte Widget
  Widget titleWidget() {
    return Text(
      todo!.title.toString(), // assigning String? to String is an error
      style: const TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontFamily: "Times",
        fontWeight: FontWeight.w600,
      ),
    );
  }

  // Description Widget.
  Widget descriptionWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Text(
        todo!.description.toString(),
        style: const TextStyle(
          color: Colors.blueGrey,
          fontFamily: "Serif",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

// Utility Function to create Snackbar
  SnackBar createSnackBar(String content) {
    return SnackBar(
      content: Text(
        content,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: Colors.amberAccent.shade100,
    );
  }

  void deleteTodo(BuildContext context, TodoModel todo) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removeTodo(todo);
    ScaffoldMessenger.of(context).showSnackBar(createSnackBar("Deleted Todos"));
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Slidable(
        actionPane: const SlidableDrawerActionPane(),
        key: Key(todo!.id.toString()),
        actions: <Widget>[
          IconSlideAction(
            icon: Icons.edit,
            color: Colors.green,
            caption: "edit",
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditTodoPage(todo: todo)));
            },
          )
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            icon: Icons.delete,
            color: Colors.red,
            caption: "delete",
            onTap: () => deleteTodo(context, todo!),
          )
        ],
        child: Container(
          padding: const EdgeInsets.all(10.0),
          color: Colors.primaries[todo!.colorIndex!.toInt()].shade50,
          child: Row(
            children: [
              Checkbox(
                value: todo?.isDone,
                onChanged: (_) {
                  final provider =
                      Provider.of<TodosProvider>(context, listen: false);
                  final isDone = provider.toggleTodoStatus(todo!);
                  ScaffoldMessenger.of(context).showSnackBar(createSnackBar(
                      isDone!
                          ? "Task Complete"
                          : "Task is marked incompelete"));
                },
                activeColor: Theme.of(context).primaryColor,
                checkColor: Colors.white,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    titleWidget(),
                    if (todo!.description!.isNotEmpty) descriptionWidget(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
