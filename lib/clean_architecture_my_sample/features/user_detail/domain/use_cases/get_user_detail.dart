import 'package:first_flutter/clean_architecture_my_sample/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:first_flutter/clean_architecture_my_sample/core/usecases/usecase.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/user_detail/domain/repositories/user_detail_repository.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/users/domain/entities/user.dart';

class GetUserDetail extends UseCase<User, Params> {
  final UserDetailRepository userDetailRepository;

  GetUserDetail({required this.userDetailRepository});

  @override
  Future<Either<Failure, User>> execute(Params params) async {
    return await userDetailRepository.getUserDetail(params.userId);
  }

}

class Params extends Equatable {
  final int userId;

  Params({required this.userId});

  @override
  List<Object> get props => [userId];
}