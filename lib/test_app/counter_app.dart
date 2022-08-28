import 'dart:async';
import 'dart:math';

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
  late Future<int> future;
  StreamController<int> streamController = StreamController();
  int counter = 0;

  @override
  void initState() {
    future = getIntNumber();
    getStreamInt().listen((event) {
      print(event);
      streamController.add(event);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Counter App'),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      counter++;
                    });
                  },
                  child: Text('Click')),
              Text(
                counter.toString(),
                style: TextStyle(fontSize: 28, color: Colors.black),
              ),
              FutureBuilder<int>(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final int num = snapshot.data!;
                    return Text(num.toString());
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              StreamBuilder<int>(
                stream: streamController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final int num = snapshot.data!;
                    return Text(num.toString());
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              )
            ],
          ),
        ),
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

  Future<int> getIntNumber() async {
    await Future.delayed(Duration(milliseconds: 2000));
    return Random().nextInt(100);
  }

  Stream<int> getStreamInt() async* {
    for (var i = 0; i < 10; i++) {
      await Future.delayed(Duration(milliseconds: 1000));
      yield Random().nextInt(100);
    }
  }
}
