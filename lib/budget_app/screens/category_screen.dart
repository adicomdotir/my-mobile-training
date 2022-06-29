import 'package:first_flutter/budget_app/helpers/color_helper.dart';
import 'package:first_flutter/budget_app/models/category_model.dart';
import 'package:first_flutter/budget_app/models/expense_model.dart';
import 'package:first_flutter/budget_app/widgets/radial_painter.dart';
import 'package:first_flutter/food_delivery_app/models/restaurant.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;

  const CategoryScreen({required this.category});

  @override
  CategoryScreenState createState() => CategoryScreenState();
}

class CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    double totalAmountSpent = 0;
    widget.category.expenses.forEach((Expense expense) {
      totalAmountSpent += expense.cost;
    });
    final double amountLeft = widget.category.maxAmount - totalAmountSpent;
    final double percent = amountLeft / widget.category.maxAmount;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
            iconSize: 30,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2),
                        blurRadius: 6)
                  ]),
              child: CustomPaint(
                foregroundPainter: RadialPainter(
                    bgColor: Colors.grey,
                    lineColor: getColor(context, percent),
                    percent: percent,
                    width: 15),
                child: Center(
                  child: Text(
                    '\$${amountLeft.toStringAsFixed(2)} / \$${widget.category.maxAmount}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            _buildExpenses()
          ],
        ),
      ),
    );
  }

  _buildExpenses() {
    List<Widget> expenseList = [];
    widget.category.expenses.forEach((Expense expense) {
      expenseList.add(Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, offset: Offset(0, 2), blurRadius: 6)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(expense.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              Text(
                '-\$${expense.cost.toStringAsFixed(2)}',
                style: TextStyle(
                    color: Colors.red, fontSize: 20, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ));
    });
    return Column(children: expenseList);
  }
}
