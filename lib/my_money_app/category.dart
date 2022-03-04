import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Category {
  int? id;
  String title;

  Category({this.id, required this.title});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title};
  }
}