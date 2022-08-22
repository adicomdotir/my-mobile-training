import 'package:dartz/dartz.dart';
import 'package:first_flutter/clean_architecture_my_sample/core/error/failures.dart';
import 'package:first_flutter/clean_architecture_my_sample/core/usecases/usecase.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/users/domain/entities/user.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/users/domain/repositories/users_repository.dart';

class GetUsers extends UseCase<List<User>, NoParams> {
  final UsersRepository repository;

  GetUsers(this.repository);

  @override
  Future<Either<Failure, List<User>>> execute(NoParams params) async {
    return await repository.getUsers();
  }
}