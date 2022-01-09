import 'package:first_flutter/quiz_app/constants.dart';
import 'package:first_flutter/quiz_app/models/questions.dart';
import 'package:first_flutter/quiz_app/screens/quiz/components/progress_bar.dart';
import 'package:first_flutter/quiz_app/screens/quiz/components/question_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/images/bg.svg',
          fit: BoxFit.fill,
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProgressBar(),
                SizedBox(
                  height: kDefaultPadding,
                ),
                Text.rich(TextSpan(
                    text: 'Question 1',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: kSecondaryColor),
                    children: [
                      TextSpan(
                          text: '/10',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: kSecondaryColor)),
                    ])),
                Divider(
                  thickness: 1.5,
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                QuestionCard()
              ],
            ),
          ),
        )
      ],
    );
  }
}
