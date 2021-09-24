import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/color_pallete.dart';
import 'package:todo/page/home_page.dart';
import 'package:todo/provider/todos_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String title = "Todo App";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodosProvider(), // Provider Listener
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primarySwatch: ColorPalette.customColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const HomePage(),
      ),
    );
  }
}
