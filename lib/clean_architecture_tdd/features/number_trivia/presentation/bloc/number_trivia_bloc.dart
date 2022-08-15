import 'package:bloc/bloc.dart';
import 'package:first_flutter/clean_architecture_tdd/core/error/failures.dart';
import 'package:first_flutter/clean_architecture_tdd/core/usecases/usecase.dart';
import 'package:first_flutter/clean_architecture_tdd/core/util/input_converter.dart';
import 'package:first_flutter/clean_architecture_tdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:first_flutter/clean_architecture_tdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:first_flutter/clean_architecture_tdd/features/number_trivia/presentation/bloc/bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc(
      {required GetConcreteNumberTrivia concrete,
      required GetRandomNumberTrivia random,
      required this.inputConverter})
      : getRandomNumberTrivia = random,
        getConcreteNumberTrivia = concrete,
        super(Empty()) {
    on<GetTriviaForConcreteNumber>((event, emit) {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);
      inputEither.fold(
          (failure) => emit(Error(message: INVALID_INPUT_FAILURE_MESSAGE)),
          (integer) async {
        emit(Loading());
        final failureOrTrivia =
            await getConcreteNumberTrivia(Params(number: integer));
        failureOrTrivia.fold((failure) {
          switch (failure.runtimeType) {
            case ServerFailure:
              return SERVER_FAILURE_MESSAGE;
            case CacheFailure:
              return CACHE_FAILURE_MESSAGE;
            default:
              return 'Unexpected error';
          }
        }, (trivia) => Loaded(trivia: trivia));
      });
    });

    on<GetTriviaForRandomNumber>((event, emit) async {
      emit(Loading());
      final failureOrTrivia = await getRandomNumberTrivia(NoParams());
      failureOrTrivia.fold((failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            return SERVER_FAILURE_MESSAGE;
          case CacheFailure:
            return CACHE_FAILURE_MESSAGE;
          default:
            return 'Unexpected error';
        }
      }, (trivia) => Loaded(trivia: trivia));
    });
  }
}
