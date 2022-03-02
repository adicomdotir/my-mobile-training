import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Category {
  final int id;
  final String title;

  Category({required this.id, required this.title});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title};
  }
}

class DatabaseHelper {
  late Database db;

  DatabaseHelper();

  Future<void> init() async {
    String path = join(await getDatabasesPath() + 'database.db');
    db = await openDatabase(path, onCreate: (db, version) {
      return db
          .execute('CREATE TABLE category(id INTEGER PRIMARY KEY AUTOINCREMENT, title Text)');
    }, version: 2);
  }

  Future<void> insertCategory(Category category) async {
    await db
        .insert('category', category.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Category>> getAllCategory() async {
    final List<Map<String, dynamic>> maps = await db.query('category');
    return List.generate(maps.length,
        (idx) => Category(id: maps[idx]['id'], title: maps[idx]['title']));
  }

  Future<void> updateCategory(Category category) async {
    await db.update('category', category.toMap(),
        where: 'id = ?', whereArgs: [category.id]);
  }

  Future<void> deleteCategory(int id) async {
    await db.delete('category', where: 'id = ?', whereArgs: [id]);
  }
}
