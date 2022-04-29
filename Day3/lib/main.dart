import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:home_ui/screens/auth/login.dart';
import 'package:home_ui/screens/auth/registration.dart';
import 'package:home_ui/screens/home/home_screen.dart';
import 'package:sizer/sizer.dart';

void main () async {
  // initialize Alarm manager
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();

  runApp(Sizer(builder: ((context, orientation, deviceType) {
    return MaterialApp(
      title: 'WeCare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFecf1f3),
      ),
      initialRoute: '/',
      routes: {
        '/': (context)  => const LoginPage(),
        '/home': (context) => const HomeScreen(),
        '/register' : (context) => const RegistrationScreen(),
        '/login' : (context) => const LoginPage(),
      },
    );
  })));
}