import 'package:auth_ui/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

void main () {

  runApp(
    Sizer(
      builder: ((context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Login_ui2',
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFecf1f3,)
          ),
          home: const LoginPage(),
        );
      }),
    )
  );
}
