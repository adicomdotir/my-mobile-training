import 'dart:html';

import 'package:first_flutter/clean_app/app/datasources/remote_data_source.dart';
import 'package:first_flutter/clean_app/app/repositories/weather_repository_impl.dart';
import 'package:first_flutter/clean_app/domain/repositories/weather_repository.dart';
import 'package:first_flutter/clean_app/domain/usecases/get_current_weather.dart';
import 'package:first_flutter/clean_app/presentation/bloc/weather_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => WeatherBloc(locator()));

  // usecase
  locator.registerLazySingleton<GetCurrentWeather>(() => GetCurrentWeather(locator()));

  // repository
  locator.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(dataSource: locator()));

  // data source
  locator.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(client: locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
}