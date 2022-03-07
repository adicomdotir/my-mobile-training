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

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int dayPrice = 0;
  int weekPrice = 0;
  int monthPrice = 0;
  int yearPrice = 0;

  @override
  void initState() {
    dbSection();
    super.initState();
  }

  void dbSection() async {
    DateTime tmpDate = DateTime.now();
    var today = DateTime(tmpDate.year, tmpDate.month, tmpDate.day);
    var week = DateTime(tmpDate.year, tmpDate.month, tmpDate.day - 7);
    var month = DateTime(tmpDate.year, tmpDate.month - 1, tmpDate.day);
    var year = DateTime(tmpDate.year - 1, tmpDate.month, tmpDate.day);

    DatabaseHelper databaseHelper = DatabaseHelper();
    await databaseHelper.init();

    var dPrice = await databaseHelper
        .getAllExpenseAfterTime(today.microsecondsSinceEpoch);
    var wPrice = await databaseHelper
        .getAllExpenseAfterTime(week.microsecondsSinceEpoch);
    var mPrice = await databaseHelper
        .getAllExpenseAfterTime(month.microsecondsSinceEpoch);
    var yPrice = await databaseHelper
        .getAllExpenseAfterTime(year.microsecondsSinceEpoch);
    setState(() {
      dayPrice = dPrice;
      weekPrice = wPrice;
      monthPrice = mPrice;
      yearPrice = yPrice;
    });
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
              Text(
                'Menu',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              Divider(
                thickness: 1,
                height: 32,
                endIndent: 32,
                indent: 32,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (builder) => BaseCategory()))
                        .then((value) => dbSection());
                  },
                  child: Text('Categories')),
              SizedBox(
                height: 4,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (builder) => BaseExpense()))
                        .then((value) => dbSection());
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
          children: [
            SizedBox(height: 16,),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.black12
              ),
              child: Text('Day Expense \$$dayPrice', style: TextStyle(fontSize: 20),),
            ),
            SizedBox(height: 16,),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.black12
              ),
              child: Text('Week Expense: $weekPrice', style: TextStyle(fontSize: 20),),
            ),
            SizedBox(height: 16,),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.black12
              ),
              child: Text('Month Expense: $monthPrice', style: TextStyle(fontSize: 20),),
            ),
            SizedBox(height: 16,),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.black12
              ),
              child: Text('Year Expense: $yearPrice', style: TextStyle(fontSize: 20),),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (builder) => AddEditExpenseScreen()))
              .then((value) => dbSection());
        },
      ),
    );
  }
}
