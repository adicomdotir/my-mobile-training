import 'dart:io';

import 'package:first_flutter/clean_app/app/datasources/remote_data_source.dart';
import 'package:first_flutter/clean_app/app/exception.dart';
import 'package:first_flutter/clean_app/domain/entities/weather.dart';
import 'package:first_flutter/clean_app/app/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:first_flutter/clean_app/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final RemoteDataSource dataSource;

  WeatherRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName) async {
    try {
      final result = await dataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
