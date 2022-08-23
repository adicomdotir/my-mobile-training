import 'package:dartz/dartz.dart';
import 'package:first_flutter/clean_architecture_my_sample/core/error/failures.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/users/domain/entities/user.dart';

abstract class UserDetailRepository {
  Future<Either<Failure, User>> getUserDetail(int userId);
}