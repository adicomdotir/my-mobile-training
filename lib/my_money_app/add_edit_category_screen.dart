import 'package:first_flutter/my_money_app/category.dart';
import 'package:first_flutter/my_money_app/expense.dart';
import 'package:flutter/material.dart';

class AddEditCategoryScreen extends StatefulWidget {
  const AddEditCategoryScreen({Key? key}) : super(key: key);

  @override
  _AddEditCategoryScreenState createState() => _AddEditCategoryScreenState();
}

class _AddEditCategoryScreenState extends State<AddEditCategoryScreen> {
  TextEditingController _titleCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
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
    Category category = Category(title: _titleCtrl.text);
    await databaseHelper.insertCategory(category);
    Navigator.pop(context);
  }
}
