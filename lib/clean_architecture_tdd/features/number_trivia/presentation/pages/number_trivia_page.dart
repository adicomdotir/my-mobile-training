import 'package:first_flutter/clean_architecture_tdd/features/number_trivia/presentation/bloc/bloc.dart';
import 'package:first_flutter/clean_architecture_tdd/features/number_trivia/presentation/widgets/loading_widget.dart';
import 'package:first_flutter/clean_architecture_tdd/features/number_trivia/presentation/widgets/message_display.dart';
import 'package:first_flutter/clean_architecture_tdd/features/number_trivia/presentation/widgets/trivia_controls.dart';
import 'package:first_flutter/clean_architecture_tdd/features/number_trivia/presentation/widgets/trivia_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 10,),
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return MessageDisplay(message: 'Start searching!');
                  } else if (state is Loading) {
                    return LoadingWidget();
                  } else
                  if (state is Loaded) {
                    return TriviaDisplay(numberTrivia: state.trivia);
                  } else if (state is Error) {
                    return MessageDisplay(message: state.message);
                  }
                  return Container();
                },
              ),
              SizedBox(height: 20,),
              TriviaControls()
            ],
          ),
        ),
      ),
    );
  }
}
