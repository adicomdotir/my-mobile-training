import '../../../../core/resources/data_state.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/current_city_entity.dart';
import '../repositories/weather_repository.dart';

class GetCurrentWeatherUseCase
    extends UseCase<DataState<CurrentCityEntity>, String> {
  final WeatherRepository weatherRepository;
  GetCurrentWeatherUseCase(this.weatherRepository);

  @override
  Future<DataState<CurrentCityEntity>> call(String param) {
    return weatherRepository.fetchCurrentWeatherData(param);
  }
}
