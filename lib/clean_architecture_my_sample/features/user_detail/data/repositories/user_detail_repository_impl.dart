import 'package:first_flutter/clean_architecture_my_sample/core/error/exception.dart';
import 'package:first_flutter/clean_architecture_my_sample/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:first_flutter/clean_architecture_my_sample/core/network/network_info.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/user_detail/data/repositories/data_sources/user_detail_local_data_source.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/user_detail/data/repositories/data_sources/user_detail_remote_data_source.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/user_detail/domain/repositories/user_detail_repository.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/users/domain/entities/user.dart';

class UserDetailRepositoryImpl extends UserDetailRepository {
  final UserDetailRemoteDataSource userDetailRemoteDataSource;
  final UserDetailLocalDataSource userDetailLocalDataSource;
  final NetworkInfo networkInfo;

  UserDetailRepositoryImpl(
      {required this.userDetailRemoteDataSource,
      required this.userDetailLocalDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, User>> getUserDetail(int userId) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteResult = await userDetailRemoteDataSource.getUserDetail(userId);
        userDetailLocalDataSource.cacheUserDetail(remoteResult);
        return Right(remoteResult.toEntity());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localResult = await userDetailLocalDataSource.getLastUserDetail();
        return Right(localResult.toEntity());
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
