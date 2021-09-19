import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import  'package:todo/page/home_page.dart';
import 'package:todo/provider/todo.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);
  static const String title = "Todo App";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodosProvider(), // Provider Listener
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title : title,
        theme : ThemeData(
          primarySwatch: Colors.purple,
          scaffoldBackgroundColor: const    Color(0xFFFCF8DB),
        ),
        home: const HomePage(),
      ),
    );
  }
}