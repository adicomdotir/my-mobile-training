import 'package:first_flutter/my_money_app/expense.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:intl/intl.dart';

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
    List<Expense> allExpense = await databaseHelper.getAllExpense();
    allExpense.forEach((expense) {
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
    TextStyle headerTextStyle = TextStyle(
      fontSize: 24
    );TextStyle bodyTextStyle = TextStyle(
        fontSize: 20
    );

    map.forEach((key, value) {
      Column result = Column(children: [],);
      Map<String, String> newValue = value;
      newValue.forEach((key, value) {
        if (result.children.length != 0) {
          result.children.add(SizedBox(height: 4,));
        }
        if (key == 'title') {
          result.children.add(Text('$value', style: headerTextStyle,));
        } else if (key == 'sum') {
          var tmp = 'کل هزینه' + ' ' + numberFormat.format(int.parse(value));
          result.children.add(Text(tmp, style: bodyTextStyle,));
        } else {
          var tmp = '${key} ${numberFormat.format(int.parse(value))}';
          result.children.add(Text(tmp));
        }
      });
      setState(() {
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
        return jalali.year.toString() + ' فروردین';
      case 2:
        return jalali.year.toString() + ' اردیبهشت';
      case 3:
        return jalali.year.toString() + ' خرداد';
      case 4:
        return jalali.year.toString() + ' تیر';
      case 5:
        return jalali.year.toString() + ' مرداد';
      case 6:
        return jalali.year.toString() + 'شهریور ';
      case 7:
        return jalali.year.toString() + 'مهر ';
      case 8:
        return jalali.year.toString() + ' آبان';
      case 9:
        return jalali.year.toString() + ' آذر';
      case 10:
        return jalali.year.toString() + ' دی';
      case 11:
        return jalali.year.toString() + ' بهمن';
      case 12:
        return jalali.year.toString() + ' اسفند';
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
                return Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: Card(
                    child: myList[idx],
                  ),
                );
              })),
    );
  }
}
