import 'package:first_flutter/my_money_app/add_edit_category_screen.dart';
import 'package:first_flutter/my_money_app/category.dart';
import 'package:first_flutter/my_money_app/expense.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class AddEditExpenseScreen extends StatefulWidget {
  Expense? expense;

  AddEditExpenseScreen({Key? key, this.expense}) : super(key: key);

  @override
  _AddEditExpenseScreenState createState() => _AddEditExpenseScreenState();
}

class _AddEditExpenseScreenState extends State<AddEditExpenseScreen> {
  TextEditingController _titleCtrl = TextEditingController();
  TextEditingController _priceCtrl = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String categoryValue = '';
  List<Category> categoryTitle = [];

  @override
  void initState() {
    dbSection();
    _titleCtrl.text = widget.expense?.title ?? '';
    _priceCtrl.text = widget.expense?.price ?? '';
    categoryValue = widget.expense?.categoryId.toString() ?? '';
    selectedDate = DateTime.fromMicrosecondsSinceEpoch(
        widget.expense?.date ?? DateTime.now().microsecondsSinceEpoch);
    super.initState();
  }

  void dbSection() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    await databaseHelper.init();
    List<Category> categoryList = await databaseHelper.getAllCategory();
    setState(() {
      categoryTitle = categoryList;
      if (categoryValue.isEmpty) {
        categoryValue = categoryTitle.first.id.toString();
      }
    });
  }

  void insertDbSection() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    await databaseHelper.init();
    int date = selectedDate.microsecondsSinceEpoch;
    Expense expense = Expense(
        title: _titleCtrl.text,
        price: _priceCtrl.text,
        categoryId: int.parse(categoryValue),
        date: date);
    if (widget.expense == null) {
      await databaseHelper.insertExpense(expense);
    } else {
      expense.id = widget.expense?.id;
      await databaseHelper.updateExpense(expense);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Jalali jalaliDate = Jalali.fromDateTime(selectedDate);
    return Scaffold(
      appBar: AppBar(
        title:
            widget.expense == null ? Text('هزینه جدید') : Text('ویرایش هزینه'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: _titleCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16)),
                  labelText: "عنوان",
                )),
            SizedBox(
              height: 16,
            ),
            TextField(
                controller: _priceCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16)),
                  labelText: "قیمت",
                )),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  child: Text(
                    'انتخاب تاریخ',
                  ),
                ),
                Text(
                  "${jalaliDate.year}/${jalaliDate.month}/${jalaliDate.day}",
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'دسته',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
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
                            .map<DropdownMenuItem<String>>((Category category) {
                          return DropdownMenuItem<String>(
                            value: category.id.toString(),
                            child: Text(category.title),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (builder) => AddEditCategoryScreen()))
                        .then((value) => dbSection());
                  },
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_titleCtrl.text.isEmpty ||
                      _priceCtrl.text.isEmpty ||
                      categoryValue.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('لطفا تمامی فیلدها را وارد نمایید')));
                  } else {
                    insertDbSection();
                  }
                },
                child:
                    widget.expense == null ? Text('ذخیره') : Text('بروز رسانی'))
          ],
        ),
      ),
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

    // final DateTime? selected = await showDatePicker(
    //   context: context,
    //   initialDate: selectedDate,
    //   firstDate: DateTime(2010),
    //   lastDate: DateTime(2025),
    // );
  }
}
