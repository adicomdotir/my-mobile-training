import 'package:first_flutter/my_money_app/expense.dart';
import 'package:first_flutter/my_money_app/helpers.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  void initState() {
    dbSection();
    super.initState();
  }

  void dbSection() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    await databaseHelper.init();
    Map<String, dynamic> map = {};
    Set<String> colors = {};
    List<Expense> allExpense = await databaseHelper.getAllExpense();
    allExpense.forEach((expense) {
      colors.add(expense.categoryColor ?? 'null');
      String dateKey =
          getDate(DateTime.fromMicrosecondsSinceEpoch(expense.date));
      if (map.containsKey(dateKey)) {
        if (map[dateKey].containsKey(expense.categoryTitle.toString())) {
          int tmpPrice =
              int.parse(map[dateKey][expense.categoryTitle.toString()]);
          tmpPrice += int.parse(expense.price);
          map[dateKey][expense.categoryTitle.toString()] = tmpPrice.toString();
        } else {
          map[dateKey][expense.categoryTitle.toString()] = expense.price;
        }
        int tmpPrice = int.parse(map[dateKey]['sum']);
        tmpPrice += int.parse(expense.price);
        map[dateKey]['sum'] = tmpPrice.toString();
      } else {
        map[dateKey] = Map<String, String>();
        map[dateKey]['title'] =
            getMonth(DateTime.fromMicrosecondsSinceEpoch(expense.date));
        map[dateKey]['sum'] = expense.price;
        map[dateKey][expense.categoryTitle.toString()] = expense.price;
      }
    });

    final numberFormat = NumberFormat("#,###", "fa_IR");
    TextStyle headerTextStyle = TextStyle(fontSize: 24);
    TextStyle bodyTextStyle = TextStyle(fontSize: 18);

    List<double> sum = [];
    List<List<double>> percent = [];

    map.forEach((key, value) {
      Column result = Column(
        children: [],
      );

      int tmpColorIndex = 0;
      Map<String, String> newValue = value;
      newValue.forEach((key, value) {
        if (result.children.length != 0) {
          result.children.add(SizedBox(
            height: 4,
          ));
        }
        if (key == 'title') {
          result.children.add(Text(
            '$value',
            style: headerTextStyle,
          ));
        } else if (key == 'sum') {
          result.children.add(SizedBox(height: 8));
          sum.add(double.parse(value));
          percent.add([]);
          var tmp = 'کل هزینه' +
              ' ' +
              numberFormat.format(int.parse(value)) +
              ' ' +
              'تومان';
          result.children.add(Text(
            tmp,
            style: bodyTextStyle,
          ));
          result.children.add(SizedBox(height: 16));
          result.children.add(Text('هزینه ها بر اساس دسته'));
        } else {
          var p = double.parse(value) / (sum[sum.length - 1]);
          percent[sum.length - 1].add(p);
          var tmp =
              '$key ${numberFormat.format(int.parse(value))}' + ' ' + 'تومان';
          result.children.add(Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                color: convertHexColorToRgb(colors.elementAt(tmpColorIndex++)),
                ),
              ),
              SizedBox(width: 10,),
              Text(
                tmp,
              ),
            ],
          ));
        }
      });

      List<Widget> chart = [];
      tmpColorIndex = 0;
      percent[percent.length - 1].forEach((element) {
        var percent = (element * 1000).toInt();
        chart.add(Expanded(
            flex: percent,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 2),
              color: convertHexColorToRgb(colors.elementAt(tmpColorIndex)),
              child: Text('${(percent / 10).round()} %', maxLines: 1,  style: TextStyle(color: generateOppositeColor(colors.elementAt(tmpColorIndex++)), overflow: TextOverflow.fade), textAlign: TextAlign.center,),
            )));
      });
      setState(() {
        result.children.add(SizedBox(height: 16));
        Container p = Container(
          width: double.infinity,
          child: Row(
            children: chart,
          ),
        );
        result.children.add(p);
        myList.add(result);
      });
    });
  }

  List<Column> myList = [];

  String getDate(DateTime dateTime) {
    Jalali jalali = Jalali.fromDateTime(dateTime);
    return '${jalali.year}/${jalali.month}';
  }

  String getMonth(DateTime dateTime) {
    Jalali jalali = Jalali.fromDateTime(dateTime);
    switch (jalali.month) {
      case 1:
        return ' فروردین' + ' ' + jalali.year.toString();
      case 2:
        return ' اردیبهشت' + ' ' + jalali.year.toString();
      case 3:
        return ' خرداد' + ' ' + jalali.year.toString();
      case 4:
        return ' تیر' + ' ' + jalali.year.toString();
      case 5:
        return ' مرداد' + ' ' + jalali.year.toString();
      case 6:
        return 'شهریور ' + ' ' + jalali.year.toString();
      case 7:
        return 'مهر ' + ' ' + jalali.year.toString();
      case 8:
        return ' آبان' + ' ' + jalali.year.toString();
      case 9:
        return ' آذر' + ' ' + jalali.year.toString();
      case 10:
        return ' دی' + ' ' + jalali.year.toString();
      case 11:
        return ' بهمن' + ' ' + jalali.year.toString();
      case 12:
        return ' اسفند' + ' ' + jalali.year.toString();
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' گزارش'),
      ),
      body: Center(
          child: ListView.builder(
              itemCount: myList.length,
              itemBuilder: (ctx, idx) {
                return Container(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myList[idx],
                    ),
                  ),
                );
              })),
    );
  }
}
