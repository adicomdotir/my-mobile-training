import '../../../../core/params/forecast_params.dart';
import '../../../../core/resources/data_state.dart';
import '../entities/current_city_entity.dart';
import '../entities/forecast_days_entity.dart';

abstract class WeatherRepository {
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(String cityName);

  Future<DataState<ForecastDaysEntity>> fetchForecastWeatherData(
      ForecastParams params);
}
