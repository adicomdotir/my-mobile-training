import 'package:first_flutter/clean_app/app/failure.dart';
import 'package:first_flutter/clean_app/domain/entities/weather.dart';
import 'package:dartz/dartz.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName);
}