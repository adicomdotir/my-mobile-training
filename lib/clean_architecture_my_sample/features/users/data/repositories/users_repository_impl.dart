import 'package:dartz/dartz.dart';
import 'package:first_flutter/clean_architecture_my_sample/core/error/exception.dart';
import 'package:first_flutter/clean_architecture_my_sample/core/error/failures.dart';
import 'package:first_flutter/clean_architecture_my_sample/core/network/network_info.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/users/data/datasources/users_local_data_source.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/users/data/datasources/users_remote_data_source.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/users/domain/entities/user.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/users/domain/repositories/users_repository.dart';

class UsersRepositoryImpl extends UsersRepository {
  final UsersRemoteDataSource remoteDataSource;
  final UsersLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UsersRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<User>>> getUsers() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteResult = await remoteDataSource.getUsers();
        final users = remoteResult.map((e) => e.toEntity()).toList();
        return Right(users);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localResult = await localDataSource.getLastUsers();
        final users = localResult.map((e) => e.toEntity()).toList();
        return Right(users);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
