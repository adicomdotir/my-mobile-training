import 'package:first_flutter/quiz_app/constants.dart';
import 'package:first_flutter/quiz_app/controllers/question_controller.dart';
import 'package:first_flutter/quiz_app/models/questions.dart';
import 'package:first_flutter/quiz_app/screens/quiz/components/progress_bar.dart';
import 'package:first_flutter/quiz_app/screens/quiz/components/question_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController questionController = Get.put(QuestionController());
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/images/bg.svg',
          fit: BoxFit.fill,
        ),
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: ProgressBar(),
              ),
              SizedBox(
                height: kDefaultPadding,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Obx(() => Text.rich(TextSpan(
                    text: 'Question ${questionController.questionNumber}',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: kSecondaryColor),
                    children: [
                      TextSpan(
                          text: '/${questionController.questions.length}',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: kSecondaryColor)),
                    ])),
              )),
              Divider(
                thickness: 1.5,
              ),
              SizedBox(
                height: kDefaultPadding,
              ),
              Expanded(
                  child: PageView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: questionController.updateTheQnNum,
                    controller: questionController.pageController,
                      itemCount: questionController.questions.length,
                      itemBuilder: (ctx, index) => QuestionCard(
                            question: questionController.questions[index],
                          )))
            ],
          ),
        )
      ],
    );
  }
}
