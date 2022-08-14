import 'dart:convert';

import 'package:first_flutter/clean_app/app/constant.dart';
import 'package:first_flutter/clean_app/app/exception.dart';
import 'package:first_flutter/clean_app/app/models/weather_model.dart';
import 'package:first_flutter/clean_app/domain/entities/weather.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final result = await client.get(Uri.parse(Urls.baseUrl));
    if (result.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(result.body));
    } else {
      throw ServerException();
    }
  }
}
