import 'dart:convert';

import 'package:first_flutter/my_money_app/add_edit_category_screen.dart';
import 'package:first_flutter/my_money_app/expense.dart';
import 'package:first_flutter/my_money_app/category.dart';
import 'package:first_flutter/my_money_app/helpers.dart';
import 'package:flutter/material.dart';

class BaseCategory extends StatefulWidget {
  BaseCategory({Key? key}) : super(key: key);

  @override
  _BaseCategoryState createState() => _BaseCategoryState();
}

class _BaseCategoryState extends State<BaseCategory> {
  List<Category> categoryList = [];
  int deleteId = 0;

  @override
  void initState() {
    dbSection();
    super.initState();
  }

  void dbSection() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    await databaseHelper.init();
    List<Category> result = await databaseHelper.getAllCategory();
    result.forEach((element) {
      print(element);
    });
    setState(() {
      categoryList = result;
    });
  }

  void dbDeleteSection() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    await databaseHelper.init();
    await databaseHelper
        .deleteCategory(deleteId)
        .then((value) => Navigator.of(context).pop());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Categories'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (builder) => AddEditCategoryScreen()))
                .then((value) => dbSection());
          },
        ),
        body: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
            itemCount: categoryList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 25,
                          color:
                              convertHexColorToRgb(categoryList[index].color),
                        ),
                        SizedBox(width: 16,),
                        GestureDetector(
                          child: Text(
                            '${categoryList[index].title}',
                            style: TextStyle(fontSize: 20),
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (builder) => AddEditCategoryScreen(
                                          category: categoryList[index],
                                        )))
                                .then((value) => dbSection());
                          },
                        ),
                      ],
                    ),
                    GestureDetector(
                        onTap: () {
                          deleteId = categoryList[index].id ?? 0;
                          _showMyDialog().then((value) => dbSection());
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ))
                  ],
                ),
              );
            }));
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Category'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Are your sure?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Okey'),
              onPressed: () {
                dbDeleteSection();
              },
            ),
            TextButton(
              child: Text('Cancel'),
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
