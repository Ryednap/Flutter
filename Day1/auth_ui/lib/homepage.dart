import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page")
      ),
      body: const Center(
        child: Text(
          'Hello World',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
            color: Colors.purpleAccent
          )
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: null, items: const [
          BottomNavigationBarItem(icon: Icon(Icons.account_box), label: "Account Box"),
          BottomNavigationBarItem(icon: Icon(Icons.mail_rounded), label: 'Mail Box'),
      ],
        iconSize: 32,
        elevation: 12,
        backgroundColor: Colors.limeAccent.shade100,
      ),
    );
  }
}
