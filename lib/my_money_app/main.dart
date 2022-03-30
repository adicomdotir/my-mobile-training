import 'dart:convert';
import 'dart:io';

import 'package:first_flutter/my_money_app/base_category.dart';
import 'package:first_flutter/my_money_app/base_expenses.dart';
import 'package:first_flutter/my_money_app/expense.dart';
import 'package:first_flutter/my_money_app/helpers.dart';
import 'package:first_flutter/my_money_app/models/home_report_model.dart';
import 'package:first_flutter/my_money_app/report_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'add_edit_expense_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    localizationsDelegates: [
      GlobalCupertinoLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: [
      Locale("fa", "IR"),
    ],
    locale: Locale("fa", "IR"),
    debugShowCheckedModeBanner: false,
    themeMode: ThemeMode.dark,
    theme: ThemeData(
        fontFamily: 'IranYekan',
    ),
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
    var jalaliDate = Jalali.now();
    var tmpJalaliDate = Jalali(jalaliDate.year, jalaliDate.month);
    var thisMonth = tmpJalaliDate.toDateTime();

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
        child: Container(
          color: Theme.of(context).primaryColor,
          child: SafeArea(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    'منو',
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
                      child: Text(' دسته ها')),
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
                      child: Text('هزینه ها')),
                  SizedBox(
                    height: 4,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                            builder: (builder) => ReportScreen()))
                            .then((value) => dbSection());
                      },
                      child: Text('گزارش')),
                  SizedBox(
                    height: 4,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (builder) => RestoreScreen()));
                      },
                      child: Text('اضافه کردن هزینه ها با فایل'))
                ],
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(' پول من'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            expenseDurationBox('هزینه امروز', dayPrice),
            SizedBox(
              height: 16,
            ),
            expenseDurationBox('هزینه 7 روز گذشته', weekPrice),
            SizedBox(
              height: 16,
            ),
            expenseDurationBox('هزینه این ماه', thisMonthPrice),
            SizedBox(
              height: 16,
            ),
            expenseDurationBox('هزینه 30 روز گذشته', monthPrice),
            SizedBox(
              height: 32,
            ),
            Text(
              'هزینه های این ماه با دسته بندی'.toUpperCase(),
              style: TextStyle(fontSize: 18),
            ),
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
    final numberFormat = NumberFormat("#,###", "fa_IR");
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
                      '${numberFormat.format(reportModels[index].price)} تومان',
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
    final numberFormat = NumberFormat("#,###", "fa_IR");
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
            '${numberFormat.format(price)} تومان',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class RestoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اضافه کردن هزینه با فایل'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              filePicker(context);
            },
            child: Text(' اضافه کن')),
      ),
    );
  }

  void filePicker(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      file
          .openRead()
          .map(utf8.decode)
          .transform(new LineSplitter())
          .forEach((line) {
        var splitedLine = line.split(',');
        Expense expense = Expense(
            title: splitedLine[0],
            price: splitedLine[1],
            categoryId: int.parse(splitedLine[2]),
            date: convertStringDateToMilli(splitedLine[3]));
        insertDbSection(expense, context);
      });
    } else {
      // User canceled the picker
    }
  }

  int convertStringDateToMilli(String date) {
    List<String> splitedDate = date.split('/');
    Jalali dateTime = Jalali(int.parse(splitedDate[0]),
        int.parse(splitedDate[1]), int.parse(splitedDate[2]));
    return dateTime.toDateTime().microsecondsSinceEpoch;
  }

  void insertDbSection(Expense expense, BuildContext context) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    await databaseHelper.init();
    await databaseHelper.insertExpense(expense);
    // Navigator.of(context).pop();
  }
}
