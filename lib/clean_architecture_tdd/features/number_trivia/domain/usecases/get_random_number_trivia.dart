import 'package:dartz/dartz.dart';
import 'package:first_flutter/clean_architecture_tdd/core/error/failures.dart';
import 'package:first_flutter/clean_architecture_tdd/core/usecases/usecase.dart';
import 'package:first_flutter/clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:equatable/equatable.dart';
import 'package:first_flutter/clean_architecture_tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia extends UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}