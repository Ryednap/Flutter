import "package:flutter/material.dart";
import 'package:flutter/painting.dart';
import "package:todo/main.dart";
import 'package:todo/page/todo_form.dart';
import 'package:todo/page/todo_wrapper.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   // ignore: non_constant_identifier_names
  int _select_index = 0;
  List<Widget> tabs = <Widget>[
     const TodoWrapper(),
     Container(),
   ];

   String title = "";
   String description = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(MyApp.title),
        centerTitle: true,
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.fact_check_outlined), label : "Todos"),
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

      body : tabs[_select_index], // body

      floatingActionButton: FloatingActionButton(
        child : const Icon(Icons.add),
        onPressed: () => showDialog(
          context: context, 
          builder: (BuildContext context) {
              return AlertDialog(
                content: Column(
                    mainAxisSize : MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Add Todo',
                        style : TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          fontFamily : "Merriweather",
                          color: Colors.deepOrangeAccent

                        )
                      ),
                       const SizedBox(height: 7),
                       TodoForm(
                         onChangedTitle: (title) => setState(() => this.title = title),
                         onChangedDescription: (description) => setState(()=> this.description = this.description),
                         onSavedTodo: (){},
                       ),
                    ],
                ),
              );
          },)
      ),
    );
  }
}
