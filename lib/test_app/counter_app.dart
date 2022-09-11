// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

class User {
  final int id;
  final String username;
  final bool active;

  User(
    this.id,
    this.username,
    this.active,
  );

  User copyWith({
    int? id,
    String? username,
    bool? active,
  }) {
    return User(
      id ?? this.id,
      username ?? this.username,
      active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'active': active,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['id'] as int,
      map['username'] as String,
      map['active'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'User(id: $id, username: $username, active: $active)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.username == username &&
        other.active == active;
  }

  @override
  int get hashCode => id.hashCode ^ username.hashCode ^ active.hashCode;
}

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

class AnimController extends StatefulWidget {
  const AnimController({Key? key}) : super(key: key);

  @override
  State<AnimController> createState() => _AnimControllerState();
}

class _AnimControllerState extends State<AnimController>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
