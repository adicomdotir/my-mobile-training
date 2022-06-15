import 'package:first_flutter/clean_architecture_app/data/data_source/remote_data_source.dart';
import 'package:first_flutter/clean_architecture_app/data/network/error_handler.dart';
import 'package:first_flutter/clean_architecture_app/data/network/network_info.dart';
import 'package:first_flutter/clean_architecture_app/domain/model/model.dart';
import 'package:first_flutter/clean_architecture_app/data/request/request.dart';
import 'package:first_flutter/clean_architecture_app/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:first_flutter/clean_architecture_app/domain/repository/repository.dart';
import 'package:first_flutter/clean_architecture_app/data/mapper/mapper.dart';

class RepositoryImpl implements Repository {
  RemoteDataSource _remoteDataSource;
  NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == 0) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.forgotPassword(email);

        if (response.status == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(response.status ?? ResponseCode.DEFAULT,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
