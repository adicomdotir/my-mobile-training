import 'package:first_flutter/quiz_app/constants.dart';
import 'package:first_flutter/quiz_app/controllers/question_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController questionController = Get.put(QuestionController());
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset('assets/icons/bg.svg', fit: BoxFit.fill),
          Column(
            children: [
              Spacer(flex: 3,),
              Text(
                'Score',
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    ?.copyWith(color: kSecondaryColor),
              ),
              Spacer(),
              Text(
                '${questionController.correctAns * 10}/${questionController.questions.length * 10}',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: kSecondaryColor),
              ),
              Spacer(flex: 3,),
            ],
          )
        ],
      ),
    );
  }
}
