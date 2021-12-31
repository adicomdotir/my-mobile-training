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
        actions: [
          TextButton(onPressed: () {}, child: Text('Skip'))
        ],
      ),
      body: Stack(
        children: [
          SvgPicture.asset('assets/images/bg.svg', fit: BoxFit.fill,)
        ],
      ),
    );
  }
}