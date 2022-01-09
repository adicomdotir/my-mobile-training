import 'package:first_flutter/quiz_app/screens/quiz/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(onPressed: () {}, child: Text('Skip'))
        ],
      ),
      body: Body(),
    );
  }
}