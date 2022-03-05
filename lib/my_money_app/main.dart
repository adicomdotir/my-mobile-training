import 'package:first_flutter/my_money_app/base_category.dart';
import 'package:first_flutter/my_money_app/base_expenses.dart';
import 'package:first_flutter/my_money_app/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_edit_expense_screen.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  void dbSection() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    await databaseHelper.init();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Money App'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (builder) => BaseCategory()));
                },
                child: Text('Categories')),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (builder) => BaseExpense()));
                },
                child: Text('Expenses'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (builder) => AddEditExpenseScreen()));
        },
      ),
    );
  }
}
