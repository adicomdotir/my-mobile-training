import 'package:flutter/material.dart';

class Counter {
  int value = 0;

  void increment() => value++;

  void decrement() => value--;
}

void main() {
  runApp(CounterApp());
}

class CounterApp extends StatefulWidget {
  const CounterApp({Key? key}) : super(key: key);

  @override
  _CounterAppState createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Counter App'),
        ),
        body: Center(
            child: Text(
          counter.toString(),
          style: TextStyle(fontSize: 28, color: Colors.black),
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              counter++;
            });
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
