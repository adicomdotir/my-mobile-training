import 'package:first_flutter/clean_architecture_app/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:first_flutter/clean_architecture_app/data/request/request.dart';
import 'package:first_flutter/clean_architecture_app/domain/model/model.dart';
import 'package:first_flutter/clean_architecture_app/domain/repository/repository.dart';
import 'package:first_flutter/clean_architecture_app/domain/usecase/base_usecase.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput input) async {
    return await _repository.register(RegisterRequest(
        input.countryMobileCode,
        input.username,
        input.password,
        input.email,
        input.mobileNumber,
        input.profilePicture));
  }
}

class RegisterUseCaseInput {
  String countryMobileCode;
  String username;
  String password;
  String email;
  String mobileNumber;
  String profilePicture;

  RegisterUseCaseInput(this.countryMobileCode, this.username, this.password,
      this.email, this.mobileNumber, this.profilePicture);
}
