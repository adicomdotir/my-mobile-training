import 'package:bloc/bloc.dart';
import 'package:first_flutter/clean_architecture_tdd/core/error/failures.dart';
import 'package:first_flutter/clean_architecture_tdd/core/usecases/usecase.dart';
import 'package:first_flutter/clean_architecture_tdd/core/util/input_converter.dart';
import 'package:first_flutter/clean_architecture_tdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:first_flutter/clean_architecture_tdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:first_flutter/clean_architecture_tdd/features/number_trivia/presentation/bloc/bloc.dart';
import 'package:first_flutter/clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';

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
    on<GetTriviaForConcreteNumberInit>((event, emit) async {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);
      inputEither.fold(
          (failure) => emit(Error(message: INVALID_INPUT_FAILURE_MESSAGE)),
          (integer) async {
        emit(Loading());
        add(GetTriviaForConcreteNumber(integer));
      });
    });

    on<GetTriviaForRandomNumber>((event, emit) async {
      emit(Loading());
      final failureOrTrivia = await getRandomNumberTrivia(NoParams());
      failureOrTrivia.fold((failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            return Error(message: SERVER_FAILURE_MESSAGE);
          case CacheFailure:
            return Error(message: CACHE_FAILURE_MESSAGE);
          default:
            return Error(message: 'Unexpected error');
        }
      }, (trivia) => emit(Loaded(trivia: trivia)));
    });

    on<GetTriviaForConcreteNumber>((event, emit) async {
      final failureOrTrivia =
          await getConcreteNumberTrivia(Params(number: event.number));

      failureOrTrivia.fold((failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            return Error(message: SERVER_FAILURE_MESSAGE);
          case CacheFailure:
            return Error(message: CACHE_FAILURE_MESSAGE);
          default:
            return Error(message: 'Unexpected error');
        }
      }, (trivia) async {
        emit(Loaded(
            trivia: NumberTrivia(number: trivia.number, text: trivia.text)));
      });
    });
  }
}
