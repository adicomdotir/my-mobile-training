import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Category {
  int? id;
  String title;
  String color;

  Category({this.id, required this.title, required this.color});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'color': color};
  }
}