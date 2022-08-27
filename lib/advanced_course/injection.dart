import 'package:first_flutter/advanced_course/features/weather/domain/use_cases/get_forecast_weather_usecase.dart';
import 'package:get_it/get_it.dart';

import 'features/weather/data/data_sources/remote/remote_data_source.dart';
import 'features/weather/data/repositories/weather_repository_impl.dart';
import 'features/weather/domain/repositories/weather_repository.dart';
import 'features/weather/domain/use_cases/get_current_weather_usecase.dart';
import 'features/weather/presentation/bloc/home_bloc.dart';

GetIt locator = GetIt.instance;

setup() async {
  locator.registerSingleton<RemoteDataSource>(RemoteDataSource());

  /// repositories
  locator
      .registerSingleton<WeatherRepository>(WeatherRepositoryImpl(locator()));

  /// use case
  locator.registerSingleton<GetCurrentWeatherUseCase>(
      GetCurrentWeatherUseCase(locator()));
  locator.registerSingleton<GetForecastWeatherUseCase>(
      GetForecastWeatherUseCase(locator()));

  locator.registerSingleton<HomeBloc>(HomeBloc(
      getCurrentWeatherUseCase: locator(),
      getForecastWeatherUseCase: locator()));
}
