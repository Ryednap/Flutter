import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/model/todo_model.dart';

class TodoWidget extends StatelessWidget {
  final TodoModel? todo;
  const TodoWidget({Key? key, @required this.todo}) : super(key: key);

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
        fontSize: 15,
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
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
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
            onTap: () {},
          )
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            icon: Icons.delete,
            color: Colors.red,
            caption: "delete",
            onTap: () {},
          )
        ],
        child: Container(
          padding: const EdgeInsets.all(10.0),
          color: Colors
              .primaries[Random().nextInt(Colors.primaries.length)].shade50,
          child: Row(
            children: [
              Checkbox(
                value: todo?.isDone,
                onChanged: (_) {},
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
