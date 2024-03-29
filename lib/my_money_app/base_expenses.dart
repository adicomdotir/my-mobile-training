import 'dart:developer';

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
  late ScrollController _scrollController;
  List<Expense> expenseList = [];
  int deleteId = 0;
  int page = 0;
  String categoryValue = '-1';
  List<Category> categoryTitle = [
    Category(id: -1, title: 'همه', color: 'FFFFFF')
  ];
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    dbSection();
    _scrollController = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      page += 1;
      dbSection();
    }
  }

  void dbSection() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    await databaseHelper.init();
    List<Expense> result = await databaseHelper.getAllExpenseWithPage(page);
    setState(() {
      if (page == 0) {
        expenseList = result;
      } else {
        expenseList.addAll(result);
      }
    });
    List<Category> categoryList = await databaseHelper.getAllCategory();
    categoryTitle = [Category(id: -1, title: 'همه', color: 'FFFFFF')];
    categoryTitle.addAll(categoryList);
  }

  void dbFilterSection(
      DateTime startDate, DateTime endDate, String text) async {
    endDate = endDate.add(Duration(days: 1));
    DatabaseHelper databaseHelper = DatabaseHelper();
    await databaseHelper.init();
    List<Expense> result = await databaseHelper.getAllExpenseWithFilter(
        int.parse(categoryValue),
        startDate.microsecondsSinceEpoch,
        endDate.microsecondsSinceEpoch,
        text);
    setState(() {
      if (page == 0) {
        expenseList = result;
      } else {
        expenseList.addAll(result);
      }
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
          actions: [
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Icon(Icons.filter_alt_outlined),
              onTap: () {
                _showBottomSheet();
              },
            ),
            SizedBox(
              width: 16,
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text('اضافه کردن هزینه'),
          icon: Icon(Icons.add),
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
            controller: _scrollController,
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

  void _showBottomSheet() {
    TextEditingController controller = TextEditingController();

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        DateTime startDate = DateTime.now();
        Jalali jalaliStartDate = Jalali.fromDateTime(startDate);
        bool startDateSelected = false;
        DateTime endDate = DateTime.now();
        Jalali jalaliEndDate = Jalali.fromDateTime(endDate);
        bool endDateSelected = false;

        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: StatefulBuilder(
            builder: (ctx, StateSetter setState) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          labelText: 'متن جستجو',
                          labelStyle: TextStyle(color: Colors.black87),
                          enabledBorder: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.black87),
                          ),
                          focusedBorder: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.black87),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('از تاریخ'),
                          TextButton(
                              onPressed: () async {
                                var result = await _selectDate(context, startDate);
                                setState(() {
                                  jalaliStartDate = Jalali.fromDateTime(result);
                                  startDateSelected = true;
                                });
                              },
                              child: Text(startDateSelected
                                  ? '${jalaliStartDate.year}/${jalaliStartDate.month}/${jalaliStartDate.day}'
                                  : 'انتخاب نشده')),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('تا تاریخ'),
                          TextButton(
                              onPressed: () async {
                                var result = await _selectDate(context, endDate);
                                setState(() {
                                  jalaliEndDate = Jalali.fromDateTime(result);
                                  endDateSelected = true;
                                });
                              },
                              child: Text(endDateSelected
                                  ? '${jalaliEndDate.year}/${jalaliEndDate.month}/${jalaliEndDate.day}'
                                  : 'انتخاب نشده')),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'دسته',
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 0.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16)),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: categoryValue,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      categoryValue = newValue!;
                                    });
                                  },
                                  items: categoryTitle.map<DropdownMenuItem<String>>(
                                      (Category category) {
                                    return DropdownMenuItem<String>(
                                      value: category.id.toString(),
                                      child: Text(category.title),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                            child: Text('اعمال'),
                            onPressed: () {
                              dbFilterSection(
                                  startDateSelected
                                      ? jalaliStartDate.toDateTime()
                                      : DateTime(1970, 1, 1),
                                  jalaliEndDate.toDateTime(),
                                  controller.text);
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('لغو'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
          ),
        );
      },
    );
  }

  Future<DateTime> _selectDate(BuildContext context, DateTime date) async {
    Jalali? selected = await showPersianDatePicker(
      context: context,
      initialDate: Jalali.fromDateTime(date),
      firstDate: Jalali(1370, 1),
      lastDate: Jalali(1450, 1),
    );
    if (selected != null && selected != date) {
      return selected.toDateTime();
    }
    return DateTime.now();
  }
}
