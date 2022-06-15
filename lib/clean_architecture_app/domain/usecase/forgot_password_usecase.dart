import 'package:first_flutter/clean_architecture_app/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:first_flutter/clean_architecture_app/domain/repository/repository.dart';
import 'package:first_flutter/clean_architecture_app/domain/usecase/base_usecase.dart';

class ForgotPasswordUseCase implements BaseUseCase<String, String> {
  Repository _repository;

  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(String input) async {
    return await _repository.forgotPassword(input);
  }
}
