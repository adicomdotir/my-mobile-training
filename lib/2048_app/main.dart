import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<List<int>> cell = [
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0],
  ];

  @override
  void initState() {
    var random = Random();
    for (var i = 0; i < 2; i++) {
      var i = random.nextInt(3);
      var j = random.nextInt(3);
      cell[i][j] = 2;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 3,
              child: Container(
                width: double.maxFinite,
                color: Color(0xFFfaf8ee),
              )),
          Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(5),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Color(0xFFbdad9e),
                ),
                child: Expanded(
                  child: Column(
                    children: [
                      buildRow(0),
                      buildRow(1),
                      buildRow(2),
                      buildRow(3),
                    ],
                  ),
                ),
              ),
              flex: 7),
        ],
      ),
    );
  }

  Expanded buildRow(int i) {
    return Expanded(
      child: Row(
        children: [
          buildCell(i, 0),
          buildCell(i, 1),
          buildCell(i, 2),
          buildCell(i, 3),
        ],
      ),
    );
  }

  Expanded buildCell(int i, int j) {
    return Expanded(
        child: Container(
          margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: getBackgroundColor(cell[i][j]),
      ),
      width: double.maxFinite,
      height: double.maxFinite,
      child: Center(
          child: Text(
        cell[i][j] == 0 ? '' : '${cell[i][j]}',
        style: TextStyle(fontSize: 48, color: Color(0xFF796e64), fontWeight: FontWeight.w700),
      )),
    ));
  }

  getTextColor(int cell) {

  }

  getBackgroundColor(int cell) {
    switch(cell) {
      case 0: return Color(0xFFcfc1b2);
      case 2: return Color(0xFFf0e4d9);
      case 4: return Color(0xFFefe0c5);
    }
  }
}
