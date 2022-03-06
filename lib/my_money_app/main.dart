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
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 32,
              ),
              Text('Menu', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
              Divider(
                thickness: 1,
                height: 32,
                endIndent: 32,
                indent: 32,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (builder) => BaseCategory()));
                  },
                  child: Text('Categories')),
              SizedBox(
                height: 4,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (builder) => BaseExpense()));
                  },
                  child: Text('Expenses'))
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('My Money App'),
      ),
      body: Center(
        child: Column(
          children: [],
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
