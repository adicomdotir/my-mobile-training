import 'package:flutter/material.dart';

import '../../../../core/params/forecast_params.dart';

@immutable
abstract class HomeEvent {}

class LoadCwEvent extends HomeEvent {
  final String cityName;
  LoadCwEvent(this.cityName);
}

class LoadFwEvent extends HomeEvent {
  final ForecastParams forecastParams;
  LoadFwEvent(this.forecastParams);
}
