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
  bool touch = false;
  late Offset position;

  void generateEmptyCell() {
    var random = Random();
    var i = random.nextInt(4);
    var j = random.nextInt(4);
    while (cell[i][j] != 0) {
      i = random.nextInt(4);
      j = random.nextInt(4);
    }
    setState(() {
      cell[i][j] = 2;
    });
  }

  void moveCellRight() {
    for (var i = 0; i < cell.length; i++) {
      for (var j = cell[i].length - 2; j >= 0; j--) {
        for (var k = j + 1; k < cell[i].length; k++) {
          setState(() {
            if (cell[i][j] == cell[i][k] || cell[i][k] == 0) {
              cell[i][k] += cell[i][j];
              cell[i][j] = 0;
            }
          });
        }
      }
    }
    generateEmptyCell();
  }

  void moveCellDown() {
    for (var i = 0; i < cell.length; i++) {
      for (var j = 1; j < cell[i].length; j++) {
        setState(() {
          cell[j][i] += cell[j - 1][i];
          cell[j - 1][i] = 0;
        });
      }
    }
  }

  void moveCellLeft() {
    for (var i = 0; i < cell.length; i++) {
      for (var j = cell[i].length - 2; j >= 0; j--) {
        for (var k = j + 1; k < cell[i].length; k++) {
          setState(() {
            if (cell[i][j] == cell[i][k] || cell[i][k] == 0) {
              cell[i][k] += cell[i][j];
              cell[i][j] = 0;
            }
          });
        }
      }
    }
  }

  void moveCellUp() {
    for (var i = 0; i < cell.length; i++) {
      for (var j = cell[i].length - 2; j >= 0; j--) {
        setState(() {
          cell[j][i] += cell[j + 1][i];
          cell[j + 1][i] = 0;
        });
      }
    }
  }

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
              child: Listener(
                onPointerDown: (e) {
                  setState(() {
                    touch = true;
                    position = e.position;
                  });
                },
                onPointerUp: (e) {
                  var hr = position.dx - e.position.dx;
                  var vr = position.dy - e.position.dy;
                  if (hr.abs() > vr.abs()) {
                    // horizontal move
                    if (hr < 0) {
                      moveCellRight();
                    } else {
                      moveCellLeft();
                    }
                  } else {
                    // vertical move
                    if (vr > 0) {
                      moveCellUp();
                    } else {
                      moveCellDown();
                    }
                  }
                  setState(() {
                    touch = false;
                  });
                },
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
        style: TextStyle(
            fontSize: 48,
            color: Color(0xFF796e64),
            fontWeight: FontWeight.w700),
      )),
    ));
  }

  getTextColor(int cell) {}

  getBackgroundColor(int cell) {
    switch (cell) {
      case 0:
        return Color(0xFFcfc1b2);
      case 2:
        return Color(0xFFf0e4d9);
      case 4:
        return Color(0xFFefe0c5);
      case 8:
        return Color(0xFFfcae6f);
      case 16:
        return Color(0xFFff9057);
      case 32:
        return Color(0xFFff7456);
      case 64:
        return Color(0xFFff5500);
      case 128:
        return Color(0xFFf1cf61);
      case 256:
        return Color(0xFFf2cc49);
    }
  }
}
