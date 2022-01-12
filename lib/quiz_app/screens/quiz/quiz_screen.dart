import 'package:first_flutter/quiz_app/controllers/question_controller.dart';
import 'package:first_flutter/quiz_app/screens/quiz/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController questionController = Get.put(QuestionController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(onPressed: questionController.nextQuestion, child: Text('Skip'))
        ],
      ),
      body: Body(),
    );
  }
}