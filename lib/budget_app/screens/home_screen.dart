import 'package:first_flutter/budget_app/data/data.dart';
import 'package:first_flutter/budget_app/helpers/color_helper.dart';
import 'package:first_flutter/budget_app/models/category_model.dart';
import 'package:first_flutter/budget_app/widgets/bar_chart.dart';
import 'package:flutter/material.dart';

import 'category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _buildCategory(Category category, double totalAmountSpent) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryScreen(category: category)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.all(20),
        height: 100,
        width: double.infinity,
        decoration:
            BoxDecoration(
              borderRadius: BorderRadius.circular(10), boxShadow: [
          BoxShadow(color: Colors.black12, offset: Offset(0, 2), blurRadius: 6)
        ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text(
                  '\$${(category.maxAmount - totalAmountSpent).toStringAsFixed(2)} / \$${category.maxAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
              final double maxBarWidth = constraints.maxWidth;
              final double percent = (category.maxAmount - totalAmountSpent) / category.maxAmount;
              double barWidth = percent * maxBarWidth;
              if (barWidth < 0) {
                barWidth = 0;
              }
              
              return Stack(
                children: [
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  Container(
                    height: 20,
                    width: barWidth,
                    decoration: BoxDecoration(
                        color: getColor(context, percent),
                        borderRadius: BorderRadius.circular(15)),
                  )
                ],
              );
            })
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // pinned: true,
            floating: true,
            forceElevated: true,
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Simple Budget'),
            ),
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.settings),
              iconSize: 30,
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add),
                iconSize: 30,
              )
            ],
          ),
          SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
            if (index == 0) {
              return Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 2),
                          blurRadius: 6)
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: BarChart(
                  expenses: weeklySpending,
                ),
              );
            } else {
              final Category category = categories[index - 1];
              double totalAmountSpent = 0;
              category.expenses.forEach((expense) {
                totalAmountSpent += expense.cost;
              });
              return _buildCategory(category, totalAmountSpent);
            }
          }, childCount: 1 + categories.length))
        ],
      ),
    );
  }
}
