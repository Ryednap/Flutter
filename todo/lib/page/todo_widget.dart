import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/model/todo_model.dart';

class TodoWidget extends StatelessWidget {
  final Todo? todo;
   const TodoWidget({ Key? key, @required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.white12,
      child: Row(
        children: [
          Checkbox(
            value: todo?.isDone, 
            onChanged: (_){},
            activeColor: Theme.of(context).primaryColor,
            checkColor: Colors.white,
          ),
          const SizedBox(width : 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  todo!.title.toString(), // assigning String? to String is an error 
                  style: const TextStyle(
                    fontSize : 18,
                    color: Colors.blueAccent,
                    fontFamily: "Times",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (todo!.description!.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top : 5),
                    child: Text(
                      todo!.description.toString(),
                      style: const TextStyle(
                        color: Colors.brown,
                        fontFamily: "Serif",
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}