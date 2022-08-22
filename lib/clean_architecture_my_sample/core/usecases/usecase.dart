import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:first_flutter/clean_architecture_my_sample/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> execute(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}