import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CardTemplates(),
  ));
}

class CardTemplates extends StatefulWidget {
  const CardTemplates({Key? key}) : super(key: key);

  @override
  _CardTemplatesState createState() => _CardTemplatesState();
}

class _CardTemplatesState extends State<CardTemplates> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Sample'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Spacer(),
          HeadlineSubtitle(),
          Spacer(),
        ],
      ),
      backgroundColor: Colors.black54,
    );
  }
}

class Headline extends StatelessWidget {
  const Headline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: Container(
        width: 268,
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: Color(0xFFDEDEDE)),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Headline',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Please add your content here. Keep it short and simple. And smile :) ',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF666666)),
            ),
          ],
        ),
      ),
    );
  }
}

class HeadlineSubtitle extends StatelessWidget {
  const HeadlineSubtitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 268,
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: Color(0xFFDEDEDE)),
                ),
                SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Headline',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Subtitle',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF666666)),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 24,),
            Text(
                'Please add your content here. Keep it short and simple. And smile :) ',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF666666))),
          ],
        ),
      ),
    );
  }
}
