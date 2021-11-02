import 'package:bookstore/auth/login_page.dart';
import 'package:bookstore/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

void main () {
  runApp(const Driver());
}


class Driver extends StatelessWidget {
  const Driver({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title : "BookStore",
      debugShowCheckedModeBanner: false,
      theme : ThemeData(
        primarySwatch : Colors.blue,
        scaffoldBackgroundColor : Colors.white10,
      ),
      home : const SplashScreen(),
    );
  }
}