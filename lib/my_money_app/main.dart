import 'package:first_flutter/my_money_app/base_category.dart';
import 'package:first_flutter/my_money_app/base_expenses.dart';
import 'package:first_flutter/my_money_app/expense.dart';
import 'package:first_flutter/my_money_app/helpers.dart';
import 'package:first_flutter/my_money_app/models/home_report_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  int thisMonthPrice = 0;
  List<HomeReportModel> reportModels = [];

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
    var thisMonth = DateTime(tmpDate.year, tmpDate.month);

    DatabaseHelper databaseHelper = DatabaseHelper();
    await databaseHelper.init();

    var dPrice = await databaseHelper
        .getAllExpenseAfterTime(today.microsecondsSinceEpoch);
    var wPrice = await databaseHelper
        .getAllExpenseAfterTime(week.microsecondsSinceEpoch);
    var mPrice = await databaseHelper
        .getAllExpenseAfterTime(month.microsecondsSinceEpoch);
    var _thisMonthPrice = await databaseHelper
        .getAllExpenseAfterTime(thisMonth.microsecondsSinceEpoch);
    List<HomeReportModel> _reportModels = await databaseHelper
        .getAllExpenseByCategoryAfterTime(thisMonth.microsecondsSinceEpoch);
    setState(() {
      dayPrice = dPrice;
      weekPrice = wPrice;
      monthPrice = mPrice;
      thisMonthPrice = _thisMonthPrice;
      reportModels = _reportModels;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            expenseDurationBox('Today Expense', dayPrice),
            SizedBox(
              height: 16,
            ),
            expenseDurationBox('Last 7 days Expense', weekPrice),
            SizedBox(
              height: 16,
            ),
            expenseDurationBox('This Month Expense', thisMonthPrice),
            SizedBox(
              height: 16,
            ),
            expenseDurationBox('Last 30 days Expense', monthPrice),
            SizedBox(
              height: 32,
            ),
            Text('This month expenses filter by category', style: TextStyle(fontSize: 20),),
            SizedBox(
              height: 16,
            ),
            ...List.generate(
                reportModels.length, (index) => reportModelWidget(index))
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

  Widget reportModelWidget(int index) {
    final numberFormat = NumberFormat("#,###", "en_US");
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 25,
                color: convertHexColorToRgb(reportModels[index].color),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      reportModels[index].title,
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '\$ ${numberFormat.format(reportModels[index].price)}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              )
            ],
          ),
          Container(
            width: double.maxFinite,
            height: 2,
            color: convertHexColorToRgb(reportModels[index].color),
          )
        ],
      ),
    );
  }

  Widget expenseDurationBox(String innerText, int price) {
    final numberFormat = NumberFormat("#,###", "en_US");
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color(0xFFC3A53C).withOpacity(0.25)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            innerText,
            style: TextStyle(fontSize: 16),
          ),
          Text(
            '\$ ${numberFormat.format(price)}',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
