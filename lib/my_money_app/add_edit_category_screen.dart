import 'package:first_flutter/budget_app/data/data.dart';
import 'package:first_flutter/my_money_app/category.dart';
import 'package:first_flutter/my_money_app/expense.dart';
import 'package:flutter/material.dart';

class AddEditCategoryScreen extends StatefulWidget {
  Category? category;
  AddEditCategoryScreen({Key? key, this.category}) : super(key: key);

  @override
  _AddEditCategoryScreenState createState() => _AddEditCategoryScreenState();
}

class _AddEditCategoryScreenState extends State<AddEditCategoryScreen> {
  TextEditingController _titleCtrl = TextEditingController();

  @override
  void initState() {
    _titleCtrl.text = widget.category?.title ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.category == null
            ? Text('Add Category')
            : Text('Edit Category'),
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
                  labelText: "Title",
                )),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_titleCtrl.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter title')));
                  } else {
                    dbSection();
                  }
                },
                child: Text('Save'))
          ],
        ),
      ),
    );
  }

  void dbSection() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    await databaseHelper.init();
    if (widget.category == null) {
      Category category = Category(title: _titleCtrl.text);
      await databaseHelper.insertCategory(category);
    } else {
      Category category = Category(title: _titleCtrl.text);
      category.id = widget.category?.id;
      await databaseHelper.updateCategory(category);
    }
    Navigator.pop(context);
  }
}
