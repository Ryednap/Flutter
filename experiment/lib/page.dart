import 'package:flutter/material.dart';

class Page_ extends StatelessWidget {
  
  final _key = GlobalKey<_CounterState> ();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Hello World"),),
        body :  Center (child: Counter(key: _key),),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            var counter = _key.currentState!.counter;
            _key.currentState!.increment();
          },
        ),
    );
  }
}



class Counter extends StatefulWidget {
  const Counter({ Key? key }) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int counter = 0;
  void increment () => setState(() {
    counter++;
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child :  Text ("Counter : $counter")
    );
  }
}