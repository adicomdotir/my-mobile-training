import '../../../../core/params/forecast_params.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/forecast_days_entity.dart';
import '../repositories/weather_repository.dart';

class GetForecastWeatherUseCase
    implements UseCase<DataState<ForecastDaysEntity>, ForecastParams> {
  final WeatherRepository _weatherRepository;
  GetForecastWeatherUseCase(this._weatherRepository);

  @override
  Future<DataState<ForecastDaysEntity>> call(ForecastParams params) {
    return _weatherRepository.fetchForecastWeatherData(params);
  }
}
