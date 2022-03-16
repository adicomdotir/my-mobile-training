import 'package:first_flutter/my_money_app/add_edit_category_screen.dart';
import 'package:first_flutter/my_money_app/add_edit_expense_screen.dart';
import 'package:first_flutter/my_money_app/expense.dart';
import 'package:first_flutter/my_money_app/category.dart';
import 'package:first_flutter/my_money_app/helpers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class BaseExpense extends StatefulWidget {
  BaseExpense({Key? key}) : super(key: key);

  @override
  _BaseExpenseState createState() => _BaseExpenseState();
}

class _BaseExpenseState extends State<BaseExpense> {
  List<Expense> expenseList = [];
  int deleteId = 0;

  @override
  void initState() {
    dbSection();
    super.initState();
  }

  void dbSection() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    await databaseHelper.init();
    List<Expense> result = await databaseHelper.getAllExpense();
    setState(() {
      expenseList = result;
    });
  }

  void dbDeleteSection() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    await databaseHelper.init();
    await databaseHelper
        .deleteExpense(deleteId)
        .then((value) => Navigator.of(context).pop());
  }

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat("#,###", "fa_IR");
    return Scaffold(
        appBar: AppBar(
          title: Text('هزینه ها'),
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
        body: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
            itemCount: expenseList.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 25,
                            width: 10,
                            color: convertHexColorToRgb(
                                expenseList[index].categoryColor ?? ''),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Container(
                            child: GestureDetector(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${expenseList[index].title}',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                      '${numberFormat.format(int.parse(expenseList[index].price))} تومان',
                                      style: TextStyle(fontSize: 16)),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                      '${millisecToDate(expenseList[index].date)}',
                                      style: TextStyle(fontSize: 16))
                                ],
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (builder) =>
                                            AddEditExpenseScreen(
                                              expense: expenseList[index],
                                            )))
                                    .then((value) => dbSection());
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('${expenseList[index].categoryTitle}'),
                          SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                              onTap: () {
                                deleteId = expenseList[index].id ?? 0;
                                _showMyDialog().then((value) => dbSection());
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }));
  }

  String millisecToDate(int millisec) {
    DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(millisec);
    Jalali jalali = Jalali.fromDateTime(dateTime);
    return "${jalali.year}/${jalali.month}/${jalali.day}";
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('حذف کردن هزینه'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('آیا مطمئن هستید؟'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('بله'),
              onPressed: () {
                dbDeleteSection();
              },
            ),
            TextButton(
              child: Text('خیر'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
