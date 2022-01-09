import 'package:first_flutter/quiz_app/models/questions.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'option.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25)),
      child: Column(
        children: [
          Text(
            sample_data[0]['question'],
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: kBlackColor),
          ),
          SizedBox(height: kDefaultPadding / 2,),
          Option(),
          Option(),
          Option(),
          Option(),
        ],
      ),
    );
  }
}

