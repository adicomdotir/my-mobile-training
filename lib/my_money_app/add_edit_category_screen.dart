import 'package:first_flutter/budget_app/data/data.dart';
import 'package:first_flutter/my_money_app/category.dart';
import 'package:first_flutter/my_money_app/expense.dart';
import 'package:first_flutter/my_money_app/helpers.dart';
import 'package:flutter/material.dart';

class AddEditCategoryScreen extends StatefulWidget {
  Category? category;

  AddEditCategoryScreen({Key? key, this.category}) : super(key: key);

  @override
  _AddEditCategoryScreenState createState() => _AddEditCategoryScreenState();
}

class _AddEditCategoryScreenState extends State<AddEditCategoryScreen> {
  TextEditingController _titleCtrl = TextEditingController();
  TextEditingController _colorCtrl = TextEditingController();
  String color = 'ffffff';

  @override
  void initState() {
    _titleCtrl.text = widget.category?.title ?? '';
    _colorCtrl.text = widget.category?.color ?? '';
    color = widget.category?.color ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.category == null
            ? Text('دسته جدید')
            : Text('ویرایش دسته'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            widget.category == null
            ? Container()
            : Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(bottom: 16),
              child: Text('کد' + ': ${widget.category?.id}', style: TextStyle(color: Colors.grey),)),
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
            Row(
              children: [
                Expanded(
                  child: TextField(
                      onChanged: (value) {
                        if (value.length == 6) {
                          setState(() {
                            color = _colorCtrl.text;
                          });
                        }
                      },
                      controller: _colorCtrl,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        labelText: "رنگ",
                      )),
                ),
                SizedBox(width: 16),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: convertHexColorToRgb(color),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_titleCtrl.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('لطفا عنوان را وارد نمایید')));
                  } else {
                    dbSection();
                  }
                },
                child: widget.category == null ? Text('ذخیره') : Text('بروز رسانی'))
          ],
        ),
      ),
    );
  }

  void dbSection() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    await databaseHelper.init();
    if (widget.category == null) {
      Category category = Category(title: _titleCtrl.text, color: color);
      await databaseHelper.insertCategory(category);
    } else {
      Category category = Category(title: _titleCtrl.text, color: color);
      category.id = widget.category?.id;
      await databaseHelper.updateCategory(category);
    }
    Navigator.pop(context);
  }
}
