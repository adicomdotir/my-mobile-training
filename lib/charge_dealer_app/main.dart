import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ChargeDealer());
}

class ChargeDealer extends StatefulWidget {
  const ChargeDealer({Key? key}) : super(key: key);

  @override
  _ChargeDealerState createState() => _ChargeDealerState();
}

class _ChargeDealerState extends State<ChargeDealer> {
  List imageOperator = [
    'assets/images/mci.png',
    'assets/images/mtn.png',
    'assets/images/rightel.png',
  ];
  List amount = [
    '10000',
    '20000',
    '50000',
    '100000',
    '200000',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Theme(
        data: ThemeData(fontFamily: 'IranYekan'),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Color(0xFFA8FFF9),
            body: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 90,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'ADICOM',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              color: Color(0xFF1B6C77)),
                        ),
                        Spacer(),
                        Text(
                          'خرید شارژ',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                              color: Color(0xFF1B6C77)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          'assets/images/logo.png',
                          width: 30,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xFFFCFBFB),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(24),
                    child: Card(
                      color: Color(0xFFF0FFFF),
                      elevation: 19,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              'اپراتور',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF1B6C77)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children:
                                  List.generate(imageOperator.length, (index) {
                                return Expanded(
                                    child: Image.asset(imageOperator[index]));
                              }),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'شماره موبایل',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14,
                                  color: Color(0xFF1B6C77)),
                            ),
                            Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 8),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: '',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintStyle: TextStyle(fontSize: 13)),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'مبلغ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14,
                                  color: Color(0xFF1B6C77)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
