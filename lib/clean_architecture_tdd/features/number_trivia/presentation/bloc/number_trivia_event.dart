import 'package:equatable/equatable.dart';

abstract class NumberTriviaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  final int number;

  GetTriviaForConcreteNumber(this.number);

  @override
  List<Object?> get props => [number];
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {}
class GetTriviaForConcreteNumberInit extends NumberTriviaEvent {

  final String numberString;

  GetTriviaForConcreteNumberInit(this.numberString);

  @override
  List<Object?> get props => [numberString];
}