import '../../../../core/resources/data_state.dart';
import '../../domain/entities/current_city_entity.dart';
import '../../domain/repositories/weather_repository.dart';
import '../data_sources/remote/remote_data_source.dart';
import '../models/current_city_model.dart';
import 'package:dio/dio.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  RemoteDataSource dataSource;

  WeatherRepositoryImpl(this.dataSource);

  @override
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(
      String cityName) async {
    try {
      Response response = await dataSource.callCurrentWeather(cityName);
      if (response.statusCode == 200) {
        CurrentCityEntity currentCityEntity =
            CurrentCityModel.fromJson(response.data);

        return DataSuccess(currentCityEntity);
      } else {
        return const DataFailed("Something Went Wrong. try again...");
      }
    } catch (e) {
      return const DataFailed("please check your connection...");
    }
  }
}
