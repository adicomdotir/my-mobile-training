import 'dart:async';

import 'package:first_flutter/my_money_app/models/home_report_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'category.dart';

class Expense {
  int? id;
  final String title;
  final String price;
  final int categoryId;
  final int date;
  final String? categoryTitle;
  final String? categoryColor;

  Expense(
      {this.id,
      required this.title,
      required this.price,
      required this.categoryId,
      required this.date,
      this.categoryTitle,
      this.categoryColor});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'categoryId': categoryId,
      'date': date,
      'price': price
    };
  }
}

class DatabaseHelper {
  late Database db;

  DatabaseHelper();

  Future<void> init() async {
    String path = join(await getDatabasesPath() + 'database.db');
    db = await openDatabase(path, onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE category(id INTEGER PRIMARY KEY AUTOINCREMENT, title Text, color Text)');
      await db.execute(
          'CREATE TABLE expense(id INTEGER PRIMARY KEY AUTOINCREMENT, title Text, date INTEGER, price Text, categoryId INTEGER, FOREIGN KEY (categoryId) REFERENCES category (id))');
    }, version: 1);
  }

  Future<void> insertExpense(Expense expense) async {
    await db.insert('expense', expense.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Expense>> getAllExpense() async {
    // final List<Map<String, dynamic>> maps = await db.query('expense');
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT expense.*, category.title AS categoryTitle, category.color AS categoryColor FROM expense INNER JOIN category on category.id = categoryId');
    return List.generate(
        maps.length,
        (idx) => Expense(
            id: maps[idx]['id'],
            title: maps[idx]['title'],
            price: maps[idx]['price'],
            date: maps[idx]['date'],
            categoryId: maps[idx]['categoryId'],
            categoryColor: maps[idx]['categoryColor'],
            categoryTitle: maps[idx]['categoryTitle']));
  }

  Future<int> getAllExpenseAfterTime(int micro) async {
    final List<Map<String, dynamic>> maps = await db
        .rawQuery('SELECT SUM(price) AS sum FROM expense WHERE date > $micro');
    try {
      return maps[0]['sum'];
    } catch (ex) {
      return 0;
    }
  }

  Future<List<HomeReportModel>> getAllExpenseByCategoryAfterTime(int micro) async {
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT SUM(price) AS price, category.title AS title, category.color AS color FROM expense INNER JOIN category ON categoryid = category.id WHERE date > $micro GROUP BY categoryid');
    return List.generate(
        maps.length,
        (idx) => HomeReportModel(
            title: maps[idx]['title'] ?? '',
            color: maps[idx]['color'] ?? '',
            price: maps[idx]['price'] ?? 0,));
  }

  Future<void> updateExpense(Expense expense) async {
    await db.update('expense', expense.toMap(),
        where: 'id = ?', whereArgs: [expense.id]);
  }

  Future<void> deleteExpense(int id) async {
    await db.delete('expense', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> insertCategory(Category category) async {
    await db.insert('category', category.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Category>> getAllCategory() async {
    final List<Map<String, dynamic>> maps = await db.query('category');
    return List.generate(
        maps.length,
        (idx) => Category(
            id: maps[idx]['id'],
            title: maps[idx]['title'],
            color: maps[idx]['color']));
  }

  Future<void> updateCategory(Category category) async {
    await db.update('category', category.toMap(),
        where: 'id = ?', whereArgs: [category.id]);
  }

  Future<void> deleteCategory(int id) async {
    await db.delete('category', where: 'id = ?', whereArgs: [id]);
  }
}
