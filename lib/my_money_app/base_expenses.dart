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
    categoryTitle.addAll(categoryList);
  }

  void dbFilterSection() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    await databaseHelper.init();
    List<Expense> result = await databaseHelper.getAllExpenseWithFilter(
        int.parse(categoryValue),
        DateTime(2019, 1, 1).microsecondsSinceEpoch,
        DateTime.now().microsecondsSinceEpoch);
    setState(() {
      if (page == 0) {
        expenseList = result;
      } else {
        expenseList.addAll(result);
      }
    });
    List<Category> categoryList = await databaseHelper.getAllCategory();
    categoryTitle.addAll(categoryList);
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
                _showFilterDialog();
              },
            ),
            SizedBox(
              width: 16,
            )
          ],
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

  Future<void> _showFilterDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (ctx, StateSetter setState) {
          return AlertDialog(
            title: Text('فیلتر'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('از تاریخ'),
                      TextButton(
                          onPressed: () {
                            _selectDate(context);
                          },
                          child: Text('1400/01/01')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('تا تاریخ'),
                      TextButton(onPressed: () {}, child: Text('1400/01/01')),
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
                              items: categoryTitle
                                  .map<DropdownMenuItem<String>>(
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
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('اعمال'),
                onPressed: () {
                  dbFilterSection();
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
          );
        });
      },
    );
  }

  _selectDate(BuildContext context) async {
    Jalali? selected = await showPersianDatePicker(
      context: context,
      initialDate: Jalali.fromDateTime(selectedDate),
      firstDate: Jalali(1370, 1),
      lastDate: Jalali(1450, 1),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected.toDateTime();
      });
    }
  }
}
