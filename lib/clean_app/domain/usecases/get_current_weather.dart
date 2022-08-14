import 'package:first_flutter/clean_app/app/failure.dart';
import 'package:first_flutter/clean_app/domain/entities/weather.dart';
import 'package:dartz/dartz.dart';
import 'package:first_flutter/clean_app/domain/repositories/weather_repository.dart';

class GetCurrentWeather {
  final WeatherRepository repository;

  const GetCurrentWeather(this.repository);

  Future<Either<Failure, Weather>> execute(String cityName) {
    return repository.getCurrentWeather(cityName);
  }

}