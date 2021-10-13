import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:todo/Api/firebase_api.dart';
import 'package:todo/Widgets/todo_dialog.dart';
import "package:todo/main.dart";
import 'package:todo/model/todo_model.dart';
import 'package:todo/page/completed_page.dart';
import 'package:todo/page/todo_wrapper.dart';
import 'package:todo/provider/todos_provider.dart';

/*
  Home Page


  Home Page or the main driver of the entire application
  It is build on basic [Scaffold Widget] with floating 
  Action Button and Bottom Nav. On the Main screen
  one of the two possible ([todoList or comptedPage]) is 
  displayed based on what user has currently selected on 
  Bottom Nav.

  Before building the screen, the main body is wrapped in 
  StreamBuilder which get's stream data from FirebaseAPI class
  and set's the data instance in Provider Class, and then 
  the main page is build to render the data got from API

  FloatingAction Button defines an AlertDialog which is 
  used to create new Todo (builds from [TodoDialog] widget)

*/

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: non_constant_identifier_names
  int _select_index = 0;
  List<Widget> tabs = <Widget>[
    const TodoWrapper(),
    const CompletedPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(MyApp.title),
        centerTitle: true,
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.fact_check_outlined), label: "Todos"),
          BottomNavigationBarItem(icon: Icon(Icons.check), label: "Completed"),
        ],
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        currentIndex: _select_index,
        onTap: (index) => {
          //  print ("pressed $index"),
          setState(() {
            _select_index = index;
          }),
        },
      ),

      body: StreamBuilder<List<TodoModel>>(
        stream: FirebaseAPI.readTodos(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went Wrong contact the developer");
          } else if (snapshot.hasData) {
            final List<TodoModel> todos = snapshot.data!;
            final provider = Provider.of<TodosProvider>(context);
            provider.setTodo(todos);
            return tabs[_select_index];
          }
          AssertionError("case error StreamBuilder");
          return const Text("Some Error");
        },
      ), // body

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return const TodoDialog();
          },
        ),
      ),
    );
  }
}
